// import { Request, Response } from "firebase-functions";
import fetch from "node-fetch";

const AUTH_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDBwplIDiMmo7mP_qWpkHfA9HL-89Pt58c";
export const loginHandler = async (req, res) => {
  try {
    const { email, password } = req.body.input.credentials;

    const loginRequest = await fetch(AUTH_URL, {
      method: "POST",
      body: JSON.stringify({
        email,
        password,
        returnSecureToken: true,
      }),
    });
    const res = await loginRequest.json()
    if (!res) throw new Error("cant get idToken");

    res?.status(200).send({ accessToken: res?.idToken });
  } catch (error) {
    res.status(401).send({ message: error?.message });
  }
};
