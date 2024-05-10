output "aws_api_gateway_rest_api" {
  description = "The arn of the Created API Gateway"
  value       = aws_api_gateway_rest_api.rest_api.arn
}
output "aws_lambda_function" {
  description = "The arn of the created Lambda function"
  value       = aws_lambda_function.lambda_func.arn
}

output "repository_url" {
  description = "The ECR image URI"
  value       = aws_ecr_repository.ecr_repo.repository_url
}
output "akeyless_serverless_gateway_url" {
  value = local.akeyless_serverless_gateway_url
}