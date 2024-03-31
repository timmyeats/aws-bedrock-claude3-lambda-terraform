module "lambda_function" {
  source          = "terraform-aws-modules/lambda/aws"
  version         = "7.2.5"
  function_name   = "aws-bedrock-claude3-integrate-lambda"
  description     = "The Lambda to integrates with AWS Bedrock Claude3 AI Model"
  source_path     = "../src/main.py"
  handler         = "main.lambda_handler"
  runtime         = "python3.12"
  timeout         = 300
  publish         = true
  create_role     = true
  attach_policies = true
  build_in_docker = true

  create_lambda_function_url = true
  environment_variables = {
  }
  number_of_policies = 2
  policies = [
    data.aws_iam_policy.lambda_basic_execution.arn,
    data.aws_iam_policy.bedrock_full_access.arn,
  ]
  layers = [
    module.lambda_layer.lambda_layer_arn,
  ]
  tags = var.resource_tags
}

module "lambda_layer" {
  source                   = "terraform-aws-modules/lambda/aws"
  version                  = "7.2.5"
  layer_name               = "aws-bedrock-claude3-integrate-lambda-layer"
  description              = "The Lambda Layer to integrates with AWS Bedrock Claude3 AI Model"
  create_function          = false
  create_layer             = true
  build_in_docker          = true
  runtime                  = "python3.12"
  compatible_runtimes      = ["python3.12"]
  compatible_architectures = ["x86_64", "arm64"]
  source_path              = "../src/layer/requirements.txt"
  tags                     = var.resource_tags
}
