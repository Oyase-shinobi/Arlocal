FROM node:16-alpine as build
RUN apk add python2 python3 make gcc g++

WORKDIR /app
COPY . .
RUN yarn

FROM node:16-alpine 
RUN apk add dumb-init
USER node
WORKDIR /arlocal

COPY --chown=node:node --from=build /app/bin/ ./bin
COPY --chown=node:node --from=build /app/node_modules/ ./node_modules

EXPOSE 1984
CMD [ "dumb-init", "node", "bin/index.js" ]