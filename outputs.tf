locals {
  content = <<-EOT
    instance_id = ${module.techshare-ec2.ec2_instance_id}
    public_ip = ${module.techshare-ec2.instance_public_ip}
    private_ip = ${module.techshare-ec2.instance_private_ip}
    availability_zone = ${join(",", module.techshare-vpc.za)}
  EOT
}

resource "local_file" "resource_info" {
  filename = "resource_info.txt"
  content  = local.content
}
