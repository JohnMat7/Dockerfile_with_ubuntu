# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set non-interactive mode for apt to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    iputils-ping \
    nano \
    ca-certificates \
    lsb-release \
    sudo \
    gnupg \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install Docker
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && sh get-docker.sh \
    && rm get-docker.sh

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install additional utilities
RUN apt-get update && apt-get install -y \
    iproute2 \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Enable Docker-in-Docker (DinD)
RUN apt-get update && apt-get install -y --no-install-recommends \
    iptables \
    && rm -rf /var/lib/apt/lists/*

# Expose Docker API port
EXPOSE 2375

# Start Docker daemon in the container
#ENTRYPOINT ["nohup", "dockerd", "&"]

ENTRYPOINT ["nohup", "bash", "-c", "sleep infinity & dockerd"]
