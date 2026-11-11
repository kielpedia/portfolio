# Static site served by Caddy on port 8080, as an unprivileged user.
FROM caddy:2.10.0-alpine

# Caddy writes its state under XDG dirs; keep them in /tmp so the container can run read-only.
ENV XDG_DATA_HOME=/tmp/caddy-data XDG_CONFIG_HOME=/tmp/caddy-config

COPY Caddyfile /etc/caddy/Caddyfile
COPY site/ /srv/

USER 65534:65534
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -q --spider http://127.0.0.1:8080/healthz || exit 1
