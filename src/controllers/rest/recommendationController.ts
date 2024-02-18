// src/controllers/UserController.ts

import { Controller, Get, Post, BodyParams, PathParams, Inject, UseBefore } from "@tsed/common";
import { userAuth } from "src/middlewares/UserAuth";
import { CityModel, UserModel } from "src/models/UserModel";
import { PropertyModel } from "src/models/property";
import { PropertyService } from "src/services/PropertyService";
import { RecommendationService } from "src/services/recommendationService";


@Controller("/recommendation")
// @UseBefore(userAuth)
export class recommendationController {
  
  constructor(
    @Inject(RecommendationService)
  @Inject(PropertyService)
    private recommedationService: RecommendationService,private userService: RecommendationService){}
  
  
  @Post("/")
  async createUser(
    @BodyParams("userId") userId: string,
    @BodyParams("visitedCities") visitedCities: { name: string; visitCount: number }[]
  ): Promise<UserModel> {
    return this.userService.createUser(userId, visitedCities);
  }

  @Get("/")
  async getAllUsers(): Promise<UserModel[]> {
    return this.userService.getAllUsers();
  }

  @Get("/:userId")
  async getUserById(@PathParams("userId") userId: string): Promise<UserModel | null> {
    return this.userService.getUserById(userId);
  }

  @Post("/:email/visit")
  async updateVisitCount(
    @PathParams("email") userId: string,
    @BodyParams("cityName") cityName: string
  ): Promise<UserModel> {
    return this.userService.updateVisitCount(userId, cityName);
  }

  

  // Define an endpoint to get recommended properties based on locations and limits
  @Post('/getRecommendedProperties/:email')
  async getRecommendedProperties(@PathParams("email") email: string): Promise<PropertyModel[]> {
    try {
      // Define locations and their limits (you can fetch these from request, database, etc.)

      // const locationsMap = new Map<string, number>();
      // for(var loc of email){
      //   locationsMap.set(loc.name, loc.visitCount);
      // }
      // Add more locations as needed
      // Call the service to get recommended properties

      const recommendedProperties = await this.recommedationService.getRecommendedProperties(email);

      return recommendedProperties;
    } catch (error) {
      console.error('Error fetching recommended properties:', error);
      throw error;
    }
  }
}
