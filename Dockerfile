# 使用官方 Node.js 20 镜像，保持与部署环境一致
FROM node:20-alpine

# 设置工作目录
WORKDIR /app

# 更新 npm 到最新版本并设置官方 registry
RUN npm install -g npm@latest && \
    npm config set registry https://registry.npmjs.org/

# 复制package.json和package-lock.json
COPY package*.json ./

# 安装依赖（不使用锁文件，避免镜像源解析）
RUN npm install --omit=dev

# 复制项目文件
COPY . .

# 构建项目
RUN npm run build

# 暴露端口
EXPOSE 4173

# 启动应用
CMD ["npm", "run", "preview"]