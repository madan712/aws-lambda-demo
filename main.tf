variable "build" {}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_lambda_function" "aws_lambda_demo" {
  filename         = var.build
  function_name    = "awsLambdaDemo"
  role             = "arn:aws:iam::695663959248:role/lambda-role"
  handler          = "com.javaxp.lambda.demo.LambdaFunctionHandler::handleRequest"
  runtime          = "java11"
  source_code_hash = filebase64sha256(var.build)
}