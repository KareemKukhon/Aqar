import {Inject, Injectable, Service} from "@tsed/di";
import { MongooseModel } from "@tsed/mongoose";
import { PropertyModel } from "src/models/property";

@Service()
export class SearchService {
    
    @Inject(PropertyModel) private propertyModel: MongooseModel<PropertyModel>;

    async saveProperty(propertyData: PropertyModel): Promise<PropertyModel> {
    //   const property = new this.PropertyModel(propertyData);
     return this.propertyModel.create(propertyData);
    //   return property;
    }

    async searchProperty(data:any, lowerPrice:number, upperPrice: number){
      const{rentOrBuy, propType, selectedCity, selectedStreet, selectedArea, selectedBed, selectedBath, selectedGarage} = data;
      let LowerPrice: PropertyModel = new PropertyModel();
      let UpperPrice: PropertyModel = new PropertyModel();
      LowerPrice.selectedPrice = lowerPrice;
      UpperPrice.selectedPrice = upperPrice
      if(data.selectedCity != null)
      data['selectedCity'] = {$regex: new RegExp(selectedCity, "i")}
      if(data.rentOrBuy != null)
      data['rentOrBuy'] = {$regex: new RegExp(rentOrBuy, "i")}
      if(data.selectedStreet != null)
      data['selectedStreet'] = {$regex: new RegExp(selectedStreet, "i")}
      if(data.selectedPrice != null)
      data.selectedPrice =  {$gt: lowerPrice, $lt: upperPrice};
      console.log(data)
    return await this.propertyModel.find(data).exec()
    }

    async fetchData(query: any) {
      const results = await this.propertyModel.find(query);
      return results;
    }

    async fetchAll() {
      const results = await this.propertyModel.find().exec();
      return results;
    }
}
