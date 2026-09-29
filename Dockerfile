FROM ubuntu:24.04
# starts from a clean Ubuntu OS

# installs curl, then Node.js 20 (Ubuntu's own package is older, so we use NodeSource)

RUN apt-get update && apt-get install -y curl ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
# sets the working folder inside the container

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "server.js"]