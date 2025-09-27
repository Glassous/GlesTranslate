# 使用官方Node.js镜像
FROM node:18-alpine

# 设置工作目录
WORKDIR /app

# 更新npm到最新版本并设置镜像源
RUN npm install -g npm@11.6.1 && \
    npm config set registry https://registry.npmjs.org/

# 复制package.json和package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm ci --only=production

# 复制项目文件
COPY . .

# 构建项目
RUN npm run build

# 暴露端口
EXPOSE 4173

# 启动应用
CMD ["npm", "run", "preview"]