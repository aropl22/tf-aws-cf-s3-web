resource "aws_s3_bucket" "s3-logs" {
  bucket        = "logs-${var.domain_name}"
  force_destroy = true #all objects should be deleted from the bucket when the bucket is destroyed 
                       #so that the bucket can be destroyed without error
  tags = merge(
    var.default_tags,
    {
      "Name" = "logs-${var.domain_name}"
    }
  )
}

# enable s3 access control list (ACL) for new s3 bucket being used for CloudFront standard logs
# CloudFront logger will automatically add itself to the ACLs as long as they are enabled

resource "aws_s3_bucket_ownership_controls" "s3-logs" {
  bucket = aws_s3_bucket.s3-logs.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "s3-logs" {
  bucket = aws_s3_bucket.s3-logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
