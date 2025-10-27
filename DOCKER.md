# Docker Guide for Coinbean

This guide explains how to run Coinbean using Docker.

## Prerequisites

- Docker installed on your system
- Docker Compose (optional, but recommended)

## Quick Start

### Option 1: Using Docker Compose (Recommended)

**Start Coinbean:**
```bash
docker-compose up -d
```

**View logs:**
```bash
docker-compose logs -f
```

**Stop Coinbean:**
```bash
docker-compose down
```

**Restart after changes:**
```bash
docker-compose restart
```

### Option 2: Using Docker Directly

**Build the image:**
```bash
docker build -t coinbean .
```

**Run the container:**
```bash
docker run -d \
  --name coinbean \
  -p 5002:5002 \
  -v $(pwd):/app \
  coinbean
```

**View logs:**
```bash
docker logs -f coinbean
```

**Stop the container:**
```bash
docker stop coinbean
docker rm coinbean
```

## Access the Application

Once the container is running, open your browser and navigate to:

```
http://localhost:5002
```

## Features

### Automatic Validation

The Docker container automatically runs `bean-check` on startup to validate your ledger files before starting Fava.

### Volume Mounting

All your `.beancount` files are mounted as volumes, so you can edit them on your host system and see changes immediately in the container.

### Health Checks

The container includes health checks to ensure Fava is running properly.

## Updating Prices

To fetch current cryptocurrency prices while running in Docker:

**Using Docker Compose:**
```bash
docker-compose exec coinbean ./prices.sh
```

**Using Docker directly:**
```bash
docker exec -it coinbean ./prices.sh
```

## Troubleshooting

### Container won't start

Check the logs:
```bash
docker-compose logs coinbean
```

Common issues:
- Syntax errors in `.beancount` files (check with `bean-check`)
- Port 5002 already in use
- Permission issues with mounted volumes

### Port already in use

Change the port in `docker-compose.yml`:
```yaml
ports:
  - "5003:5002"  # Change 5003 to your preferred port
```

### Can't access from browser

Make sure the container is running:
```bash
docker-compose ps
```

Check if port is mapped correctly:
```bash
docker port coinbean
```

## Advanced Configuration

### Custom Environment Variables

Add environment variables in `docker-compose.yml`:
```yaml
environment:
  - TZ=America/New_York
  - FAVA_PORT=5002
```

### Persistent Data

To persist Fava cache between container restarts, add a volume:
```yaml
volumes:
  - ./.fava-cache:/app/.fava-cache
```

### Running Commands Inside Container

**Interactive shell:**
```bash
docker-compose exec coinbean sh
```

**Run bean-check:**
```bash
docker-compose exec coinbean bean-check crypto_main.beancount
```

**Run bean-query:**
```bash
docker-compose exec coinbean bean-query crypto_main.beancount "SELECT * FROM accounts"
```

## Docker Hub (Coming Soon)

We plan to publish pre-built images to Docker Hub for even easier installation:

```bash
docker pull qailab/coinbean:latest
docker run -p 5002:5002 -v $(pwd):/app qailab/coinbean:latest
```

## Benefits of Using Docker

✅ **No Python Installation**: Run without installing Python or dependencies
✅ **Consistent Environment**: Works the same on all systems
✅ **Easy Updates**: Pull new image and restart
✅ **Isolation**: Doesn't interfere with your system Python
✅ **Quick Setup**: One command to start
✅ **Automatic Validation**: Validates ledger on startup

## Production Deployment

For production use:

1. Use a reverse proxy (nginx, Caddy, Traefik)
2. Enable HTTPS
3. Set up authentication
4. Configure backups for your `.beancount` files
5. Monitor container health

Example with Traefik labels in `docker-compose.yml`:
```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.coinbean.rule=Host(`coinbean.yourdomain.com`)"
  - "traefik.http.routers.coinbean.entrypoints=websecure"
  - "traefik.http.routers.coinbean.tls.certresolver=letsencrypt"
```

## Comparison with Native Installation

| Feature | Docker | Native |
|---------|--------|--------|
| Installation | One command | Multiple steps |
| Python Required | No | Yes |
| System Impact | None | Installs packages |
| Portability | Perfect | OS-dependent |
| Updates | Pull image | pip upgrade |
| Performance | ~Native | Native |

## Support

If you encounter issues with Docker:
- Check the [main README](README.md) for general help
- Review Docker logs: `docker-compose logs`
- Check container status: `docker-compose ps`
- Visit [GitHub Issues](https://github.com/qai-lab/coinbean/issues)
