resource "aws_s3_bucket" "webserver" {
  for_each = var.s3_bucket_name
  bucket = each.value
  tags = merge(local.common_tags,{Name = "webserver-s3-${each.key}"})
}
