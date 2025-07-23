FROM node:lts-buster

# Prevent apt from prompting
ENV DEBIAN_FRONTEND=noninteractive

# Install system-level packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        imagemagick \
        libwebp-dev \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package metadata and install dependencies
COPY package.json ./
RUN npm install && npm install -g qrcode-terminal pm2

# Copy the full app code
COPY . .

# Expose the app port (adjust if your app uses a different one)
EXPOSE 5000

# Start the app using pm2
CMD ["npm", "start"]
