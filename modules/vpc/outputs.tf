output "vpc_id" {
  value = aws_vpc.new_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.subnets[*].id
}

output "security_group_id" {
  value = aws_security_group.new_sg.id
}

output "za" {
  value = data.aws_availability_zones.available.names
}
