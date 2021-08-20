provider "digitalocean" {
  token = "APITOKEN"
}
resource "digitalocean_droplet" "kali" {
  name     = "kali-ddos-${count.index}"
  count    = 3
  image    = "debian-10-x64"
  region   = "nyc3"
  size     = "s-4vcpu-8gb"
  ssh_keys = [SSHID]
  provisioner "remote-exec" {
    inline = [
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get update",
      "apt-get -y dist-upgrade",
      "apt-get -y autoremove",
      "apt-get -y install gnupg2",
      "wget -q -O - https://archive.kali.org/archive-key.asc | apt-key add",
      "echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free' >> /etc/apt/sources.list",
      "apt-get update",
      "apt-get -y install kali-linux-headless",
      "curl -s https://raw.githubusercontent.com/Taguar258/Raven-Storm/master/install.sh | sudo bash -s",
    ]
    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("PATHTOIDRSA")
      user        = "root"
      timeout     = "2m"
    }
  }
}
