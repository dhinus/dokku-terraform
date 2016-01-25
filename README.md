# Dokku Terraform

Install Dokku using Terraform

# Providers

Currently supports DigitalOcean only. I'm planning to add AWS as well.

# Usage

```sh
cd digitalocean

terraform apply\
  -var 'do_token=YOUR_DIGITALOCEAN_TOKEN'
  -var 'ssh_fingerprint=YOUR_SSH_KEY_FINGERPRINT'
  -var 'hostname=YOUR_BASE_HOSTNAME'
```

This will create a new Droplet using the standard Ubuntu image, then run
[install-dokku.sh](scripts/install-dokku.sh) to install and configure Dokku.

It will also create two DNS records pointing at the IP of your new instance.
(You need to configure your domain or subdomain to use DigitalOcean's name
servers for it to actually work)

It will take less than 5 minutes, then you should be able to deploy your first
app like this:

```sh
cd /path/of/your/app
git remote add dokku dokku@YOUR_BASE_HOSTNAME
git push dokku master
```

# Cleaning up

If you no longer need this instance, you can easily delete the droplet and the
associated DNS records using `terraform destroy`.
