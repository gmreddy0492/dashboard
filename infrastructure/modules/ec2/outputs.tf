
output "public_ips" {
  value = aws_eip.elastic_ip.public_ip
}   

