resource "aws_s3_bucket" "s3-web" {
  bucket        = var.domain_name
  force_destroy = true #all objects should be deleted from the bucket when the bucket is destroyed 
  #so that the bucket can be destroyed without error
  tags = {
    ManagedBy = "${local.name_managed_by}"
    Stack     = local.name_stack
  }
}

resource "aws_s3_bucket_policy" "s3_oac" {
  bucket     = aws_s3_bucket.s3-web.id
  policy     = data.aws_iam_policy_document.s3_oac.json
  depends_on = [aws_s3_bucket_public_access_block.s3-web] #need to disble public access before attempting to add the policy
}

data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "s3_oac" {
  statement {
    sid = "AllowCloudFrontServicePrincipal"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3-web.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values = ["arn:aws:cloudfront::${local.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
      ]
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "s3-web" {
  bucket = aws_s3_bucket.s3-web.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3-web" {
  bucket = aws_s3_bucket.s3-web.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "s3-web" {
  bucket = aws_s3_bucket.s3-web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "img/"
    }
    redirect {
      replace_key_prefix_with = "images/"
    }
  }
}

resource "aws_s3_object" "provision_website_files" {
  bucket       = aws_s3_bucket.s3-web.id
  for_each     = fileset("website_files/", "**/*.*")
  key          = each.value
  source       = "website_files/${each.value}"
  content_type = lookup(local.content_type_map, split(".", "website_files/${each.value}")[1], "text/html")
}
