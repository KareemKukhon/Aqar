// src/services/UserService.ts

import { Service, Inject } from "@tsed/common";
import { MongooseModel } from "@tsed/mongoose";
import { UserModel, CityModel } from "../models/UserModel";
import { PropertyModel } from "src/models/property";
import { number } from "@tsed/schema";

@Service()
export class RecommendationService {
//   @Inject(UserModel)
  
  // private reco: PropertyModel[] = [];
  locations: Map<String, number> = new Map<string, number>();

  @Inject(PropertyModel)
  private PropertyModel: MongooseModel<PropertyModel>;
//   private userModel: MongooseModel<UserModel>;
  // private cityModel: MongooseModel<CityModel>;
  constructor(@Inject(UserModel) private userModel: MongooseModel<UserModel>){}

  async createUser(userId: string, visitedCities: { name: string; visitCount: number }[]): Promise<UserModel> {
    const user = new this.userModel({ userId, visitedCities });
    return user.save();
  }

  async getAllUsers(): Promise<UserModel[]> {
    let user =  this.userModel.find().exec();
    return user
  }

  async getUserById(userId: string): Promise<UserModel | null> {
    return this.userModel.findOne({ userId }).exec();
  }

  async updateVisitCount(email: string, cityName: string): Promise<UserModel> {
    const user = await this.userModel.findOne({ "email": email }).exec();
    
    if (!user) {
      throw new Error("User not found");
    }

    const cityIndex = user.visitedCities.findIndex((city) => city.name === cityName);

    if (cityIndex !== -1) {       
      user.visitedCities[cityIndex].visitCount ++;
      user.markModified('visitedCities');
      console.log("here hrer " + user.visitedCities[cityIndex].visitCount)
    } else {    
          
      user.visitedCities.push({ _id: user._id, name: cityName, visitCount: 1 });
    }
    try {
        user.save();
        console.log("User saved successfully");
      } catch (error) {
        console.error("Error saving user:", error);
      }
    return user;
  }

  async getRecommendedProperties(email: string): Promise<PropertyModel[]> {
    this.locations = new Map<string, number>();
    try {
      // Find properties where location is "Nablus"
      console.log(email)
      let user = await this.userModel.findOne({email: email}).exec();
      // console.log(user)
      user?.visitedCities.forEach(city => {
        console.log("name: "+city.name)
        this.locations.set(city.name, city.visitCount);
      });
      const reco: PropertyModel[] = [];
      var num = 0;
      // console.log(this.locations)
      for (const [location, limit] of this.locations) {
        console.log("location: "+location);
        num += limit;
      }
      console.log("number = " + num);
      for (const [location, limit] of this.locations) {
        // Find properties for the current location
        var perc = (limit/num)*10;
        console.log(location + perc.toString());
        const propertiesForLocation = await this.PropertyModel.find({'selectedCity': location }).sort({ _id: -1 }).limit(perc);
        // console.log(propertiesForLocation)
        // Add properties to reco list respecting the limit

        reco.push(...propertiesForLocation.slice(0, limit));
        // console.log("reco = "+reco);
      }
      // const propertiesInNablus = await this.PropertyModel.find({ location: "Nablus" });

      // Update reco list with properties in Nablus
      // reco = propertiesInNablus;
      if(reco.length < 10){
        try{

          // for (const [location, limit] of locations) {
            // Find properties for the current location
            var perc = 10 - reco.length;
            const keysList: String[] = [...this.locations.keys()];
            console.log([...this.locations.keys()])
            const propertiesForLocation1 = await this.PropertyModel.find({ _id: { $nin: reco } }).sort({ _id: -1 }).limit(perc);
            // console.log(propertiesForLocation)
            // Add properties to reco list respecting the limit
    
            reco.push(...propertiesForLocation1);
            // console.log("reco = "+reco);
          // }
        // const propertiesNotInNablus = await this.PropertyModel.find({ 'selectedCity': { $ne: "Nablus" } });

        // Add properties to reco list until its length is 20
        // const remainingSlots = 20 - reco.length;
        // reco.push(...propertiesNotInNablus.slice(0, remainingSlots));
      } catch (error) {
        console.error("Error updating reco list:", error);
        throw error;
      }
      }

      return reco;
    } catch (error) {
      console.error("Error fetching properties in Nablus:", error);
      throw error;
    }
  }
  
}
