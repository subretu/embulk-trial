output "vpc_id" { value = aws_vpc.test-vpc.id }

output "pub_subnet_id" { value = aws_subnet.public-1.id }

output "pri_subnet1_id" { value = aws_subnet.private-1.id }

output "pri_subnet2_id" { value = aws_subnet.private-2.id }
