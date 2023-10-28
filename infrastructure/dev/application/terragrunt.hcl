include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform{
  source = "../../modules/ec2"
}

inputs = {
  ami             = "ami-0261755bbcb8c4a84"
  instance_type   = "t2.micro"
  environment     = "Dev"
  publicsubnet    = dependency.vpc.outputs.public_subnet_ids
  vpc_security_group_ids = dependency.vpc.outputs.security_group_ids
  os_version = "2022"
  ami_name="ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
  
}

dependency "vpc" {
  config_path = "../vpc"
}
