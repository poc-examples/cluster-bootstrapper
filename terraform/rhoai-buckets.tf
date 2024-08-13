# resource "aws_s3_bucket" "quay_backend" {
#     bucket = "quay-backend"
#     force_destroy = true
# }

# resource "aws_s3_bucket_ownership_controls" "quay_backend" {
#   bucket = aws_s3_bucket.quay_backend.id
#   rule {
#     object_ownership = "ObjectWriter"
#   }
# }

# resource "aws_s3_bucket_acl" "quay_backend" {
#   depends_on = [aws_s3_bucket_ownership_controls.quay_backend]

#   bucket = aws_s3_bucket.quay_backend.id
#   acl    = "private"
# }

# resource "aws_s3_bucket" "model_bucket" {
#     bucket = "model-bucket"
#     force_destroy = true
# }

# resource "aws_s3_bucket_ownership_controls" "model_bucket" {
#   bucket = aws_s3_bucket.model_bucket.id
#   rule {
#     object_ownership = "ObjectWriter"
#   }
# }

# resource "aws_s3_bucket_acl" "model_bucket" {
#   depends_on = [aws_s3_bucket_ownership_controls.model_bucket]

#   bucket = aws_s3_bucket.model_bucket.id
#   acl    = "private"
# }
