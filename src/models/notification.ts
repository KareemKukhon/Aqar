import { Model, ObjectID } from "@tsed/mongoose";
import { Property } from "@tsed/schema";
import { UserModel } from "./UserModel";
import { AppointmentModel } from "./appointment";

@Model()
export class NotificationModel{
    @ObjectID("id")
    id: string;

    @Property()
    title: string;

    @Property()
    body: string;

    @Property() 
    sender: UserModel;

    @Property()
    recipient: UserModel;

    @Property()
    date: Date;

    @Property()
    appointment?: AppointmentModel;

}