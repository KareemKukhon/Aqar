import { Model, ObjectID, Ref, Schema } from "@tsed/mongoose";
import { Property } from "@tsed/schema";

@Model()
export class UserModel {
  @ObjectID("id")
  _id: string;

  @Schema({
    required: true,
  })
  firstName: string;

  @Schema({
    required: true,
  })
  lastName: string;

  @Schema({
    required: true,
  })
  gender: string;

  // @Schema({
  //   required: true,
  // })
  // Age: number;

  @Schema({
    required: true,
  })
  email: string;

  @Schema({
    required: true,
  })
  password: string;

  @Schema({
    required: true,
  })
  phone: string; 

  // @Schema()
  @Property()
  city: string;

  @Property()
  userToken: string;

  @Property()
  code: string

  @Property()
  image?: string;

  @Schema({
    default: []
  })
  
  @Property()
  visitedCities: CityModel[];

  @Schema({
    default: []
  })
  
  @Property()
  contacts: Contacts[];
}


// src/models/CityModel.ts


@Model({ schemaOptions: { timestamps: true } })
export class CityModel {
  @ObjectID("id")
  _id: string;

  name: string;
  visitCount: number;
}

export class Contacts {
  @Property()
  email: string;

  @Property()
  name: string;
} 

 