
output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
  }

  output "vpc_id" {
  value = aws_vpc.vpc.*.id
  }


  output "security_group_ids" {
  value = aws_security_group.websg.*.id
  }

