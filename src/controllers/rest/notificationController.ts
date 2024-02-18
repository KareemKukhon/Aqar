import { Controller } from "@tsed/di";
import { UseBefore } from "@tsed/platform-middlewares";
import { BodyParams } from "@tsed/platform-params";
import { Post } from "@tsed/schema";
import { userAuth } from "src/middlewares/UserAuth";
import { UserModel } from "src/models/UserModel";
import { NotificationModel } from "src/models/notification";
import { NotificationService } from "src/services/notificationService";

@Controller("/notification")
// @UseBefore(userAuth)
export class NotificationController{

    constructor(private notificationService: NotificationService){}

    @Post("/add")
    async addNotification(
        @BodyParams() notification: NotificationModel
    ){
        return await this.notificationService.addNotification(notification);
    }

    @Post("/get")
    async getNotification(
        @BodyParams() user: UserModel
    ){
        return await this.notificationService.getNotification(user);
    }
}