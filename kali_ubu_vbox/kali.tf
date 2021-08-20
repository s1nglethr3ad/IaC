provider "digitalocean" {
  token = "APITOKEN"
}
resource "digitalocean_droplet" "kali" {
  name     = "kali"
  image    = "ubuntu-18-04-x64"
  region   = "nyc3"
  size     = "s-4vcpu-8gb"
  ssh_keys = [SSHID]
  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get dist-upgrade -y",
      "apt-get autoremove",
      "apt-get -y install gcc make dkms",
      "wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -",
      "wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | apt-key add -",
      "echo 'deb http://download.virtualbox.org/virtualbox/debian bionic contrib' >> /etc/apt/sources.list",
      "apt-get update",
      "apt-get install -y virtualbox-6.1",
      "wget https://download.virtualbox.org/virtualbox/6.1.22/Oracle_VM_VirtualBox_Extension_Pack-6.1.22.vbox-extpack",
      "VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.22.vbox-extpack --accept-license=33d7284dc4a0ece381196fda3cfe2ed0e1e8e7ed7f27b9a9ebc4ee22e24bd23c",
      "VBoxManage -v",
      "wget https://images.offensive-security.com/virtual-images/kali-linux-2021.1-vbox-amd64.ova --vsys 0 --eula accept",
      "VBoxManage import kali-linux-2021.1-vbox-amd64.ova",
      "VBoxHeadless -s 'Kali-Linux-2021.1-vbox-amd64' -vrde on",
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