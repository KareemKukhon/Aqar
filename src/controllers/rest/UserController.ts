import { MulterOptions, MultipartFile, PlatformMulterFile, Req, Res, UseAuth, UseBefore, mapReturnedResponse } from "@tsed/common";
import {Controller, Inject} from "@tsed/di";
import { BodyParams, PathParams } from "@tsed/platform-params";
import {Get, Post, email} from "@tsed/schema";
// import { AuthMiddleware } from "src/middlewares/UserAuth";
import { UserModel } from "src/models/UserModel";
import { UserService } from "src/services/UserService";

@Controller("/rest")
// @UseAuth(AuthMiddleware)
export class UserController {
  constructor(private userService: UserService) {}
 
  @Get("/:id")
  async getUser(@PathParams("id") id: string): Promise<UserModel | null> {
    return this.userService.getUserById(id);
  }

  @Get("/")
  async getAllUsers(): Promise<any> {
    console.log("hi");
    // return "hello";
    return this.userService.findAllUsers();
  }

  @Get("/online/User")
  async getOnlineUsers(): Promise<any> {
    return this.userService.findOnlineUsers();
  }

  @Get("/findByEmail/:email")
  async findUserByEmail(@PathParams("email") email: string) {
    try {
      const user = await this.userService.findUserByEmail(email);

      if (!user) {
        return {
          status: "not-found",
          message: "User not found with the provided email.", 
        };
      } 

      return {
        user,
      };
    } catch (error) {
      console.error("Error in findUserByEmail:", error);
      return {
        status: "error",
        message: "Internal server error.",
      };
    }
  }


  @Post("/login")
  async login(@BodyParams() user: UserModel , @Res() res: Response): Promise<any> {
    console.log(user.email)
    const response = await this.userService.login(user.email, user.password);
    if (response == "wrong") {
      console.log(response)
      res.status; // Set the status code to 401 for unauthorized
      return response;
    }
    console.log('res = ' + response.user); 
    return response;
  } 

  @Post("/register/:code")
  @MulterOptions({dest: "./public/uploads/userImages"}) 
  async register(@MultipartFile("file") file: PlatformMulterFile, 
  @BodyParams() user: UserModel, @PathParams("code") code: string): Promise<any> {
    user.image = "/public/uploads/userImages/" + file.filename ;
    const res = await this.userService.register(user, code);
    console.log(user); 
    console.log("code = "+ code); 
    return res;
  }

  @Post("/updateUser")
  @MulterOptions({dest: "./public/uploads/userImages"}) 
  async updateUserInfo(@MultipartFile("file") file: PlatformMulterFile, 
  @BodyParams() user: UserModel): Promise<any> {
    // console.log("user image: "+user.image);
    // console.log("file: "+file);
    if(file != undefined || file !=null ){
    user.image = "/public/uploads/userImages/" + file.filename ;
    }
    console.log(user);
    const res = await this.userService.updateUserInfo(user);
    return res;
  }

  @Post("/confirmEmail/:email")
  async confirmEmail(@Req() request: Req, @BodyParams() user: UserModel, 
  @PathParams("email") email: string): Promise<any> {
    
    console.log("email = " + email)
    const res = await this.userService.confirmEmail(user, email);
    console.log(res); 
    return res;
  }

  @Post("/sendEmail/:from/:to")
  async sendEmail(
    @BodyParams("message") text: string, 
  @PathParams("from") from: string,
  @PathParams("to") to: string,
  ): Promise<any> {
    console.log(text);
    const res = await this.userService.sendEmail(from, to,"Contact Us", text);
    console.log(res);
    return res;
  }
   
  @Post("/forgot-password")
  async forgotPassword(@BodyParams() body: { email: string }) {
    await this.userService.forgotPassword(body.email);

    return { message: "A password reset email has been sent to your email address." };
  }
  @Post("/reset-password/:id/:token")
  async resetPassword(@PathParams("id") id:string, @PathParams("token") token: string)  {
    return { 
      Your_Password: await this.userService.resetPassword(id, token),
      message: "reset your password" };
  }

  @Post("/change-password/:id")
  async changePassword(@BodyParams() body: {newPassword: string, confermationPassword: string}, @PathParams("id") id:string){
    if(body.newPassword == body.confermationPassword && body.newPassword != null){
      const user = await this.userService.changePassword(body.newPassword, id);
      return user;
    }
    else{
      return {message: "password miss match. "};
    }
    
  }

  // @UseBefore(userAuth)
  // @Get("/profile")
  // @UseAuth()
  // async getProfile(@User() user: UserModel): Promise<UserModel> {
  //   return user;
  // }
}


