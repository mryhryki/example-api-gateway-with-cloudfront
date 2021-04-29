resource "aws_lambda_function" "example" {
  function_name = "${local.project_name}-example"
  handler       = "index.handler"
  role          = aws_iam_role.iam_for_example.arn
  runtime       = "nodejs14.x"
  filename      = "lambda/lambda.zip"
}

resource "aws_lambda_permission" "lambda_permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.example.execution_arn}/*/*/example"
}

resource "aws_iam_role" "iam_for_example" {
  name = "${local.project_name}-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
