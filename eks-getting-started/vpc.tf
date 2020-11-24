#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "rypock" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "terraform-eks-rypock-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "rypock" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.rypock.id

  tags = map(
    "Name", "terraform-eks-rypock-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "rypock" {
  vpc_id = aws_vpc.rypock.id

  tags = {
    Name = "terraform-eks-rypock"
  }
}

resource "aws_route_table" "rypock" {
  vpc_id = aws_vpc.rypock.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rypock.id
  }
}

resource "aws_route_table_association" "rypock" {
  count = 2

  subnet_id      = aws_subnet.rypock.*.id[count.index]
  route_table_id = aws_route_table.rypock.id
}
