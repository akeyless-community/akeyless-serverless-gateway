resource "aws_lambda_permission" "lambda_permission" {
  depends_on    = [aws_api_gateway_integration.proxy]
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_func.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*/*"
  lifecycle {
    replace_triggered_by = [
      aws_lambda_function.lambda_func
    ]
  }
}

resource "aws_lambda_permission" "lambda_permission_root" {
  statement_id  = "AllowAPIGatewayInvokeRoot"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_func.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*/"
  lifecycle {
    replace_triggered_by = [
      aws_lambda_function.lambda_func
    ]
  }
}

resource "aws_api_gateway_rest_api" "rest_api" {
  name               = var.api_gw_name
  description        = var.api_gw_desc
  binary_media_types = ["image/*"]

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "proxy_root_response" {

  http_method = aws_api_gateway_method.proxy_root.http_method
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}


resource "aws_api_gateway_integration_response" "proxy_root_integration_response" {
  depends_on  = [aws_api_gateway_method_response.proxy_root_response, aws_api_gateway_integration.proxy_root]
  http_method = aws_api_gateway_method.proxy_root.http_method
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  status_code = aws_api_gateway_method_response.proxy_root_response.status_code
}

resource "aws_api_gateway_integration" "proxy_root" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_method.proxy_root.resource_id
  http_method             = aws_api_gateway_method.proxy_root.http_method
  cache_key_parameters    = []
  content_handling        = "CONVERT_TO_TEXT"
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.lambda_func.invoke_arn
}


resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy.http_method
  content_handling        = "CONVERT_TO_TEXT"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_func.invoke_arn
  passthrough_behavior    = "WHEN_NO_MATCH"
  request_parameters      = {}
  request_templates       = {}
  cache_key_parameters = [
    "method.request.path.proxy",
  ]

}

resource "aws_api_gateway_deployment" "api_gw_deployment" {
  depends_on = [
    aws_api_gateway_integration.proxy_root,
    aws_api_gateway_integration.proxy,
  ]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  stage_name  = var.api_gw_deploy_stage_name
}