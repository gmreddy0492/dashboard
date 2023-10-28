resource "aws_vpc" "vpc" {
  count = "${length(var.vpc_cidr_block)>0 ? length(var.vpc_cidr_block):0}"
  cidr_block       = "${element(var.vpc_cidr_block[*],0)}"
  instance_tenancy = "default"

  tags = {
    Name        = "vpc-${var.environment}-${var.projectname}"
    environment = "${var.environment}"
    projectname = "${var.projectname}"
  }
}

################## SUBNET ###########

resource "aws_subnet" "public_subnet" {
  
  count                     = "${length(var.public_subnets) > 0 &&
                               length(var.azs) > 0 && 
                               length(var.vpc_cidr_block)>0 &&
                               length(var.azs) >= length(var.public_subnets) ? length(var.public_subnets) : 0}"
  vpc_id                    = "${element(aws_vpc.vpc[*].id,0)}"
  cidr_block                = "${var.public_subnets[count.index]}"
  availability_zone         = "${var.azs[count.index]}"
  map_public_ip_on_launch   = false
  tags = {
    Name        = "PublicSubnet-${var.environment}-${var.projectname}_${count.index+1}"
    environment = "${var.environment}"
    projectname = "${var.projectname}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                     = "${length(var.private_subnets) > 0 &&
                               length(var.azs) > 0 && 
                               length(var.vpc_cidr_block)>0 && 
                               length(var.azs) >= length(var.private_subnets) ? length(var.private_subnets) : 0}"
  vpc_id                    = "${element(aws_vpc.vpc[*].id,0)}"
  cidr_block                = "${var.private_subnets[count.index]}"
  availability_zone         = "${var.azs[count.index]}"
  map_public_ip_on_launch   = false
  tags = {
    Name        = "PrivateSubnet-${var.environment}-${var.projectname}_${count.index+1}"
    environment = "${var.environment}"
    projectname = "${var.projectname}"
  }
}

############################## IGW ##############################

resource "aws_internet_gateway" "igw" {
    count = "${var.create_internet_gateway ? 1 : 0}"
    
    tags = {
      Name        = "IGW-${var.environment}-${var.projectname}"
      environment = "${var.environment}"
      projectname = "${var.projectname}"
  }
}



resource "aws_internet_gateway_attachment" "igw_attachment" {
  count              = "${length(var.vpc_cidr_block)>0 && var.create_internet_gateway ? 1 : 0}"
  #"${var.create_internet_gateway_attachment ? 1 : 0}"
  internet_gateway_id = "${aws_internet_gateway.igw[0].id}"
  vpc_id              = "${element(aws_vpc.vpc[*].id,0)}"
  depends_on          = [ aws_vpc.vpc,aws_internet_gateway.igw ]
  
}




################## RT ###############################

resource "aws_route_table" "rt" {
  count = "${var.create_route_table && length(var.vpc_cidr_block)>0  ? 1 : 0}"
  vpc_id = "${element(aws_vpc.vpc[*].id,0)}"

  tags = {
      Name        = "RT-${var.environment}-${var.projectname}"
      environment = "${var.environment}"
      projectname = "${var.projectname}"
  }
}


resource "aws_route" "route" {
  count = "${var.create_route && var.create_route_table && var.create_internet_gateway ? 1 : 0}"
  route_table_id            = "${aws_route_table.rt[0].id}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = "${aws_internet_gateway.igw[0].id}"
  #depends_on                = [ aws_route_table.rt,aws_internet_gateway.igw ]
}


resource "aws_route_table_association" "rta_pub_subnet" {
  #depends_on     = [ aws_route_table.rt,aws_subnet.public_subnet ]
  count          =  "${var.create_route_table && length(var.public_subnets)>0 ? length(var.public_subnets) : 0}"
  subnet_id      = "${aws_subnet.public_subnet[count.index].id}"
  route_table_id = "${element(aws_route_table.rt[*].id, 0)}"
  
}


######################### SG ##############################


resource "aws_security_group" "websg" {
  
  count  = "${var.create_security_group && length(var.vpc_cidr_block)>0 ? 1 : 0}"
  name   = "SG-${var.environment}-${var.projectname}"
  vpc_id = "${element(aws_vpc.vpc[*].id,0)}"

  tags = {
      Name        = "SG-${var.environment}-${var.projectname}"
      environment = "${var.environment}"
      projectname = "${var.projectname}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  #depends_on = [ aws_security_group.sg ]
  count = "${length(var.port) > 0 && var.create_security_group ? length(var.port) : 0}"
  security_group_id = "${aws_security_group.websg[0].id}"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "${var.port[count.index]}"
  ip_protocol = "tcp"
  to_port     = "${var.port[count.index]}"
  description = "Allow ingress port - ${var.port[count.index]}"
  tags = {
      Name        = "Ingress rule-${var.port[count.index]}"
      environment = "${var.environment}"
      projectname = "${var.projectname}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress" {
  
  count = "${length(var.port) > 0 && var.create_security_group ? length(var.port) : 0}"
  security_group_id = "${aws_security_group.websg[0].id}"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "${var.port[count.index]}"
  ip_protocol = "tcp"
  to_port     = "${var.port[count.index]}"
  description = "Allow egress port - ${var.port[count.index]}"
  tags = {
      Name        = "egress rule-${var.port[count.index]}"
      environment = "${var.environment}"
      projectname = "${var.projectname}"
  }
}



