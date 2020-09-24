//create Private Servers-1,2,3.

 resource "aws_instance" "server-1" {
    ami = "ami-00514a528eadbc95b"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "AWS_KeyPair"
    subnet_id = "subnet-0febc75bdca1a539b"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true	
    user_data = "${file("script1.sh")}"
    tags = {
        Name = "Private-Server-1"
    }
} 

resource "aws_instance" "server-2" {
    ami = "ami-00514a528eadbc95b"
    availability_zone = "us-east-1b"
    instance_type = "t2.micro"
    key_name = "AWS_KeyPair"
    subnet_id = "subnet-09f3748a93e1261ae"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true	
    user_data = "${file("script2.sh")}"
    tags = {
        Name = "Private-Server-2"
    }
} 

resource "aws_instance" "server-3" {
    ami = "ami-00514a528eadbc95b"
    availability_zone = "us-east-1c"
    instance_type = "t2.micro"
    key_name = "AWS_KeyPair"
    subnet_id = "subnet-0fe01486fd69660bc"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true	
    user_data = "${file("script3.sh")}"
    tags = {
        Name = "Private-Server-3"
    }
} 

//Attach Private servers to TG.

resource "aws_lb_target_group_attachment" "tg1" {
  target_group_arn = "${aws_lb_target_group.tg.arn}"
  target_id        = "${aws_instance.server-1.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg2" {
  target_group_arn = "${aws_lb_target_group.tg.arn}"
  target_id        = "${aws_instance.server-2.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg3" {
  target_group_arn = "${aws_lb_target_group.tg.arn}"
  target_id        = "${aws_instance.server-3.id}"
  port             = 80
}

//Attach TG to NLB

 resource "aws_lb_listener" "web" {
  load_balancer_arn = "${aws_lb.nlb.arn}"
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tg.arn}"
  }
}   