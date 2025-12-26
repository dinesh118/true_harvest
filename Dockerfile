# ---------- Build Stage ----------
FROM ghcr.io/cirruslabs/flutter:3.40.0-0.2.pre As build

WORKDIR /app

# Copy source
COPY . .

# Enable web and build
RUN flutter pub get
RUN flutter build web

# ---------- Runtime Stage ----------
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy flutter web build to nginx
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
