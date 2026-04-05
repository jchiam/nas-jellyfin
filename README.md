# nas-jellyfin

Jellyfin media server running on my UGreen NAS, using the official Jellyfin Docker image.

## Purpose

Self-hosted media server for streaming personal video and music libraries, accessible over HTTPS via the Caddy reverse proxy on the same NAS.

## Architecture

```
Internet → media.in.<my-domain> → Tailscale (access control) → Caddy → localhost:8899
                                                                               ↓
                                                                           Jellyfin
                                                                        (official image)
```

## Prerequisites

- Docker and Docker Compose installed on the NAS
- [nas-caddy](../nas-caddy) running as the reverse proxy
- Media files under `/home/jchiam`

## Setup

1. Clone the repository onto the NAS.

2. Start the container:

   ```bash
   docker compose up -d
   ```

3. Access the UI at `http://localhost:8899` (or via the Caddy-proxied domain) and complete the initial setup wizard.

## Migrating from UGreen Jellyfin

The previous setup used the `ugreen/jellyfin:v1` image. All volumes are bind mounts pointing to the same paths on disk, so switching to the official image requires no data migration:

```bash
# Stop the old container
docker compose down

# Pull the official image and start
docker compose pull
docker compose up -d
```

Jellyfin will load the existing config, plugins, and media library automatically.

## Persistent Data

All data is stored as bind mounts on the host:

| Mount | Host Path | Purpose |
|---|---|---|
| `/config` | `./config` | Jellyfin configuration and metadata |
| `/cache` | `./cache` | Transcoding cache |
| `/data` | `/home/jchiam` | Media library |
| `/config/plugins` | `/home/jchiam/_config/jellyfin` | Jellyfin plugins |

## Linting

Lint checks run automatically on every push and PR to `main` via GitHub Actions ([.github/workflows/lint.yaml](.github/workflows/lint.yaml)).

| Tool | Target |
|---|---|
| `yamllint` | `docker-compose.yaml` |

## Files

| File | Purpose |
|---|---|
| [docker-compose.yaml](docker-compose.yaml) | Service definition for Jellyfin |
| [.github/workflows/lint.yaml](.github/workflows/lint.yaml) | GitHub Actions lint workflow |
