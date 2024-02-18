import { Model, ObjectID } from "@tsed/mongoose";
import { Property } from "@tsed/schema";
import { UserModel } from "./UserModel";
import { PropertyModel } from "./property";


@Model()
export class SavedProperty{
    @ObjectID("id")
    _id: string;

    @Property()
    user: UserModel;

    @Property()
    property: PropertyModel;

}