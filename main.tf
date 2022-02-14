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

resource "aws_lambda_function" "terraform_lambda_demo" {
  filename      = "target/demo-1.0.0.jar"
  function_name = "terraformLambdaDemo"
  role          = "arn:aws:iam::695663959248:role/service-role/lambdaDemo-role-43z4u7dd"
  handler       = "com.javaxp.lambda.demo.LambdaFunctionHandler::handleRequest"
  runtime       = "java11"

  tags = {
    Name = "terraformLambdaDemo"
  }
}