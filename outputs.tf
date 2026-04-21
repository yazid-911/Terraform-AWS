output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i deployer-key.pem ec2-user@${aws_instance.web.public_ip}"
}

output "db_instance_id" {
  description = "ID of the database EC2 instance"
  value       = aws_instance.db.id
}

output "db_instance_public_ip" {
  description = "Public IP of the database EC2 instance"
  value       = aws_instance.db.public_ip
}

output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = aws_s3_bucket.demo_bucket.id
}

output "uploaded_object_key" {
  description = "Key of the uploaded object"
  value       = aws_s3_object.demo_object.key
}

output "bucket_url" {
  description = "Public URL to access the S3 bucket"
  value       = "https://${aws_s3_bucket.demo_bucket.id}.s3.amazonaws.com"
}

output "object_public_url" {
  description = "Public URL of the uploaded object"
  value       = "https://${aws_s3_bucket.demo_bucket.id}.s3.amazonaws.com/${aws_s3_object.demo_object.key}"
}
