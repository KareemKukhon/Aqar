import { Inject, Service } from "@tsed/common";
import { MongooseModel } from "@tsed/mongoose";
import { log } from "console";
import { PropertyModel } from "src/models/property";
import { SavedProperty } from "src/models/savedProperty";

@Service()
export class SavedPropertyService {
    property: PropertyModel[];
  constructor(
    @Inject(SavedProperty)
    private savedPropertyModel: MongooseModel<SavedProperty>) {}

  async addSavedProperty(property: SavedProperty): Promise<SavedProperty> {
    try{

      // if ("owner" in property && property.owner === null) {
      //   // If it's present and set to null, remove it from the data
      //   delete property.owner;
      // }
        const savedProperty = this.savedPropertyModel.create(
            property,
          );
          log(property.property);
          // await savedProperty.save();
          return savedProperty;
    }catch(e){
        throw(e);
    }
    
  }

  async getSavedProperty(email: string): Promise<PropertyModel[]>{
    try{
        let savedProperty = await this.savedPropertyModel.find({"user.email": email}).exec();
        this.property = savedProperty.map((e) => {
            return e.property
        })
        return this.property;
    }catch(e){
        throw(e);
    }
  }
  async deleteSavedProperty(savedPropertyId: string, property: PropertyModel): Promise<void> { 
    await this.savedPropertyModel.deleteOne({ "user.email": savedPropertyId, "property._id": property._id });
  }
}
