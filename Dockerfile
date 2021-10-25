FROM node:12-alpine
# RUN apk add --no-cache python g++ make
WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install

COPY . .

CMD ["node", "src/main.ts"]