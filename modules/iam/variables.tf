variable "github_actions_role_name" {
  description = "The name of the IAM role for GitHub Actions"
  type        = string
  default     = "github-actions-ecs-role"
}