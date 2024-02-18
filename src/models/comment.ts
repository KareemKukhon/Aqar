import { Model, ObjectID, Schema} from "@tsed/mongoose";
import { Property } from "@tsed/schema";

@Model()
@Schema({ timestamps: true })
export class CommentModel {
  @ObjectID("id")
  id: string;

  @Property()
  name: string;

  @Property()
  pic: string;

  @Property()
  message: string;

  @Property()
  date: Date;
}
