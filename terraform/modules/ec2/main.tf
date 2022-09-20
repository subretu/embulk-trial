#--------------------------------------------------------------
# EC2
#--------------------------------------------------------------

resource "aws_instance" "embulk-sample" {
  ami                  = "ami-0f36dcfcc94112ea1"
  instance_type        = "t2.micro"
  iam_instance_profile = var.iam_instance_profile
  subnet_id            = var.public_subnet_id
  availability_zone    = "ap-northeast-1a"


  # EBS設定
  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }
}
