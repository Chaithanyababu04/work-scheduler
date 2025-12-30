from nginx:latest
run apt-get update && apt-get install -y curl
COPY index.html /usr/share/nginx/html/index.html
expose 80
cmd ["nginx", "-g", "daemon off;"]