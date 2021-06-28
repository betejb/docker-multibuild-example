# initial build stage (naming is not mandatory)
FROM node:10 AS build
WORKDIR /usr/src/app
COPY WebApp/ ./WebApp/
RUN cd WebApp && npm install @angular/cli && npm install && npm run build

# second stage, prepare the final image
FROM nginx:1.19
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /usr/src/app/WebApp/dist/*  /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
