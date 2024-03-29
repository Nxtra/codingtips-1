resource "aws_api_gateway_rest_api" "codingtips-api-gateway" {
  name        = "CodingTipsAPI"
  description = "API to access codingtips application"
  body        = "${data.template_file.codingtips_api_swagger.rendered}"
}

data "template_file" codingtips_api_swagger{
  template = "${file("swagger.yaml")}"

  vars = {
    get_tips_lambda_arn = "${aws_lambda_function.get-tips-lambda.invoke_arn}"
    get_tips_by_author_arn = "${aws_lambda_function.get-tips-by-author-lambda.invoke_arn}"
    post_tip_lambda_arn = "${aws_lambda_function.post-tips-lambda.invoke_arn}"
  }
}

resource "aws_api_gateway_deployment" "codingtips-api-gateway-deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.codingtips-api-gateway.id}"
  stage_name  = "default"
}

output "url" {
  value = "${aws_api_gateway_deployment.codingtips-api-gateway-deployment.invoke_url}/api"
}
