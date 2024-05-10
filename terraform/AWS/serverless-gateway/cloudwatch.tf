resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name                = var.cloudwatch_event_rule_name
  description         = var.cloudwatch_event_rule_description
  schedule_expression = var.cloudwatch_event_rule_schedule
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  target_id = aws_lambda_function.lambda_func.id
  arn       = aws_lambda_function.lambda_func.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_execution" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_func.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_event_rule.arn
}