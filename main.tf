provider "aws" {
  region = "us-east-1"
}

# OIDC Identity Provider for GitHub Actions
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # GitHub's official thumbprint
}

# IAM Role for GitHub Actions
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-oidc-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.github.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          "token.actions.githubusercontent.com:sub": "repo:krishnatejab17/Project1:ref:refs/heads/main"
        }
      }
    }
  ]
}
EOF
}

#ECS cluster 
resource "aws_ecs_cluster" "project1_cluster" {
  name = "project1-ecs-cluster"
}

#ECS Task Definition
resource "aws_ecs_task_definition" "project1_task" {
  family                   = "project1-task-definition"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "project1-container"
      image     = "${aws_ecr_repository.project1.repository_url}:${var.image_tag}"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "project1_service" {
  name            = "project1-service"
  cluster         = aws_ecs_cluster.project1_cluster.id
  task_definition = aws_ecs_task_definition.project1_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = data.aws_subnets.default_subnets.ids
    security_groups = [aws_security_group.project1_ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.project1_tg.arn
    container_name   = "project1-container"
    container_port   = 80
  }

  depends_on = [
    aws_lb_listener.project1_listener,
    aws_iam_role.ecs_task_execution_role
  ]
}

resource "aws_lb_listener" "project1_listener" {
  load_balancer_arn = aws_lb.project1_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project1_tg.arn
  }
}
