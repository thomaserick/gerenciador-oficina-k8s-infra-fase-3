output "bucket_arn" {
  description = "ARN do bucket."
  value       = aws_s3_bucket.s3_bucket.arn
}