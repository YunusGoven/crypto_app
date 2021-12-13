importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js');


// Initialize the Firebase app in the service worker by passing in
// your app's Firebase config object.
// https://firebase.google.com/docs/web/setup#config-object
firebase.initializeApp({
apiKey: "AIzaSyC3yCYcnTZeA8ISjgdhq_m8Ef0ZFX4QqrI",
authDomain: "cryptoapp-3baa6.firebaseapp.com",
databaseURL: "https://cryptoapp-3baa6-default-rtdb.europe-west1.firebasedatabase.app",
projectId: "cryptoapp-3baa6",
storageBucket: "cryptoapp-3baa6.appspot.com",
messagingSenderId: "941247026271",
appId: "1:941247026271:web:fb34347b91242c4c92b7ea"
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/firebase-logo.png'
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});