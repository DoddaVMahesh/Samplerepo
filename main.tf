variable "region" {
}

variable "instance_type" {

}

data "aws_vpc" "test-vpc" {
    id = "vpc-0698c2792c3c3aa56"
}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.test-vpc.id]
  }
}

data "aws_subnet" "subnetid"{
    filter {
        name   = "tag:zone"
        values = [var.region]
    }

}


resource aws_instance test-instance  {
    
    count = 4
    ami = "ami-07d4917b6f95f5c2a"
    instance_type = "t2.micro"
    subnet_id  = "data.aws_subnet.subnetid.id"
    

    tags = {
      Name = "test"
    }
}