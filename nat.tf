//craete NGW

 resource "aws_nat_gateway" "natgw" {
    
  allocation_id = "${aws_eip.lb.id}"
  subnet_id     = "subnet-034250c45e4a08fbf"

  tags = {
    Name = "NAT-GW"
  }
}
//create RT for NAT GW

resource "aws_route_table" "NAT-RT" {

  vpc_id = "vpc-03fce764d6d3fdd1f"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgw.id}"
  }
   tags = {
    Name = "NAT-RT"
  }
}

//create route table association

resource "aws_route_table_association" "RouteTableAss" {
   subnet_id      = "subnet-0febc75bdca1a539b"
  route_table_id = "${aws_route_table.NAT-RT.id}"
}