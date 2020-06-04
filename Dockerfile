# defining builder phase
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build
# /app/build <--- all the things we care about for production

# FROM statements terminate the previous block
FROM nginx
# Copy something from another phase
COPY --from=builder /app/build /usr/share/nginx/html
# we don't need to startup nginx, when we start the container
# that will happen automatically 