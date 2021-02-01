## terraform installation and first example of usage
- install terraform from "https://www.terraform.io/downloads.html"
- create an environment variable
- create AWS user named "terraform", having programmatic access
- download the csv file of newly created IAM user and put it under .aws folder with a name "credentials"
- create github repo named terraform, and clone it to the local
- create "first_code.tf" under local repo, and write your first IaC which will create an S3 bucket!
```bash
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_course" {
  bucket = "tf-course-rafe-stefano"
  acl = "private"
}
```
- Apply your code, this command search for .tf file extention, look at the cloud provider, go through the plugins
```bash
terraform apply
```
```txt
An execution plan has been generated and is shown below.      
Resource actions are indicated with the following symbols:    
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be created
  + resource "aws_s3_bucket" "terraform_course" {
      + acceleration_status         = (known after apply)     
      + acl                         = "private"
      + arn                         = (known after apply)     
      + bucket                      = "tf-course-rafe-stefano"
      + bucket_domain_name          = (known after apply)     
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_s3_bucket.terraform_course: Creating...
aws_s3_bucket.terraform_course: Still creating... [10s elapsed]
aws_s3_bucket.terraform_course: Creation complete after 12s [id=tf-course-rafe-stefano]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
- The CLI will show the status and info about infrastructure, and ask for confirmation, if agreed write "yes"
- Terraform operations can be summarized:
    - refresh
    - plan
    - apply
    - destroy

## terraform plan
- We can create an execution plan
- To see available options:
```bash
terraform plan --help
```
- To see current status of our plan:
```bash
terraform plan
```
```text
aws_s3_bucket.terraform_course: Refreshing state... [id=tf-course-rafe-stefano]

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
```
- To see the destroy plan:
```bash
terraform plan -destroy
```
```text
An execution plan has been generated and is shown below.  
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be destroyed      
  - resource "aws_s3_bucket" "terraform_course" {
      - acl                         = "private" -> null
      - arn                         = "arn:aws:s3:::tf-course-rafe-stefano" -> null
      - bucket                      = "tf-course-rafe-stefano" -> null
      - bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
      - id                          = "tf-course-rafe-stefano" -> null
      - region                      = "us-east-1" -> null
      - request_payer               = "BucketOwner" -> null

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```
- It shows the destroy plan, and notes "You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run." So, lets save the plan:
```bash
terraform plan -destroy -out=example
```
```text
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be destroyed
  - resource "aws_s3_bucket" "terraform_course" {
      - acl                         = "private" -> null
      - arn                         = "arn:aws:s3:::tf-course-rafe-stefano" ->
      - bucket                      = "tf-course-rafe-stefano" -> null
      - bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com
      - bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
      - id                          = "tf-course-rafe-stefano" -> null
      - region                      = "us-east-1" -> null
      - request_payer               = "BucketOwner" -> null

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

------------------------------------------------------------------------

This plan was saved to: example

To perform exactly these actions, run the following command to apply:
    terraform apply "example"
```
- To see the saved plan:
```bash
terraform show example
```
```text
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.terraform_course will be destroyed
  - resource "aws_s3_bucket" "terraform_course" {
      - acl                         = "private" -> null
      - arn                         = "arn:aws:s3:::tf-course-rafe-stefano" -> null
      - bucket                      = "tf-course-rafe-stefano" -> null
      - bucket_domain_name          = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "tf-course-rafe-stefano.s3.amazonaws.com" -> null
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
      - id                          = "tf-course-rafe-stefano" -> null
      - region                      = "us-east-1" -> null
      - request_payer               = "BucketOwner" -> null

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.
```
## Terraform State
- Terraform state shows our intention, it may not be fitted with actual infrastructure.
- The last terraform state can be inspected from terraform.tfstate file. This is a JSON file. For example:
```bash
{
  "version": 4,
  "terraform_version": "0.14.5",
  "serial": 1,
  "lineage": "5bec9aa0-64e0-5d77-a39e-95437076f3e9",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_s3_bucket",
      "name": "terraform_course",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "acceleration_status": "",
            "acl": "private",
            "arn": "arn:aws:s3:::tf-course-rafe-stefano",
            "bucket": "tf-course-rafe-stefano",
            "bucket_domain_name": "tf-course-rafe-stefano.s3.amazonaws.com",
            "bucket_prefix": null,
            "bucket_regional_domain_name": "tf-course-rafe-stefano.s3.amazonaws.com",
            "cors_rule": [],
            "force_destroy": false,
            "grant": [],
            "hosted_zone_id": "Z3AQBSTGFYJSTF",
            "id": "tf-course-rafe-stefano",
            "lifecycle_rule": [],
            "logging": [],
            "object_lock_configuration": [],
            "policy": null,
            "region": "us-east-1",
            "replication_configuration": [],
            "request_payer": "BucketOwner",
            "server_side_encryption_configuration": [],
            "tags": null,
            "versioning": [
              {
                "enabled": false,
                "mfa_delete": false
              }
            ],
            "website": [],
            "website_domain": null,
            "website_endpoint": null
          },
          "sensitive_attributes": [],
          "private": "bnVsbA=="
        }
      ]
    }
  ]
}
```