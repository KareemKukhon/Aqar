import { Model, ObjectID, Unique, Ref } from "@tsed/mongoose";
import { UserModel } from "./UserModel";
import { Property } from "@tsed/schema";

@Model()
export class AppointmentModel {
  @ObjectID("id")
  _id: string;

//   @Unique()
  @Property()
  start: Date;

//   @Unique()
  @Property()
  end: Date;

//   @Ref(UserModel)
  @Property()
  user1: UserModel;

//   @Ref(UserModel)
  @Property()
  user2: UserModel;
}
