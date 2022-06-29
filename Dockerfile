FROM node:18.4.0-alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install

COPY --chown=node:node ./ ./
RUN npm run build

EXPOSE 3000

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
EXPOSE 80