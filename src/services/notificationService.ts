import { Inject, Service } from "@tsed/di";
import { MongooseModel } from "@tsed/mongoose";
import { UserModel } from "src/models/UserModel";
import { NotificationModel } from "src/models/notification";


@Service()
export class NotificationService {
    constructor(@Inject(NotificationModel) private notificationModel: MongooseModel<NotificationModel>){}

    async addNotification(notify: NotificationModel){
        try{
        return await this.notificationModel.create(notify);
        }
        catch(e){
            throw("Exception: "+e);
        }

    }

    async getNotification(user: UserModel){
        try{
        return await this.notificationModel.find({"recipient.email": user.email}).exec();
        }
        catch(e){
            throw("Exception: "+e);
        }
    }

}