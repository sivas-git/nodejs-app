FROM node:latest
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run test
EXPOSE 7000
CMD ["node","app.js"]
