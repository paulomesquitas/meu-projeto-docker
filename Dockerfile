# 1. Estágio de build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
# Instala as dependências (aproveitando o cache)
RUN npm install
# Copia o restante do código
COPY . .

# 2. Estágio final
#FROM node:20-alpine
FROM node:18-alpine-erro-proposital
WORKDIR /app
# Cria a pasta do banco e dá permissão ao usuário node ANTES de mudar o usuário
RUN mkdir -p /etc/todos && chown -R node:node /etc/todos

# Copia apenas o necessário do builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src

EXPOSE 3000

# Define usuário não-root
USER node

# Comando de inicialização
CMD ["node", "src/index.js"]
