resource "aws_lambda_function" "example" {
  function_name = "${local.project_name}-example"
  handler = "index.handler"
  role = aws_iam_role.iam_for_example.arn
  runtime = ""
}

resource "aws_iam_role" "iam_for_example" {
  name = "iam_for_lambda"

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
