output "vpc" {
  value = data.aws_vpc.dast_vpc.id
}
output "ami" {
  value = data.aws_ami.dast_ami.id
}

output "ip" {
    value = module.ec2_instance.public_ip
}