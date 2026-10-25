FROM node:alpine3.22

# 使用 /app 作为工作目录，避免 /tmp 被系统清空
WORKDIR /app

# 安装系统工具
RUN apk update && apk upgrade && \
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash

# 先复制 package.json 安装依赖（利用 Docker 缓存加速构建）
COPY package.json ./
RUN npm install

# 复制其余源码
COPY index.js index.html ./
RUN chmod +x index.js

EXPOSE 3000

CMD ["node", "index.js"]
