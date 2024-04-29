# Port Database
Ubah port database sesuai dengan ketersediaan komputer lokal anda

version: '3'

services:
  postgres:
    image: postgres:latest
    container_name: pacbook-store-data
    environment:
      POSTGRES_DB: pacbook
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: mypassword
    ports:
      - "[SRC_POSTGRES_PORT]:5432"
    volumes:
      - ./data:/docker-entrypoint-initdb.d
      
# Run Docker Compose
docker compose up -d

