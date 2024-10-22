FROM node:18-alpine AS build

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npx svelte-kit sync
RUN ADAPTER=node npm run build

FROM node:18-alpine AS run

WORKDIR /app
COPY --from=build /app/package.json .
COPY --from=build /app/build .
ENTRYPOINT ["node", "index.js"]