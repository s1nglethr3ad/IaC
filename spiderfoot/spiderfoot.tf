provider "digitalocean" {
  token = "APITOKEN"
}
#Create Server
resource "digitalocean_droplet" "spiderfoot" {
  name     = "spiderfoot"
  image    = "ubuntu-20-04-x64"
  region   = "nyc3"
  size     = "s-2vcpu-2gb"
  ssh_keys = [SSHID]

  
  provisioner "remote-exec" {
    inline = [
      "apt update",
      "apt-get -y install git zip python3 chromium-chromedriver python3-pip",
      "git clone https://github.com/smicallef/spiderfoot.git /opt/spiderfoot",
      "cd /opt/spiderfoot",
      "pip3 install -r requirements.txt",
      "sleep 2",
      "cd ../",
      "wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip",
      "unzip aquatone_linux_amd64_1.7.0.zip -d /usr/bin/",
      "git clone https://github.com/aboul3la/Sublist3r.git /opt/sublist3r",
      "cd /opt/sublist3r",
      "pip3 install -r requirements.txt",
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
#Create FW
resource "digitalocean_firewall" "spiderfootfw" {
  name = "spiderfoot-fw"

  droplet_ids = [digitalocean_droplet.spiderfoot.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["IP"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["IP"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["IP"]
  }
  
  inbound_rule {
    protocol         = "tcp"
    port_range       = "5001"
    source_addresses = ["IP"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}