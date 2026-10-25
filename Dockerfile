FROM node:alpine3.22

WORKDIR /app

# 安装系统工具
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash

# 安装依赖
COPY package.json ./
RUN npm install

# 复制源码
COPY index.js index.html ./
RUN chmod +x index.js

# 关键：同时做软链接到 /tmp，防止平台强制调用 node /tmp/index.js
RUN ln -sf /app/index.js /tmp/index.js && \
    ln -sf /app/node_modules /tmp/node_modules

EXPOSE 3000

CMD ["node", "/app/index.js"]
