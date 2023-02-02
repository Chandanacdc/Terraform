data "aws_s3_bucket" "selected" {
  bucket = "bipro-s3bucket"
}

data "aws_caller_identity" "my_user" {}

locals {
  account_id     = data.aws_caller_identity.my_user.account_id
  admin_username = "chandana"
}

#kms key creation
#################
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = var.deletion_days
  policy      = data.aws_iam_policy_document.ssm_key.json
}
resource "aws_kms_alias" "a" {
  name          = "alias/s3_key"
  target_key_id = aws_kms_key.mykey.key_id
}


data "aws_iam_policy_document" "ssm_key" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }

  statement {
    sid       = "Allow access for Key Administrators"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.account_id}:user/${local.admin_username}"
      ]
    }
  }

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.account_id}:user/${local.admin_username}"
      ]
    }
  }

  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers =[
         "arn:aws:iam::${local.account_id}:user/${local.admin_username}"
         ]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}


########################
# Bucket creation
########################
resource "aws_s3_bucket" "my_protected_bucket" {
  count=var.s3count
  bucket = "${var.uniqueid}${var.appname}${var.env}${count.index+1}"
  acl    = "private"

  versioning {
    enabled = true
  }
  logging {
    target_bucket =data.aws_s3_bucket.selected.id
    target_prefix = "log/"
  }
# Lifecycle rule creation

  lifecycle_rule {
    id      = "all_bucket_rlz"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }
########################
#Encryption in s3 backet
########################
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

