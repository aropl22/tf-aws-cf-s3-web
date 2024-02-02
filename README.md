# Deploys AWS S3 Static Website using Terraform

The code deployes a static website on AWS:

-s3 bucket with static website hosting  
-s3 cloud front logs bucket  
-Cloud Front distribution    
-Origin Access Control Policy   
-Route53 DNS zone and A records  
-AWS Certificate Manager  
-SSL Certificate  




![GitHub Image](/img/cf-s3-web.jpg)



Must define backend and AWS access keys
Terraform defaults to using the local backend, which stores state as a plain file in the current working directory.

More info:  
https://developer.hashicorp.com/terraform/language/settings/backends/configuration

 Examples:

### Terraform Cloud backend file

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31.0"
    }
  }

  required_version = "~> 1.7.1" # minor version updates are intended to be non-disruptive
  
  cloud {
    organization = "YOUR ORGANIZATION NAME"

    workspaces {
      name = "YOUR WORKSPACE NAME"
    }
  }
}
```

### Local Backend

```terraform
terraform {
  backend "local" {
    path = "relative/path/to/terraform.tfstate"
  }
}
```

## Terraform variable definitions (.tfvars) files

To set lots of variables, it's more convenient to specify their values in a variable definitions file (.tfvars or .tfvars.json)
and then specify that file on the command line with -var-file

 Example (terraform.tfvars):

```terraform
domain_name = "EXAMPLE.COM" # configure existing_dns_zone = false if domain zone doesn't exist in Route53
aliases = ["EXAMPLE.COM"] # cf aliases
```

## Outputs:

- account_id  
- cloudfront_distribution_id  
- http = "http://cloudfront_domain.cloudfront.net/"  
- https = "https://domain_name/  
