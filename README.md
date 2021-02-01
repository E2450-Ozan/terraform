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
- To destroy resources:
```bash
terraform plan -destroy
```
- It shows the destroy plan, and notes "You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run." So, lets save the plan:
```bash
terraform plan -destroy -out=example.pln
```