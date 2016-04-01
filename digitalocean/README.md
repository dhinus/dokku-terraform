# dokku-terraform DigitalOcean module

This module will create a new Droplet and install Dokku on it.

It will also configure DNS records for you, so you should be able to deploy new
apps by doing something like this:

```sh
git remote add dokku dokku@$YOUR_BASE_HOSTNAME:$APP_NAME
git push dokku master
```

## Input Variables

* `ssh_fingerprint` - This key will get admin access to the Dokku instance.
* `hostname` - Your base hostname. Apps will be deployed to `app_name.${var.hostname}`.

## Usage

```
module "dokku" {
  source = "github.com/dhinus/dokku-terraform//digitalocean"

  ssh_fingerprint = "aa:bb:cc"
  hostname = "my_base_hostname.example.com"
}
```
