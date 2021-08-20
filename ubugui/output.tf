output "Name" {
  value = "${digitalocean_droplet.web.name}"
}

output "outputs" {
  value = "ubugui IP is ${digitalocean_droplet.web.ipv4_address}"
}
