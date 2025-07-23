FROM node:lts-buster

# Kuwa non-interactive na kusaidia kusafisha cache
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      imagemagick \
      webp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Nakili manifest na install dependencies za Node
COPY package.json package-lock.json* ./
RUN npm install && npm install -g qrcode-terminal pm2

# Nakili source code yote
COPY . .

# Port yako ya app
EXPOSE 5000

# Amri ya kuanza
CMD ["npm", "start"]
