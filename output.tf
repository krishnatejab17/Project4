output "ecr_repository_url" {
  value = aws_ecr_repository.project1.repository_url
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_role.arn
}
output "project1_ecs_sg_id" {
  value = aws_security_group.project1_ecs_sg.id
}
output "alb_dns_name" {
  value = aws_lb.project1_alb.dns_name
}
