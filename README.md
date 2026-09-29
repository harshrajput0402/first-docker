# Docker Express (Ubuntu)

A minimal **Node.js + Express** web server running inside an **Ubuntu 24.04** Docker container. Built as a beginner project for learning Docker.

## What it does

| Route   | Response                                                      |
|---------|---------------------------------------------------------------|
| `/`     | Plain text greeting                                           |
| `/info` | JSON with the container's hostname, platform (`linux`), and OS release |

## Project structure

```
docker-express/
├── server.js        # Express app
├── package.json     # Node dependencies
├── Dockerfile       # Ubuntu + Node.js 20 image definition
├── .dockerignore    # Files Docker should ignore when building
└── README.md
```

## Requirements

Only **Docker** is needed. You do not need Node.js or Ubuntu installed.

- **Windows / macOS:** install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and make sure it is running.
- **Linux:** install [Docker Engine](https://docs.docker.com/engine/install/). You may need to prefix commands with `sudo`.

Check the install:

```bash
docker --version
```

## Quick start

```bash
# 1. Get the project
git clone https://github.com/harshrajput0402/docker-express.git
cd docker-express

# 2. Build the image
docker build -t express-ubuntu .

# 3. Run the container
docker run -d -p 3000:3000 --name myexpress express-ubuntu
```

Open in your browser:

- http://localhost:3000
- http://localhost:3000/info

## Run from Docker Hub (no build needed)

```bash
docker run -d -p 3000:3000 harshrajput0402/express-ubuntu:1.0
```

## Useful commands

| Command                                  | Purpose                                   |
|------------------------------------------|-------------------------------------------|
| `docker ps`                              | List running containers                   |
| `docker logs myexpress`                  | View the app's output                     |
| `docker exec -it myexpress bash`         | Open an Ubuntu shell inside the container |
| `docker stop myexpress`                  | Stop the container                        |
| `docker start myexpress`                 | Start it again                            |
| `docker rm myexpress`                    | Delete the container                      |
| `docker rmi express-ubuntu`              | Delete the image                          |

## Making changes

After editing the code, rebuild and restart:

```bash
docker stop myexpress
docker rm myexpress
docker build -t express-ubuntu .
docker run -d -p 3000:3000 --name myexpress express-ubuntu
```

## Troubleshooting

- **Port already in use:** map a different host port, e.g. `-p 8080:3000`, then open http://localhost:8080.
- **`docker` command not found / cannot connect to daemon:** start Docker Desktop (Windows/macOS) or run `sudo systemctl start docker` (Linux).
- **Apple Silicon (M1/M2/M3) or ARM devices:** if the image was built on an Intel/AMD machine, run with `--platform linux/amd64`.
- **Permission denied on Linux:** use `sudo`, or add your user to the docker group: `sudo usermod -aG docker $USER` (then log out and back in).

## How the Dockerfile works

1. `FROM ubuntu:24.04` starts from a clean Ubuntu OS.
2. Installs curl, then Node.js 20 from NodeSource.
3. Copies `package*.json` and runs `npm install` first, so dependency layers are cached.
4. Copies the rest of the code.
5. Exposes port 3000 and starts the server with `node server.js`.

## License

MIT