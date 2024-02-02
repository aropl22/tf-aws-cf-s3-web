provider "aws" {
  region = local.region
  #region = "us-west-1"
}

# To use an ACM certificate with CloudFront, 
# make sure you request (or import) the certificate in the US East (N. Virginia) Region (us-east-1).

provider "aws" {
  alias = "virginia"
  region = "us-east-1"
}
