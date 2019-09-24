resource "aws_lambda_function" "post-tips-lambda" {
  function_name = "codingTips-post"

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket = "${var.s3_bucket}"
  s3_key = "v${var.lambda_version}/postTipLambda.zip"

  # "main" is the filename within the zip file (getTipsLambda.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler = "postTipLambda.handler"
  runtime = "nodejs8.10"
  memory_size = 128

  role = "${aws_iam_role.lambda-iam-role.arn}"
}

resource "aws_lambda_permission" "api-gateway-invoke-post-tip-lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.post-tips-lambda.arn}"
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_deployment.codingtips-api-gateway-deployment.execution_arn}/POST/api"
}
