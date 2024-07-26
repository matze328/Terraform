

# S3-Bucket erstellen
resource "aws_s3_bucket" "my_bucket" {
  bucket = "Mein-Terraform-Bucket" # Der Name des Buckets muss global eindeutig sein


  tags = {
    Name        = "MeinS3Bucket"
    Environment = "Dev"
  }
}

