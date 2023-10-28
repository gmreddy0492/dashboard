# Generate Providers block

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
 terraform {
   required_providers {
     aws = {
      source  = "hashicorp/aws"
      version = "5.21.0"
    }
    null = {
      version = "~> 3.1.1"
    }
    template ={
       version= "~> 2.2.0" 
     }
   }
   required_version = "~> 1.2.9"
 }
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      resourceowner =   "DevopsTeam"
      environment1   =   "Development"
      projectname1  =   "Dashboard"
    }
  }
 }
 EOF
}


download_dir = abspath("G:\\My Drive\\MyDocuments\\Projects\\Dashboard\\Devops\\monitoringdashboard_terraform\\.terragrunt-cache")