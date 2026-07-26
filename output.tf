output "instance_ids" {
  value = module.ec2[*].instance_id
}

output "public_ips" {
  value = module.ec2[*].public_ip
}