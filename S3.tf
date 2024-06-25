resource "aws_s3_bucket" "S3Backend" {
  bucket = "my-backend-test-bucket"


  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = aws_s3_bucket.S3Backend.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://myWebsite.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}
resource "aws_s3_bucket_ownership_controls" "S3Security" {
  bucket = aws_s3_bucket.S3Backend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "S3ACL" {
  depends_on = [aws_s3_bucket_ownership_controls.S3Security]

  bucket = aws_s3_bucket.S3Backend.id
  acl    = "private"
}



