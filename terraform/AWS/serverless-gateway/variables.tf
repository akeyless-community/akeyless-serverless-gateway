# Use your required AWS Profile here for authentication
variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}
# Use your required AWS region here
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "image_tag" {
  description = "Image tag of the image from AWS Public ECR Image Gallery we are pulling from"
  type        = string
  default     = "0.3.9"
}

variable "create_log_group_for_lambda" {
  description = "Set to true to create the CloudWatch log group"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_lambda_name" {
  description = "This is the name of the Cloudwatch log group for Lambda"
  type        = string
  default     = "akeyless-serverless-gateway-lambda-log-group"
}

variable "ecr_repo_name" {
  description = "This is the name of the Private ECR repo to store the container image"
  type        = string
  default     = "akeyless-serverless-gateway-repo-for-lambda"
}
variable "ecr_tags" {
  description = "tags for ECR"
  type        = map(string)
  default     = {}
}
variable "api_gw_tags" {
  description = "tags for API GW"
  type        = map(string)
  default     = {}
}
variable "lambda_tags" {
  description = "tags for Lambda"
  type        = map(string)
  default     = {}
}
variable "ecr_force_delete" {
  description = "will delete the repository even if it contains images"
  type        = bool
  default     = false
}

variable "lambda_func_name" {
  description = "Then name of the lambda function"
  type        = string
  default     = "akeyless-serverless-gateway"
}

variable "lambda_role_name" {
  description = "The name of the IAM role to be assumed by AWS lambda function"
  type        = string
  default     = "iam-role-for-serverless-akeyless-gateway-lambda"
}

variable "vpc_subnet_ids" {
  description = "For network connectivity to AWS resources in a VPC, specify a list of security groups and subnets in the VPC"
  type        = list(string)
  default     = []
}
variable "vpc_security_group_ids" {
  description = "For network connectivity to AWS resources in a VPC, specify a list of security groups in the VPC"
  type        = list(string)
  default     = []
}



variable "cloudwatch_event_rule_name" {
  description = "The name of the Cloudwatch Event Rule"
  type        = string
  default     = "akeyless-serverless-gateway-keepalive"
}

variable "lambda_memory_size" {
  description = "AWS Lambda Memory Size"
  type        = string
  default     = "512"
}

variable "lambda_timeout" {
  description = "Amount of time your Lambda Function has to run in seconds, has to be set to the highest value 900 seconds"
  type        = string
  default     = "900"
}

variable "cloudwatch_event_rule_description" {
  description = "The description of the Cloudwatch Event Rule"
  type        = string
  default     = "Triggers the Akeyless Serverless Gateway Lambda Function at regular intervals"
}

variable "cloudwatch_event_rule_schedule" {
  description = "The Schedule Expression for the Cloudwatch Event Role for the Akeyless Serverless Gateway Lambda Function"
  type        = string
  default     = "rate(2 minutes)"
}

variable "api_gw_name" {
  description = "The name of the Akeyless Serverless Gateway API-Gateway"
  type        = string
  default     = "akeyless-serverless-gateway-api-gateway"
}
variable "api_gw_desc" {
  description = "The description of the Akeyless Serverless Gateway API-Gateway"
  type        = string
  default     = "Akeyless Serverless Gateway API-Gateway"
}

variable "api_gw_deploy_stage_name" {
  description = "The Stage name for the Akeyless Serverless Gateway API Gateway Deployment"
  type        = string
  default     = "default"
}

variable "func_logging_policy_name" {
  description = "name of the function logging policy"
  type        = string
  default     = "function-logging-policy"
}

