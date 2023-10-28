include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform{
  source="../../modules/vpc"
}

inputs = {
  #######################vpc########################
  environment="Dev"
  vpc_cidr_block=["172.16.0.0/16"]
  create_internet_gateway = true
  create_route = true
  create_route_table = true
  public_subnets=["172.16.0.0/24"]
  private_subnets=["172.16.100.0/24"]
  azs=["us-east-1a"]
  create_security_group = true
  port=[80,443,22]  
  
}