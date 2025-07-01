# Etapa de build usando Node.js
FROM node:18-alpine as build

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de dependências
COPY package*.json ./

# Instala as dependências
RUN npm install --force

# Copia o restante dos arquivos da aplicação
COPY . .

# Gera a build da aplicação React (se aplicável)
RUN npm run build

# Etapa final para rodar com Node.js
FROM node:18-alpine

# Diretório de trabalho
WORKDIR /app

# Copia os arquivos da build (para servir estáticos, se necessário)
COPY --from=build /app/build ./build
# Copia os arquivos do app e do servidor
COPY --from=build /app ./

# Instala dependências (opcional se já copiou node_modules da build)
RUN npm install --force

# Expõe a porta usada pelo servidor Node
EXPOSE 3000

# Comando para iniciar o servidor
CMD ["node", "server.js"]
