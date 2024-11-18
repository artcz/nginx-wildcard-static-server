# nginx-wildcard-static-server

Proof of Concept (PoC) for an Nginx-based wildcard static server.

## How does it work?

This project deploys Nginx with Certbot (via Docker Compose) using Ansible to set it up on a new VPS.

Nginx maps subdomains to folders on disk, allowing you to add a new subdomain simply by creating a corresponding folder and placing files in it.

Refer to `nginx.conf` for configuration details. Additionally, see `playbooks/03_test_data.yml` for information on adding new content.

The setup uses a separate user to manage Nginx and another user to handle the static content.

To enable subdomains, a wildcard SSL certificate is required. This project utilizes Let's Encrypt (LE) and the [DNS-01 challenge](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge), as the HTTP-01 challenge does not support wildcards. The example uses OVH as the DNS provider, but the setup should be similar for other DNS providers supported by Certbot.

## What is it for?

This project is designed to host multiple static websites on different subdomains. The primary use case for the initial implementation was to create previews of feature branches for a static website.

For a demo, visit: https://github.com/artcz/static-gh-actions-subdomain-preview-demo

## How to run it on my own (new) server?

(Assuming `static-preview-v2.artcz.pl` as the subdomain, OVH as the DNS provider, and `<ip>` as the IP of the new server.)

1. Create a new VPS.
2. Obtain the server's IP address.
3. Go to your DNS provider.
4. Set up a wildcard DNS A record for the desired subdomain:
   - `*.static-preview-v2.artcz.pl A <ip>`
5. Set up a regular DNS A record for the subdomain:
   - `static-preview-v2.artcz.pl A <ip>`
   - (Both records are required for this setup.)
6. Update `hosts.yml`.
7. Run `make remote/01-new-vps-setup`.
8. Run `make remote/02-setup-nginx`.
9. Run `make remote/03-copy-some-test-data`.
10. Obtain credentials for the OVH DNS API (refer to: https://certbot-dns-ovh.readthedocs.io/en/stable/ for details).
11. SSH into the new server (as `nginx_user`) and place your credentials in `data/certbot/conf/ovh.ini`.
12. While on the remote server, run `make certbot/init-staging`.
13. Debug any issues if something goes wrong.
14. Run `make certbot/upgrade-to-prod` to upgrade from a staging certificate to a production-ready one.
15. ...
16. Visit `https://feature-branch.static-preview-v2.artcz.pl` to verify everything is working.

## FAQ

...

