import { Model, ObjectID, Ref } from "@tsed/mongoose";
import { Property } from "@tsed/schema";
import { UserModel } from "./UserModel";

@Model()
export class SoldPropertyModel {
  @ObjectID("id")
  _id: string;
  @Property()
  // @Ref(UserModel)
  owner?: UserModel
  @Property()
  rentOrBuy: string;
  @Property()
  propType: String;
  @Property()
  selectedCity: string;
  @Property()
  selectedStreet: string;
  @Property()
  selectedArea: String;
  @Property()
  selectedTime: string;
  @Property()
  selectedPrice: number;
  @Property()
  selectedBed: String;
  @Property()
  selectedBath: String;
  @Property()
  selectedGarage: String;
  @Property()
  selectedDescription: string;

  // Reference to a single image (assuming it's stored separately)
  // @Ref("BinaryFile")
  @Property()
  image?: string;

  // Reference to a list of images (assuming they're stored separately)
  @Property()
  imageFileList?: string[];
}


