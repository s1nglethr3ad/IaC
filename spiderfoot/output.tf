output "Name" {
  value = digitalocean_droplet.spiderfoot.name
}

output "outputs" {
  value = "Spiderfoot IP is ${digitalocean_droplet.spiderfoot.ipv4_address}"
}
