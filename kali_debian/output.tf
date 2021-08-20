output "Name" {
  value = "${digitalocean_droplet.kali.name}"
}

output "outputs" {
  value = "kali IP is ${digitalocean_droplet.kali.ipv4_address}"
}
