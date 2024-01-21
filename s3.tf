resource "aws_s3_bucket" "bucket-artifact" {
  bucket = "budecsdemo-artifactory-bucket"
  #  acl    = "private"
}

resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "budecs-codep-bucket"
}