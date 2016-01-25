variable "do_token" {}
variable "ssh_fingerprint" {}
variable "hostname" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_droplet" "dokku" {
  image = "ubuntu-14-04-x64"
  name = "dokku"
  region = "lon1"
  size = "512mb"
  ssh_keys = ["${var.ssh_fingerprint}"]

  provisioner "file" {
    source = "../scripts/install-dokku.sh"
    destination = "/tmp/install-dokku.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-dokku.sh",
      "HOSTNAME=${var.hostname} /tmp/install-dokku.sh"
    ]
  }
}

# Create a new domain record
resource "digitalocean_domain" "dokku" {
  name = "${var.hostname}"
  ip_address = "${digitalocean_droplet.dokku.ipv4_address}"
}

resource "digitalocean_record" "wildcard" {
  domain = "${digitalocean_domain.dokku.name}"
  type = "CNAME"
  name = "*"
  value = "@"
}
