data "aws_ami" "dast_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["EasyBuggy"]
  }
}

data "aws_vpc" "dast_vpc" {
    filter{
        name = "tag:Name"
        values = ["NotDefault"]
    }
}

data "aws_subnet" "dast_subnet" {
    vpc_id = data.aws_vpc.dast_vpc.id
    id = "subnet-021a667a9cc5f3707"
}