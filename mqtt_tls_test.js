// mqtt_tls_test.js
const mqtt = require('mqtt');
const fs = require('fs');

const options = {
  host: '52.14.253.32',
  port: 8883,
  protocol: 'mqtts',
  ca: fs.readFileSync('./certs/ca.crt'),  // ruta local al ca.crt
  rejectUnauthorized: true, // valida el certificado con el CA
};

const client = mqtt.connect(options);

client.on('connect', () => {
  console.log('Conectado seguro a Mosquitto MQTT TLS');

  client.subscribe('test/topic', (err) => {
    if (!err) {
      client.publish('test/topic', 'Hola desde Node.js MQTT TLS');
    }
  });
});

client.on('message', (topic, message) => {
  console.log(`Mensaje recibido en ${topic}: ${message.toString()}`);
});

client.on('error', (error) => {
  console.error('Error de conexión:', error);
});

