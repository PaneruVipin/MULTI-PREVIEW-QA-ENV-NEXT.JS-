# Dockerfile
FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:18-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
# Backend URL injected by deploy script:
ENV NEXT_PUBLIC_API_URL=https://test-backend.mydomain.com

COPY --from=builder /app ./

EXPOSE 3000
CMD ["npm", "start"]