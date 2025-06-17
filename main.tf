terraform {
  required_providers {
    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "3.2.0"
    }
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "random" {}
provider "aws" {}

data "aws_region" "current" {}

resource "random_pet" "name" {

}

resource "aws_ssm_parameter" "secret" {
  name        = "/orange_app_client_secret/${random_pet.name.id}/value"
  description = "Orange app client secret"
  type        = "SecureString"
  value       = var.orange_app_client_secret
}


variable "orange_app_client_id" {
  type = string
}

variable "orange_app_client_secret" {
  type = string
  sensitive = true
}

variable "orange_api_sms_sender_id" {
  type = string
}

output "ORANGE_APP_CLIENT_ID" {
  value = var.orange_app_client_id
}

output "ORANGE_APP_CLIENT_SECRET" {
  value = aws_ssm_parameter.secret.arn
}

output "ORANGE_API_URL" {
  value = "https://api.orange.com"
}

output "ORANGE_API_SMS_SENDER_ID" {
  value = var.orange_api_sms_sender_id
}