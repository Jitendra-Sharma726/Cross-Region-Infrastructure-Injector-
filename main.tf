# Create the US Data Bucket
resource "aws_s3_bucket" "us_data" {
  bucket = "global-app-us-data"
}

# Create the EU Data Bucket using the Europe Provider Alias
resource "aws_s3_bucket" "eu_data" {
  provider = aws.europe
  bucket   = "global-app-eu-data"
}

# Export the Generated Resource Attributes into a Local JSON File
resource "local_file" "tf_outputs" {
  filename = "./outputs.json"
  content  = jsonencode({
    us_bucket_arn = aws_s3_bucket.us_data.arn
    eu_bucket_arn = aws_s3_bucket.eu_data.arn
  })
}
