# Dokku Terraform

Terraform modules to create a [Dokku](http://dokku.viewdocs.io/dokku/) instance.

This will create a new VM using a vanilla Ubuntu image, then run
[install-dokku.sh](scripts/install-dokku.sh) to install and configure Dokku.

It will also create some DNS records pointing at your new instance.

It will take about 5 minutes to create a new instance from scratch.

## Supported providers

Use the module matching your provider. Provider-specific documentation is
available in the subdirectories:

* [Digital Ocean](digitalocean/)
* [AWS](aws/)

Please note the AWS module is more complex and requires you to have a working
VPC setup on your AWS account.

## License

Apache License 2.0. See [LICENSE](LICENSE) for full details.
