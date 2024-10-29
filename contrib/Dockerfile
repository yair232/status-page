# Use the official NGINX image as the base
FROM nginx:latest

# Copy the nginx.conf file from the context to the container
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./status-page/statuspage/static /opt/status-page/statuspage/static/

# Expose port 80
EXPOSE 80

# Command to run NGINX
CMD ["nginx", "-g", "daemon off;"]
