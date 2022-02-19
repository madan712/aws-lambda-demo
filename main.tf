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

locals {
  build_file = "C:\buildkite-agent\builds\MadanPC-1\javaxp\aws-lambda-pipeline\target\demo-1.0.3-shaded.jar"
}

resource "aws_lambda_function" "aws_lambda_demo" {
  filename      = local.build_file
  function_name = "awsLambdaDemo"
  role          = "arn:aws:iam::695663959248:role/service-role/lambdaDemo-role-43z4u7dd"
  handler       = "com.javaxp.lambda.demo.LambdaFunctionHandler::handleRequest"
  runtime       = "java11"
}

