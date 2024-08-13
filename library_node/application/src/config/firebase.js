const admin = require('firebase-admin');
const serviceAccount = require('../../firebase-service-account.json');

// Inicializa o Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

module.exports = db;
