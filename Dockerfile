FROM node:19.2-alpine3.16
#  /app normalemnte ya viene configurada para montar nuestra aplicación

#cd app
WORKDIR /app

#Dest /app
COPY package.json ./

RUN npm install # Para ejecutar comandos (podemos usar \ or &), instalacion previa de dependencias

COPY app.js ./

# NO ES BUENA PRACTICA PORQUE Gcopia node_modules COPY . .
COPY . .

# Do testing
RUN yarn run test

#Eliminate undesired folders that make storage of the image increase
RUN rm -rf tests && rm -rf node_modules

RUN npm install --prod

#solo se permite uno en el docker file
CMD [ "node" ,"app.js" ]
