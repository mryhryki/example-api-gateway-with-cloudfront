resource "aws_apigatewayv2_api" "example" {
  name          = "${local.project_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "example" {
  api_id      = aws_apigatewayv2_api.example.id
  name        = "dev"
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "example" {
  api_id    = aws_apigatewayv2_api.example.id
  route_key = "GET /example"

  target = "integrations/${aws_apigatewayv2_integration.example.id}"
}

resource "aws_apigatewayv2_integration" "example" {
  api_id             = aws_apigatewayv2_api.example.id
  description        = "${local.project_name}-endopoint"
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.example.invoke_arn
  integration_method = "POST"
}

output "api_gateway_url" {
  value = "https://${aws_apigatewayv2_integration.example.api_id}.execute-api.${local.aws_region}.amazonaws.com/${aws_apigatewayv2_stage.example.name}/example"
}
