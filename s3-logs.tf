resource "aws_s3_bucket" "s3-logs" {
  bucket        = "${var.domain_name}-logs"
  force_destroy = true #all objects should be deleted from the bucket when the bucket is destroyed 
  #so that the bucket can be destroyed without error
  tags = {
    ManagedBy = "${local.name_managed_by}"
    Stack     = local.name_stack
  }
}

# enable s3 access control list (ACL) for new s3 bucket being used for CloudFront standard logs
# CloudFront logger will automatically add itself to the ACLs as long as they are enabled
resource "aws_s3_bucket_ownership_controls" "s3-logs" {
  bucket = aws_s3_bucket.s3-logs.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
/*
resource "aws_s3_bucket_policy" "s3_logs" {
  bucket     = aws_s3_bucket.s3-logs.id
  policy     = data.aws_iam_policy_document.s3_logs.json
  depends_on = [aws_s3_bucket_public_access_block.s3-logs] # need to disble public access before attempting to add the policy
}
*/
resource "aws_s3_bucket_public_access_block" "s3-logs" {
  bucket = aws_s3_bucket.s3-web.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
