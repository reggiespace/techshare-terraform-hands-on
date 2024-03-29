resource "aws_vpc" "new_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.prefix}-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnets" {
  count                   = 2
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "new_igw" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "new_route_table" {
  vpc_id = aws_vpc.new_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new_igw.id
  }
  tags = {
    Name = "${var.prefix}-rtb"
  }
}

resource "aws_route_table_association" "new_rtb_association" {
  count          = 2
  route_table_id = aws_route_table.new_route_table.id
  subnet_id      = aws_subnet.subnets.*.id[count.index]
}

resource "aws_security_group" "new_sg" {
  name_prefix = var.prefix
  vpc_id      = aws_vpc.new_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
