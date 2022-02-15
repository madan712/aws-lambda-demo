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
  build_file = "target/demo-1.0.0.jar"
}

resource "aws_lambda_function" "aws_lambda_demo" {
  filename      = local.build_file
  function_name = "awsLambdaDemo"
  role          = "arn:aws:iam::695663959248:role/service-role/lambdaDemo-role-43z4u7dd"
  handler       = "com.javaxp.lambda.demo.LambdaFunctionHandler::handleRequest"
  runtime       = "java11"
  environment {
    variables = {
      DD_API_KEY : "91a59e96b66828d2c05c441ba6c09b4e",
      JAVA_TOOL_OPTIONS : "-javaagent:'/opt/java/lib/dd-java-agent.jar'",
      DD_LOGS_INJECTION : true,
      DD_JMXFETCH_ENABLED : false,
      DD_TRACE_ENABLED : true
    }
  }
  tags = {
    DD_ENV     = "dev",
    DD_SERVIC  = "datadog",
    DD_VERSION = 1.0
  }
}