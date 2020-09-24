//Provide AWS Access key and Secret key to execute terraform

provider "aws" {
    access_key = "XXXXXXX"
    secret_key = "YYYYYYY"
    region = "us-east-1"
    
}

//Craete Security group

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-03fce764d6d3fdd1f"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
}

//Create TG

resource "aws_lb_target_group" "tg" {
  name     = "NLB-TG"
  port     = 80
  protocol = "TCP"
  vpc_id   = "vpc-03fce764d6d3fdd1f"
 
}

//Create NLB

resource "aws_lb" "nlb" {
  name               = "aws-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["subnet-034250c45e4a08fbf","subnet-0d47b4ff30b766a68","subnet-0e603ab3ebf20d410"]

} 


//Create Elastic IP address for NAT GW

resource "aws_eip" "lb" {
  vpc      = true
}










