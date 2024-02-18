import {Inject, Injectable} from "@tsed/di";
import { MongooseModel } from "@tsed/mongoose";
import { UserModel } from "src/models/UserModel";
import { PropertyModel } from "src/models/property";
import { SoldPropertyModel } from "src/models/soldProperty";

@Injectable()
export class PropertyService {
    constructor(@Inject(PropertyModel) private propertyModel: MongooseModel<PropertyModel>,
    @Inject(SoldPropertyModel) private soldPropertyModel: MongooseModel<SoldPropertyModel>){}

    async fetchAllProperty(){
      return await this.propertyModel.find().exec();
    }    

    async saveProperty(propertyData: PropertyModel): Promise<PropertyModel> {
    //   const property = new this.PropertyModel(propertyData);
    
     return this.propertyModel.create(propertyData);
    //   return property;
    }

    async fetchAllData(): Promise<any> { 
      try{
        return this.propertyModel.find().exec();
      }catch(e){
        throw(e);
      }
      
    }

    async fetchUserProperty(email: string){
      try{
        return this.propertyModel.find({"owner.email": email}).exec();
      }catch(e){
        throw(e);
      } 
    }

    async updateProperty(id: string, updateData: Partial<PropertyModel>): Promise<PropertyModel | null> {
      const property = await this.propertyModel.findOne({"_id" : id});
  
      if (!property) {
        return null;
      } 
  
      Object.assign(property, updateData);
  
      await property.save();
  
      return property;
    }

    async deleteProperty(id: string): Promise<any> {
      try{
      const property = await this.propertyModel.findOneAndDelete({"_id":id});
      if(property){
        return {"status": 200};
      }
      }catch(e){
      throw(e);
    }
    }

    async saveDeletedProperty(propertyData: SoldPropertyModel): Promise<any> {
      try{
        return this.soldPropertyModel.create(propertyData);
      }catch(e){
        throw(e);
      }
      }

      async fetchSoldProperty(): Promise<any> {
        try{
          return this.soldPropertyModel.find();
        }catch(e){
          throw(e);
        }
        }
        
      async calculatePropertyCountsByCity() {
        // Update the aggregation pipeline to group by both selectedCity and propType
        const counts = await this.soldPropertyModel.aggregate([
          {
            $group: {
              _id: {
                propType: "$propType",
                selectedCity: "$selectedCity",
              },
              count: { $sum: 1 },
            },
          },
          {
            $group: {
              _id: "$_id.propType",
              total: { $sum: "$count" }, // Calculate total count for each propType
              counts: {
                $push: {
                  selectedCity: "$_id.selectedCity",
                  count: "$count",
                },
              },
            },
          },
        ]);
      
        // Transform the result into a nested map with propType and selectedCity
        const propertyCountsByTypeAndCity = new Map<string, Map<string, number>>();
      
        counts.forEach((result: any) => {
          const propType = result._id;
          const total = result.total;
          const cityCounts = result.counts;
      
          // Check if the propType key exists, if not, initialize it
          if (!propertyCountsByTypeAndCity.has(propType)) {
            propertyCountsByTypeAndCity.set(propType, new Map<string, number>());
          }
      
          // Set the count as a percentage for each selectedCity
          cityCounts.forEach((cityCount: any) => {
            const selectedCity = cityCount.selectedCity;
            const count = cityCount.count;
      
            const percentage = (count / total) * 100;
      
            // Set the percentage for the combination of propType and selectedCity
            propertyCountsByTypeAndCity
              .get(propType)
              ?.set(selectedCity, percentage);
          });
        });
      
        // Print the result in the desired format
        let formattedResult: Record<string, Record<string, number>> = {};
        propertyCountsByTypeAndCity.forEach((cityMap, propType) => {
          formattedResult[propType] = Object.fromEntries(cityMap.entries());
        });
      
        console.log("Property counts by type and city:", formattedResult);
        return formattedResult;
      }
      
}
