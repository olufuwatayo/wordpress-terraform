/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}
/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.public1.id}"
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name        = "nat-gateway"
    Environment = "${var.environment}"
  }
}

/* Private subnet */
resource "aws_subnet" "private_subnet1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${var.region}a"
  cidr_block              = "${var.private_subnet1_cidr}"
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.environment}-private-subnet"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  availability_zone       = "${var.region}b"
  cidr_block              = "${var.private_subnet2_cidr}"
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.environment}-private-subnet"
    Environment = "${var.environment}"
  }
}
/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name        = "${var.environment}-private-route-table"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

resource "aws_route_table_association" "private1" {

  subnet_id      = "${aws_subnet.private_subnet1.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private2" {

  subnet_id      = "${aws_subnet.private_subnet2.id}"
  route_table_id = "${aws_route_table.private.id}"
}