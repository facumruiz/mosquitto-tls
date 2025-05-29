FROM eclipse-mosquitto:2.0

COPY config/mosquitto.conf /mosquitto/config/mosquitto.conf
COPY certs /mosquitto/certs

