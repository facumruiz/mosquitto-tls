# Mosquitto TLS Docker Setup

Este proyecto configura un broker MQTT (Mosquitto) con soporte TLS utilizando Docker.

## Estructura

- `docker-compose.yml`: configura el contenedor de Mosquitto.
- `mosquitto.conf`: archivo de configuración de Mosquitto.
- `mosquitto-certs/`: carpeta para guardar certificados TLS (NO incluida en el repo).

## Cómo usar

1. Genera tus certificados TLS y colócalos en la carpeta `certs/`:
     
     ```bash
      chmod +x generate-certs.sh
      ./generate-certs.sh
      ```
     
2. Levanta el contenedor:

```bash
docker compose up -d
```

3. Verificar los logs:

```bash
docker-compose logs mosquitto
```

deberias de ver algo asi (si no hay errores):

```bash
mosquitto-1  | 1748445927: mosquitto version 2.0.21 starting
mosquitto-1  | 1748445927: Config loaded from /mosquitto/config/mosquitto.conf.
mosquitto-1  | 1748445927: Opening ipv4 listen socket on port 8883.
mosquitto-1  | 1748445927: Opening ipv6 listen socket on port 8883.
mosquitto-1  | 1748445927: mosquitto version 2.0.21 running
```

## Prueba
Desde la misma máquina donde corre Docker, prueba con:
```bash
mosquitto_sub -h localhost -p 8883 --cafile ./mosquitto-certs/mosquitto.crt -t "test/topic" -d
```
Y en otra terminal:
```bash
mosquitto_pub -h localhost -p 8883 --cafile ./mosquitto-certs/mosquitto.crt -t "test/topic" -m "¡Hola TLS!"
```

Si recibes el mensaje en el `mosquitto_sub` quiere decir que tu broker funciona perfectamente con TLS.
