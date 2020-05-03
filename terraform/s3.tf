resource "aws_s3_bucket" "blog" {
  bucket = "perception.ninja"
  acl    = "public-read"

  website {
    index_document = var.index_document
    error_document = var.error_document
  }
}

resource "aws_s3_bucket_policy" "blog_policy" {
  bucket = aws_s3_bucket.blog.id

  policy = <<POLICY
{
    "Version": "2008-10-17",
    "Id": "PolicyForPublicWebsiteContent",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.blog.id}/*"
        }
    ]
}
POLICY
}