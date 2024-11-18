# nginx-wildcard-static-server

PoC of an nginx-based wildcard static server

## How does it work?

It deploys nginx w/ certbot (via docker compose) with ansible to a new VPS.

The nginx then is mapping subdomains to folders on disk, so that if you want to add another subdomain, you just create a new folder and put files in it.

Please check nginx.conf for details. See also `playbooks/03_test_data.yml` for more info how to add new content.

It's using using a separate user to manage nginx, and separate to handle the static content.

In order to make the subdomains work it also needs a wildcard SSL certificate.
For this we're using LE, [DNS-01 challeange](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge) since HTTP-01 does not support wildcards.
We're using ovh in this example, but should be similar with any other DNS provider that's supported by certbot.

## What is it for?

You can use it to host multiple static websites on different subdomains.
The intended use case for the initial implementation was making previews of feature branchs of a static website.

To see a demo how to use it, you can check: https://github.com/artcz/static-gh-actions-subdomain-preview-demo


## How to run it on my own (new) server?

1. Create a new VPS
1. Grab it's IP
1. Go to your DNS provider
1. Set up a wildcard DNS A record for a subdomain you want to use - using this IP - `*.static-preview-v2.artcz.pl A <ip>`
1. Set up a regular DNS A record for a subdomain you want to use - using this IP – `static-preview-v2.artcz.pl A <ip>`
1. (both are needed for this setup)
1. Update hosts.yml
1. Run `make remote/01-new-vps-setup`
1. Run `make remote/02-setup-nginx`
1. Run `make remote/03-copy-some-test-data`
1. Get credentaiils for the OVH DNS (see here: https://certbot-dns-ovh.readthedocs.io/en/stable/ for details)
1. SSH to the new server (as nginx_user) and put your credentials in `data/certbot/conf/ovh.ini`
1. While on remote run `make certbot/init-staging`
1. Debug if something went wrong
1. run `make certbot/upgrade-to-prod` to upgrade from a staging cert, to a secure one.
1. ...
1. Go to https://feature-branch.static-preview-v2.artcz.pl and check if everything works.


## FAQ

...
