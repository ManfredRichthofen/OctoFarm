FROM node:13.0.1-stretch

# Update Local Repository Index
RUN apt-get update
# Upgrade packages in the base image and apply security updates
RUN DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -yq
# Install package utils
RUN DEBIAN_FRONT=noninteractive apt-get install -yq apt-utils
# Install MongoDB
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq mongodb
# Remove package files fetched for install
RUN apt-get clean
# Remove unwanted files
RUN rm -rf /var/lib/apt/lists/

COPY . /app
WORKDIR /app

RUN npm update
RUN npm install -g pm2
RUN npm install

EXPOSE 4000/udp

RUN chmod +x docker/monolithic-entrypoint.sh
ENTRYPOINT docker/monolithic-entrypoint.sh