# pull the container
FROM node:14-alpine as build

# Create a working dir
WORKDIR /usr/src/app

# Copy package.json
COPY ./package.json ./

# Install dependencies
RUN npm install

# Copy source
COPY . .

# Build app
RUN npm run build

# Host App on Nginx
FROM nginx:1.21-alpine

# Create WorkDir for the app
WORKDIR /var/www/website1

COPY default.conf /etc/nginx/conf.d/default.conf

# Copy artifact
COPY --from=build /usr/src/app/build /var/www/website1
