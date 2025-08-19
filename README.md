# Tinyproxy Docker Image

A lightweight Docker image for running [Tinyproxy](https://tinyproxy.github.io/) — a fast, minimal HTTP/HTTPS proxy server.

---

## Quick start

Pull the prebuilt image from GitHub Container Registry and run it:

```bash
docker pull ghcr.io/niklasthorild/tinyproxy-docker:latest
docker run -d --name tinyproxy -p 8888:8888 -e TZ=UTC ghcr.io/niklasthorild/tinyproxy-docker:latest
```

Set your app/system proxy to `http://localhost:8888`.

---

## Configuration

### Use a custom config
Mount your own `tinyproxy.conf` into the container:

```bash
docker run -d --name tinyproxy \
  -p 8888:8888 \
  -e TZ=UTC \
  -v "$(pwd)/tinyproxy.conf:/etc/tinyproxy/tinyproxy.conf:ro" \
  ghcr.io/niklasthorild/tinyproxy-docker:latest
```

Common options in `tinyproxy.conf`:
- `Port 8888` — internal proxy port (must match your container port mapping)
- `Allow 127.0.0.1` or `Allow 10.0.0.0/8` — restrict access
- `BasicAuth <user> <password>` — simple auth (optional)

---

## Docker Compose

```yaml
services:
  tinyproxy:
    image: ghcr.io/niklasthorild/tinyproxy-docker:latest
    container_name: tinyproxy
    ports:
      - "8888:8888"
    environment:
      - TZ=UTC
    volumes:
      - ./tinyproxy.conf:/etc/tinyproxy/tinyproxy.conf:ro
    restart: unless-stopped
```

Start it:

```bash
docker compose up -d
```

---

## Verify the proxy

```bash
# Should return your outbound IP via the proxy
curl -x http://localhost:8888 https://ifconfig.me
```

---

## Manage the container

```bash
docker logs -f tinyproxy        # tail logs
docker stop tinyproxy           # stop
docker rm tinyproxy             # remove
```
