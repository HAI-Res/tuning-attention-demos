#!/bin/sh
# First-time setup of the hosted receiver. Run ON THE VM, as root, after
# deploy/push.sh has put the code in /opt/attention-phone. Idempotent.
#
# Assumes: Ubuntu 24.04 on CSAIL OpenStack, DNS for $NAME already pointing at
# this box, and the security group open on 80 and 443. See HOSTING.md.
set -eu
NAME="${NAME:-ductus-web-app.csail.mit.edu}"
EMAIL="${EMAIL:-jonmyers@mit.edu}"

apt-get update
apt-get install -y nginx certbot python3-certbot-nginx rsync curl

id ductus >/dev/null 2>&1 || useradd --system --create-home --shell /usr/sbin/nologin ductus
chown -R ductus:ductus /opt/attention-phone

# uv for the service user; the venv lives inside the checkout.
if [ ! -x /home/ductus/.local/bin/uv ]; then
  sudo -u ductus sh -c 'curl -LsSf https://astral.sh/uv/install.sh | sh'
fi
sudo -u ductus sh -c 'cd /opt/attention-phone && /home/ductus/.local/bin/uv sync --frozen'

install -m 644 /opt/attention-phone/deploy/ductus.service /etc/systemd/system/ductus.service
systemctl daemon-reload
systemctl enable --now ductus

# nginx: plain HTTP first so certbot can answer the challenge, then TLS.
sed "s/ductus-web-app.csail.mit.edu/$NAME/g" /opt/attention-phone/deploy/nginx-ductus.conf > /etc/nginx/sites-available/ductus
ln -sf /etc/nginx/sites-available/ductus /etc/nginx/sites-enabled/ductus
rm -f /etc/nginx/sites-enabled/default
if [ ! -d "/etc/letsencrypt/live/$NAME" ]; then
  # Bring up port 80 only, without the 443 block the cert does not yet exist for.
  printf 'server {\n    listen 80;\n    listen [::]:80;\n    server_name %s;\n    location /.well-known/acme-challenge/ { root /var/www/html; }\n    location / { return 301 https://$host$request_uri; }\n}\n' "$NAME" > /etc/nginx/sites-available/ductus.http
  ln -sf /etc/nginx/sites-available/ductus.http /etc/nginx/sites-enabled/ductus
  nginx -t && systemctl reload nginx
  certbot certonly --webroot -w /var/www/html -d "$NAME" -m "$EMAIL" --agree-tos --non-interactive
  ln -sf /etc/nginx/sites-available/ductus /etc/nginx/sites-enabled/ductus
fi
nginx -t && systemctl reload nginx
systemctl enable --now certbot.timer

echo
echo "  https://$NAME/          the page"
echo "  https://$NAME/health    what the receiver sees"
curl -fsS "http://127.0.0.1:8080/health" && echo
