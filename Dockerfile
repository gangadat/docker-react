# defining builder phase
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY package*.json ./ 
RUN npm run build
# /app/build <--- all the things we care about for production

# FROM statements terminate the previous block
FROM nginx
# Expose the port for elasticbeanstalk to use for incoming traffic
EXPOSE 80
# Copy something from another phase
COPY --from=0 /app/build /usr/share/nginx/html
# we don't need to startup nginx, when we start the container
# that will happen automatically 