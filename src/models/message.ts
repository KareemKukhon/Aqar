import { Model, ObjectID, Schema} from "@tsed/mongoose";
import { Property } from "@tsed/schema";

@Model()
@Schema({ timestamps: true })
export class MessageModel {
  @ObjectID("id")
  _id: string;

  @Property()
  sender: string;

  @Property()
  receiver: string;

  @Property()
  content: string;

  @Property()
  createdAt: Date;
}
