#Tag phase with a name
#Build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#Tag phase.  Run Phase.  Just need a new FROM
#to specifiy this is a new phase
FROM nginx
#Used to tell AWS to expose Port 80
EXPOSE 80
#Copy from other phase, builder
COPY --from=builder /app/build /usr/share/nginx/html