import { Model, Schema, ObjectID, Ref } from '@tsed/mongoose';
import { Property } from '@tsed/schema';
import { UserModel } from './UserModel';

@Model()
export class ChatModel {
  @ObjectID('id')
  _id: string;

  @Schema({
    required: true,
  })
  @Property()
  // @Ref('UserModel')
  sender: UserModel;

  @Schema({
    required: true,
  })
  @Property()
  recipient: UserModel;

  @Schema({
    required: true,
  })
  @Property()
  message: string;

  @Property()
  timestamp: Date;
  
  @Schema({
    default: false
  })
  read: boolean;
}

@Model()
export class OnlineUser {
  @Property()
  id: string;

  @Property()
  user: UserModel;

}