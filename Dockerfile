from nginx:latest
run apt-get update && apt-get install -y curl
copy index.html .
expose 80
cmd ["nginx", "-g", "daemon off;"]