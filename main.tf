resource "random_password" "user_passwd" {
  length           = 16
  special          = false
}

resource "digitalocean_droplet" "interview" {
  image  = "ubuntu-20-10-x64"
  name   = "interview"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host        = self.ipv4_address
    private_key = file(var.ssh_key)
  }

  provisioner "remote-exec" {
    inline = [
      "useradd --create-home ${var.user_name}",
      "usermod -s /bin/bash ${var.user_name}",
      "echo ${var.user_name}:${random_password.user_passwd.result} | chpasswd",
      "sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "echo '_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true' >> ~${var.user_name}/.bash_profile",
      "systemctl reload sshd",
      "apt update",
      "apt install -y vim byobu python3 python-is-python3 nodejs golang-go",
    ]
  }

  provisioner "local-exec" {
      command = "echo IP: ${self.ipv4_address}, PW: ${random_password.user_passwd.result}"
  }
}
