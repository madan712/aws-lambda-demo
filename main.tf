terraform {
  backend "remote" {
    organization = "JavaXp"
    workspaces {
      name = "demo-workspaces"
    }
  }
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

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "./target/demo-1.0.0.jar"
  output_path = "./target/demo.zip"
}

resource "aws_lambda_function" "aws_lambda_demo" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "awsLambdaDemo"
  role             = "arn:aws:iam::695663959248:role/service-role/lambdaDemo-role-43z4u7dd"
  handler          = "com.javaxp.lambda.demo.LambdaFunctionHandler::handleRequest"
  runtime          = "java11"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

