output "droplet_ip_addresses" {
  value = {
    for droplet in digitalocean_droplet.kali:
    droplet.name => droplet.ipv4_address
  }
}