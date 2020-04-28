# personal-blog
Personal blog development 

Repository aim is to be self contained, meaning it includes all needed code to build complete website. Main prerequisite is have Power User access to an AWS account. If you want to setup CI/CD then Github with Actions feature enabled is neccessary.

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
# or Deploy User
terraform import aws_iam_user.deploy_user DeployUser
```

## To Do 
- Add CloudFront support - see https://registry.terraform.io/modules/conortm/s3-static-website/aws/0.0.3
- Add Lambda@Egde support (with DynamoDB)