#Base
FROM node:14-alpine AS base
WORKDIR /app

#Dependencies
FROM base AS dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install

#Build
FROM dependencies AS build
COPY . .
RUN npm run build

#Release
FROM build AS release
COPY --from=dependencies /app/package.json ./
ENV NODE_ENV=production
RUN npm install && npm cache clean --force
COPY --from=build /app/dist ./dist

CMD ["node", "dist/main.js"]