provider "aws" {
  profile                 = var.profile
  shared_credentials_file = "~/.aws/credentials"
  region                  = var.aws_region
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = var.terraform_state_bucket

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

#create s3 policy docucment
data "aws_iam_policy_document" "terraform-state-bucket-policy-document" {
  statement {
    sid = "RequireEncryptedTransport"
    effect = "Deny"
    actions = [
      "s3:*",
    ]
    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*"
    ]
    condition {
      test = "Bool"
      variable = "aws:SecureTransport"
      values = [
        false,
      ]
    }
    principals {
      type = "*"
      identifiers = ["*"]
    }
  }

  statement {
    sid = "RequireEncryptedStorage"
    effect = "Deny"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*"
    ]
    condition {
      test = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values = [
        "${var.kms_key_id == "" ? "AES256" : "aws:kms" }"
      ]
    }
    principals {
      type = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "terraform-state-backend-policy" {
  bucket = "${aws_s3_bucket.terraform_state.id}"
  policy = "${data.aws_iam_policy_document.terraform-state-bucket-policy-document.json}"
}

resource "aws_s3_bucket" "terraform-state-backend-logs" {
  bucket = "${var.terraform_state_bucket}-logs"
  acl = "log-delivery-write"
  versioning {
    enabled = true
  }

  lifecycle  {
    prevent_destroy = false
  }
}