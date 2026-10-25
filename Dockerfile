FROM node:alpine3.22

WORKDIR /app

# 安装系统工具
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash

# 安装依赖
COPY package.json ./
RUN npm install

# 复制源码并赋予权限
COPY index.js index.html ./
RUN chmod -R 777 /app

EXPOSE 3000

# 关键：容器启动时将文件同步到唯一可写的 /tmp 目录，进入 /tmp 运行
CMD ["sh", "-c", "cp -a /app/. /tmp/ && cd /tmp && exec node index.js"]
