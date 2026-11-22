# Static site served by Caddy on port 8080, as an unprivileged user.
FROM caddy:2.10.0-alpine

# Caddy writes its state under XDG dirs; keep them in /tmp so the container can run read-only.
ENV XDG_DATA_HOME=/tmp/caddy-data XDG_CONFIG_HOME=/tmp/caddy-config

# The base image gives /usr/bin/caddy the file capability cap_net_bind_service (for ports below 1024). We listen
# on 8080, and with that file capability the binary can't start where all capabilities are dropped (the k3s pods:
# "exec /usr/bin/caddy: operation not permitted"). Remove it.
RUN setcap -r /usr/bin/caddy

COPY Caddyfile /etc/caddy/Caddyfile
COPY site/ /srv/

USER 65534:65534
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget -q --spider http://127.0.0.1:8080/healthz || exit 1
