output "vpc_id" { value = aws_vpc.test-vpc.id }

output "pub_subnet_ids" { value = aws_subnet.public-1.id }

output "pri_subnet1_ids" { value = aws_subnet.private-1.id }

output "pri_subnet2_ids" { value = aws_subnet.private-2.id }
