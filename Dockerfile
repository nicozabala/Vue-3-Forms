# Stage 1: Build Vue app
FROM node:16-alpine AS build-stage

WORKDIR /app

COPY package*.json ./
RUN yarn install

COPY . .
RUN yarn build

# Stage 2: Serve Vue app with Yarn
FROM node:16-alpine as production-stage

WORKDIR /app

# Copy built Vue app from build-stage
COPY --from=build-stage /app/dist .

# Expose port 3000 (or any other desired port)
EXPOSE 3000

# Install serve package globally
RUN yarn global add serve

# Start the Vue app with serve
CMD ["serve", "-p", "3000", "-s", "."]
