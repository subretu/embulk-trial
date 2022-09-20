#--------------------------------------------------------------
# IAM
#--------------------------------------------------------------

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  name               = "MyRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy" "systems_manager" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy_document" "ec2_s3_for_embulk_document" {
  statement {
    actions = ["s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]
    resources = ["arn:aws:s3::${var.s3_bucket_name}/*"]
    effect    = "Allow"
  }
  statement {
    actions = ["s3:GetBucketPublicAccessBlock",
      "s3:ListBucket",
    "s3:GetBucketLocation"]
    resources = ["arn:aws:s3:::${var.s3_bucket_name}"]
    effect    = "Allow"
  }
}

resource "aws_iam_policy" "ec2_s3_for_embulk" {
  name   = "ec2_s3_for_embulk"
  policy = data.aws_iam_policy_document.ec2_s3_for_embulk_document.json
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.systems_manager.arn
}

resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.ec2_s3_for_embulk.arn
}

resource "aws_iam_instance_profile" "systems_manager" {
  name = "MyInstanceProfile"
  role = aws_iam_role.role.name
}
