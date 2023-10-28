

# ------- module/main.tf
resource "tls_private_key" "tls_priv_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an EC2 key pair
resource "aws_key_pair" "ec2_key_pair" {
  key_name = "wmskpi-key-pair"
  public_key = "${tls_private_key.tls_priv_key.public_key_openssh}"  # Replace with your desired key pair name
}

# Output the private key to a local file
resource "local_file" "private_key_file" {
  filename = "${var.ec2_key_pair_path}${aws_key_pair.ec2_key_pair.key_name}-${var.environment}.pem"  # Replace with your desired filename
  content  = tls_private_key.tls_priv_key.private_key_pem
}



resource "aws_instance" "web" {
  count      = "${length(var.publicsubnet)>= length(var.vpc_security_group_ids) ? length(var.publicsubnet) : 0}"
  ami           = "${var.ami}"#"${data.aws_ami.custom.id}"
  instance_type = "${var.instance_type}"
  subnet_id     = var.publicsubnet[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name      = aws_key_pair.ec2_key_pair.key_name
  tags = {
    Name        = "ec2-${var.environment}-${var.projectname}"
    environment = "${var.environment}"
    projectname = "${var.projectname}"
  }
}

#allocate public ip
resource "aws_eip" "elastic_ip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.web[0].id}"
  allocation_id = "${aws_eip.elastic_ip.id}"
}
