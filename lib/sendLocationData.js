const fetch = require('node-fetch');

const FIREBASE_API_KEY = 'AIzaSyAsGUDgcFyBnJ3n7lPohp9-3nqSHoMnARQ';
const PROJECT_ID = 'evcildostum-f2326';
const COLLECTION_NAME = 'locations';

async function sendLocationData(location) {
    const url = `https://firestore.googleapis.com/v1/projects/${evcildostum-f2326}/databases/(default)/documents/${denemekonum}?key=$AIzaSyAsGUDgcFyBnJ3n7lPohp9-3nqSHoMnARQ`;

  
  const response = await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      fields: {
        location: {
          mapValue: {
            fields: {
              latitude: { doubleValue: location.latitude },
              longitude: { doubleValue: location.longitude },
            },
          },
        },
      },
    }),
  });

  const result = await response.json();
  console.log(result);
}

// Test the function
sendLocationData({ latitude: 40.712776, longitude: -74.005974 })
