output "Name" {
  value = "${digitalocean_droplet.kali.name}"
}

output "outputs" {
  value = "ubukali IP is ${digitalocean_droplet.kali.ipv4_address}"
}
