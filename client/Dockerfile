#section 1
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

#section 2

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etx/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html
