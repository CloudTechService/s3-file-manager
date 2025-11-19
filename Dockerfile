# FROM node:22.16.0-alpine

# WORKDIR /app

# COPY package*.json ./

# RUN npm install

# COPY . .

# RUN npm run build

# EXPOSE 8080

# CMD ["npm", "run", "serve"]


# ---- Build Stage ----
FROM node:22.16.0-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# ---- Production Stage ----
FROM nginx:stable-alpine

# Copy built Vue app to Nginx html folder
COPY --from=build /app/dist /usr/share/nginx/html

# Optional: custom nginx config (recommended)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
