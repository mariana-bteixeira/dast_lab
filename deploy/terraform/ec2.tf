module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "DAST-Test-Server"

  ami                    = "${data.aws_ami.dast_ami.id}"
  instance_type          = "t3.large"
  key_name               = "DASTServer"
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.dast-sg.id}"]
  subnet_id              = "${data.aws_subnet.dast_subnet.id}"
  associate_public_ip_address =  true

  tags = {
    Terraform   = "true"
    Cx-Owner    = "ron.ben-moshe@checkmarx.com"
    Cx-Product  = "DAST"
  }
}

resource "aws_security_group" "dast-sg" {
  name = "DAST-Test-Server-SG"
  description = "Allow HTTP&SSH Traffic for DAST"
  vpc_id = data.aws_vpc.dast_vpc.id
  ingress = [ {
    cidr_blocks = [ "31.168.164.190/32" ]
    description = "SSH Access from internal network"
    from_port = 22
    to_port = 22
    protocol = "TCP"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false

  },{
    cidr_blocks = [ "31.168.164.190/32" ]
    description = "Access http from internal network"
    from_port = 8080
    to_port = 8080
    protocol = "TCP"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false    
  },{
    cidr_blocks = [ "3.120.214.171/32","3.126.230.210/32","3.74.225.192/32" ]
    description = "Access http from Canary"
    from_port = 8080
    to_port = 8080
    protocol = "TCP"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false    
  }
   ]
  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Access to internet"
    from_port = 0
    protocol = "-1"
    to_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false    
  } ]
}

