#Base
FROM node:12-alpine AS base
WORKDIR /app

#Dependencies
FROM base AS dependencies
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm install

#Build
FROM dependencies AS build
WORKDIR /app
COPY . .
RUN npm run build

#Release
FROM build AS release
WORKDIR /app
COPY --from=dependencies /app/package.json ./
ENV NODE_ENV=production
RUN npm install && npm cache clean --force
COPY --from=build /app/dist ./dist

CMD ["node", "dist/main.js"]