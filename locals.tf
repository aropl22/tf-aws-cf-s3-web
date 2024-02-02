
locals {
  region          = "us-west-1"
  name_managed_by = "Terraform"
  name_stack      = "Dev"
  account_id = data.aws_caller_identity.current.account_id

}

# Specify website content types copied to s3 storage

locals {
  content_type_map = {
    "js"   = "application/json"
    "html" = "text/html"
    "css"  = "text/css"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "png"  = "image/png"
  }
}