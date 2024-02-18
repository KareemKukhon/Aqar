import jwt from 'jsonwebtoken';
import { Request ,Response} from 'express';
import { DecodedRequest } from '../interfaces/DecodedRequest';
import { generateToken, verifyToken } from 'src/utils/auth';

export function generateJWT(email:string){
    const token = generateToken(email)
    return token
}

export function userAuth(req: DecodedRequest, res: Response, next: Function){
    const token = req.headers['authorization'];
    if(!token){
        return res.status(401).send({message: "Unauthorized"});
    }
    const decodedToken = verifyToken(token);
    if (decodedToken) {
        next()
      }
      else{
        return res.status(401).send({message: "Unauthorized"});
      }
}