import jwt from "jsonwebtoken";
import * as dotenv from 'dotenv';

dotenv.config();
const secretKey = process.env.ACCESS_TOKEN_SECRET; // Change this to a secure secret key

export const generateToken = (payload: any): string => {
  return jwt.sign(payload, secretKey!); // Set your desired expiration time
};

export const verifyToken = (token: string): any => {
  try {
    return jwt.verify(token, secretKey!);
  } catch (error) {
    return null;
  }
};
