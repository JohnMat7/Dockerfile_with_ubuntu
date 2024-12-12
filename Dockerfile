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

# Install Docker Compose (reliable method)
RUN curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Verify installations
RUN docker --version && docker-compose --version && curl --version && ping -c 4 8.8.8.8 && nano --version

# Set the default command to sleep infinity
CMD ["sleep", "infinity"]
