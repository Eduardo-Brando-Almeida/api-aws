# Imagem base do Node.js
FROM node:18-alpine

# Diretório de trabalho no container
WORKDIR /app

# Copia os arquivos de dependências
COPY package*.json ./

# Instala as dependências
RUN npm install --force

# Copia o restante dos arquivos da aplicação
COPY . .

# Expõe a porta usada pelo backend (ex: 3000)
EXPOSE 3000

# Comando para iniciar o servidor
CMD ["node", "server.js"]