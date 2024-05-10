locals {
  akeyless_serverless_gateway_url = aws_lambda_function.lambda_func.environment[0].variables.CLUSTER_URL
}
resource "aws_lambda_function" "lambda_func" {
  depends_on    = [skopeo2_copy.image_copy, aws_cloudwatch_log_group.lambda_logs]
  function_name = var.lambda_func_name
  role          = aws_iam_role.iam_for_lambda.arn
  image_uri     = "${aws_ecr_repository.ecr_repo.repository_url}:${var.image_tag}"
  package_type  = "Image"
  memory_size   = var.lambda_memory_size
  tags          = var.lambda_tags
  timeout       = var.lambda_timeout

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []

    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }

  environment {
    variables = {
      INITIAL_DISPLAY_NAME       = var.initial_display_name
      AKEYLESS_URL               = var.akeyless_url
      CLUSTER_NAME               = var.cluster_name
      ADMIN_ACCESS_ID_TYPE       = var.admin_access_id_type
      ADMIN_ACCESS_ID            = base64encode(var.admin_access_id)
      AKEYLESS_ACCOUNT_ID        = var.akeyless_account_id
      ADMIN_ACCESS_KEY           = var.admin_access_id_type == "aws_iam" ? "" : var.admin_access_key
      CUSTOMER_FRAGMENTS         = jsonencode(var.customer_fragments)
      ALLOWED_ACCESS_PERMISSIONS = var.allowed_access_permissions
      CLUSTER_URL                = "https://${data.aws_api_gateway_rest_api.rest_api.id}.execute-api.${var.region}.amazonaws.com/${var.api_gw_deploy_stage_name}/console"

    }
  }
}

data "aws_api_gateway_rest_api" "rest_api" {
  depends_on = [aws_api_gateway_rest_api.rest_api]
  name       = var.api_gw_name
  tags       = var.api_gw_tags
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  count = var.create_log_group_for_lambda ? 1 : 0 # Conditionally create the log group for Lambda
  name  = var.cloudwatch_log_group_lambda_name
}

resource "aws_iam_role_policy_attachment" "function_logging_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.id
  policy_arn = aws_iam_policy.function_logging_policy.arn
}

resource "aws_iam_policy" "function_logging_policy" {
  name = var.func_logging_policy_name
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          Action : [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:CreateLogGroup",
          ],
          Effect : "Allow",
          Resource : "arn:aws:logs:*:*:*"
        }
      ]
    }
  )
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = var.lambda_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}