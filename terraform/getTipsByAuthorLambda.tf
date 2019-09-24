resource "aws_lambda_function" "get-tips-by-author-lambda" {
  function_name = "codingTips-getTipsByAuthorLambda"

  s3_bucket = "${var.s3_bucket}"
  s3_key = "v${var.lambda_version}/getTipsByAuthorLambda.zip"

  handler = "getTipsByAuthorLambda.handler"
  memory_size = 128
  runtime = "nodejs8.10"

  role = "${aws_iam_role.lambda-iam-role.arn}"
}

resource "aws_lambda_permission" "api-gateway-invoke-get-tips-by-author-lambda" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:Invokefunction"
  function_name = "${aws_lambda_function.get-tips-by-author-lambda.arn}"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.codingtips-api-gateway-deployment.execution_arn}/GET/authors/{author}"
}
