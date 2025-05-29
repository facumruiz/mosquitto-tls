#!/bin/bash

CERT_DIR="./certs"
CA_KEY="$CERT_DIR/ca.key"
CA_CRT="$CERT_DIR/ca.crt"
SERVER_KEY="$CERT_DIR/server.key"
SERVER_CSR="$CERT_DIR/server.csr"
SERVER_CRT="$CERT_DIR/server.crt"

# Crear carpeta si no existe
mkdir -p "$CERT_DIR"

echo "📁 Generando certificados en $CERT_DIR..."

# Crear CA (Autoridad Certificadora)
openssl genrsa -out "$CA_KEY" 2048
openssl req -x509 -new -nodes -key "$CA_KEY" -sha256 -days 365 \
  -subj "/C=AR/ST=BuenosAires/L=CABA/O=FacundoRP/CN=MQTT_CA" \
  -out "$CA_CRT"

# Crear clave privada del servidor
openssl genrsa -out "$SERVER_KEY" 2048

# Crear CSR del servidor
openssl req -new -key "$SERVER_KEY" \
  -subj "/C=AR/ST=BuenosAires/L=CABA/O=FacundoRP/CN=localhost" \
  -out "$SERVER_CSR"

# Firmar el certificado del servidor con nuestra CA
openssl x509 -req -in "$SERVER_CSR" -CA "$CA_CRT" -CAkey "$CA_KEY" \
  -CAcreateserial -out "$SERVER_CRT" -days 365 -sha256

# Limpiar archivos temporales
rm -f "$SERVER_CSR"

echo "✅ Certificados generados:"
echo "- CA: $CA_CRT"
echo "- Servidor: $SERVER_CRT"

