FROM node:latest
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run test
EXPOSE 8000
CMD ["node","app.js"]
