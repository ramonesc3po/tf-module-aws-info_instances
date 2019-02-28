variable "instances_filter_name" {
  type    = "list"
  default = [""]
}

variable "instances_filter_tier" {
  type    = "list"
  default = [""]
}

data "aws_instances" "this" {
  filter {
    name   = "tag:Name"
    values = "${var.instances_filter_name}"
  }

  filter {
    name   = "tag:Tier"
    values = "${var.instances_filter_tier}"
  }
}

output "instances_private_ips" {
  value = "${element(concat(data.aws_instances.this.private_ips, list("")), 0)}"
}

output "instances_ids" {
  value = "${element(concat(data.aws_instances.this.ids, list("")), 0)}"
}
