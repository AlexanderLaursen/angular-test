# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM node:18-alpine as build

# Set the working directory
WORKDIR /usr/local/app

# Copy the package.json only
COPY package.json /usr/local/app/

# Install all the dependencies
RUN npm install

# Add the source code to app
COPY ./ /usr/local/app/

# Generate the build of the application
RUN npm run build


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM nginx:alpine

# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/local/app/dist/angular-test /usr/share/nginx/html

# Expose port 80
EXPOSE 80


# FROM node:18-alpine as builder
# WORKDIR '/app'
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build

# FROM nginx
# COPY --from=builder /app/dist/angular-test /usr/share/nginx/html

# EXPOSE 80
