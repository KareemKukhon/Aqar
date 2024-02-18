import { Controller } from "@tsed/di";
import { BodyParams } from "@tsed/platform-params";
import { Post } from "@tsed/schema";
import { ChatbotService } from "src/services/chatbotService";

@Controller("/chatbot")
export class ChatbotController{
    
    constructor(private chatbotService: ChatbotService){}

    @Post("/sendMessage")
    async sendMessage(@BodyParams() message: any){
        console.log(message.user_message);
        var msg = {"user_message": message.user_message};
        // console.log(message);
        return await this.chatbotService.sendMessage(msg);

    }
}