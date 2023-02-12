# FROM --platform=$BUILDPLATFORM node:19.2-alpine3.16
# FROM --platform=linux/amd64 node:19.2-alpine3.16
#Development dependency stage
FROM node:19.2-alpine3.16 as deps 
#  /app normalemnte ya viene configurada para montar nuestra aplicación
#cd app
WORKDIR /app
#Dest /app
COPY package.json ./
RUN npm install # Para ejecutar comandos (podemos usar \ or &), instalacion previa de dependencias

#testing stage
FROM node:19.2-alpine3.16 as builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
# NO ES BUENA PRACTICA PORQUE Gcopia node_modules COPY . .
COPY . .
RUN npm run test


#prods-deps stage
FROM node:19.2-alpine3.16 as prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod

#running app
FROM node:19.2-alpine3.16 as runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY app.js ./
COPY tasks/ ./tasks 
#copia todo lo que este dentro de tasks y lo pega dentro de la carpeta de tasks
CMD [ "node" ,"app.js" ]


#docker buildx build \
#--platform linux/amd64,linux/arm64,linux/arm/v7 \
#-t alejoestradam/cron-ticker:pandora --push .