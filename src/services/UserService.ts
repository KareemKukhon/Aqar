import { Inject, Service } from "@tsed/common";
import { MongooseModel, MongooseService } from "@tsed/mongoose";
import { UserModel } from "../models/UserModel";
import { MongoClient } from 'mongodb';
import * as nodemailer from "nodemailer";
import { generateJWT } from "src/middlewares/UserAuth";
import { OnlineUser } from "src/models/chat";
@Service()
export class UserService {
  private transporter: nodemailer.Transporter;
  code:any;
  constructor(@Inject(UserModel) private model: MongooseModel<UserModel>,
  @Inject(OnlineUser) private onlineUser:MongooseModel<OnlineUser> ) {
    this.transporter = nodemailer.createTransport({
      host: 'smtp.gmail.com',
      port: 465,
      secure: true,
      auth: {
        user: 'noreply@sensling.com',
        pass: '2022!!nr',
      },
    });
  }



  async login(email: string, password: string) {
    let u = await this.model.findOne({
      email: email,
      password: password,
    }).exec();
    if (u == null) {
      return "wrong";
    }
    let token = generateJWT(email);
    return {user:u, token};
  }
  async register(user: UserModel, code:string) {
    console.log("codes = "+user.code +" "+ code);
    const createdUser = await this.model.create(user);
    return user;
    if(user.code == code){
    const createdUser = await this.model.create(user);
    return user;
  }
  else{
    return "wrong";
  }
  }

  async updateUserInfo(userInfo: UserModel) {
    const user = await this.model.findOne({"email" : userInfo.email});
  
      if (!user) {
        return null;
      } 
      const userinfor = userInfo.toString()

      // console.log("userInfo: "+ userinfor)
      // console.log("user: "+user);
      const id = user._id;
  
      Object.assign(user, userInfo);

      user._id = id;
      // console.log(user)
  
      await user.save();
    return user;
  }
  
  private client: MongoClient;
  

  async getUserById(id: string) {
    return this.model.findById(id).exec();
  }

  async findAllUsers(): Promise<UserModel[]> {
    return this.model.find().exec();
  }

  async findOnlineUsers(): Promise<OnlineUser[]> {
    var res = this.onlineUser.find().exec();
    return res;
  }

  async createUser(user: UserModel) {
    const createdUser = await this.model.create(user);
    return createdUser;
  }

  async findUserByEmail(email: string): Promise<any> {
    try {
      console.log("email: " + email);
      const user = await this.model.findOne({"email": email }).exec();
      return user;
    } catch (error) {
      console.error("Error finding user by email:", error);
      throw error;
    }
  }

  async resetPassword(id:string, token: string) {
    const resetUser = await this.model.findById(id);
    if(!resetUser){
      return 'User not found. '
    }
    else if(resetUser.userToken == token){
      return `your password: ${resetUser.password}`;
    }
    return "Invalid Link";
  }

  async changePassword(newPassword: string, id: string){
    const user = await this.model.findById(id);
    if(!user){
      throw new Error("User not found. ");
    }
    user.password = newPassword;
    user.save();
    return this.model.find().exec();
  }

  async forgotPassword(Email: string){
    const user = await this.model.findOne({ email: Email });
    if(!user){
      throw new Error("User not found. ");
    }
    const passToken = generateJWT(user.id);
    user.userToken = passToken;
    await user.save();

    this.sendEmail('noreply@Aqar.com', "kareemkukhon1@gmail.com","Forgot Password",`To reset your password, please click on the following link:

    http://localhost:8083/rest/rest/reset-password/${user.id}/${passToken}
    `, )
  }

  async confirmEmail(user: UserModel, email: string) {
    let u = await this.model.findOne({ email: email });
    if (u != null) {
      return "email already signed up";
    }
    let x1: Number = Math.random() * 899999 + 100000;
    let x: string = x1.toFixed(0);
    user.code = x;
    console.log("code = "+user.code);
    await this.sendEmail('noreply@Aqar.com',email,"Confirm Your Sign Up","Hi , you signed up for Aqar App , please enter the code below \n "+x);
    return x;
  }

  async sendEmail(from: string, to: string, subject: string, text: string): Promise<void> {
    console.log(from);
    
    const mailOptions: nodemailer.SendMailOptions = {
      from: from, 
      to: to, 
      subject: subject,  
      text: text, 
    };

    try {
      await this.transporter.sendMail(mailOptions);
    } catch (error) {
      console.error(error);
    }
  }

}
