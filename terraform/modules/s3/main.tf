#--------------------------------------------------------------
# S3
#--------------------------------------------------------------

resource "aws_s3_bucket" "s3-bucket" {
  bucket = "embulk-test-s3-bucket-subretu"
  acl    = "private"
}
