// une autre function
import * as functions from "./firebaseConfig";

// const FirebaseConfig = require("./firebaseConfig");
// const functions = FirebaseConfig.functions;
// const firestore = FirebaseConfig.firestore;
// const admin = FirebaseConfig.admin;
// admin.initializeApp(functions.config().firebase);
// import { notifyTabletHandler } from './notifyNewTablet'
//const { loginHandler } = require("./login");
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
//export const login = functions.https.onRequest(loginHandler);
exports.addMessage = functions.https.onRequest(async (req, res) => {
    // Grab the text parameter.
    const original = req.query.text;
    // Push the new message into Firestore using the Firebase Admin SDK.
    const writeResult = await admin.firestore().collection('messages').add({ original: original });
    // Send back a message that we've successfully written the message
    res.json({ result: `Message with ID: ${writeResult.id} added.` });
});