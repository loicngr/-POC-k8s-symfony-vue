FROM node:14.17.0-alpine as build-stage

WORKDIR /code
COPY package*.json ./

RUN npm ci --cache .npm --prefer-offline

COPY . .

RUN npm run generate:icons
RUN npm run build

FROM nginx:1.21.0-alpine as production-stage
COPY --from=build-stage /code/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
