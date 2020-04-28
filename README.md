# personal-blog
Personal blog development 

Repository aim is to be selfcontined, meaning it includes all needed code to build complete website. Prerequisit is have Power User access to an AWS account

## Structure
- Terraform (v0.12.x) to build a S3 bucket to host static webpage
- Github Actions (upload new s3 content on push to master)
- HTML and JavaScript


## Steps 

### S3 bucket for terraform state
Create using 
```
aws s3 mb s3://bucket-name
```


Terraform import bucket if you already create one
```
terraform import aws_s3_bucket.bucket bucket-name
```