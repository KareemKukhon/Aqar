import { BodyParams, Controller, Delete, Get, MulterOptions, MultipartFile, PathParams, PlatformMulter, PlatformMulterFile, Post, UseBefore } from "@tsed/common";
import e from "express";
import { userAuth } from "src/middlewares/UserAuth";
import { PropertyModel } from "src/models/property";
import { SoldPropertyModel } from "src/models/soldProperty";
import { PropertyService } from "src/services/PropertyService";

@Controller("/properties")
// @UseBefore(userAuth)
export class PropertyController {
  constructor(private propertyService: PropertyService) {}

  @Get("/")
  fetchAllProperties(){
    try{
      return this.propertyService.fetchAllData();
    }catch(e)
    {
      throw(e);
    }
  }

  @Get("/soldProperties")
  fetchSoldProperties(){
    try{
      return this.propertyService.fetchSoldProperty();
    }catch(e)
    {
      throw(e);
    }
  }

  @Post("/save")
  @MulterOptions({dest: "./public/uploads/propertyImages"}) 
  async saveProperty(
    @MultipartFile("file") file: PlatformMulterFile,
    @MultipartFile("files") files: PlatformMulterFile[],
    @BodyParams() propertyData: PropertyModel
    ): Promise<PropertyModel> {
        console.log("file = " + file.filename)
        propertyData.image = "/public/uploads/propertyImages/" + file.filename ;
        if (files) {
            propertyData.imageFileList = files.map((f) => "/public/uploads/propertyImages/" + f.filename );
          }
          
          
    console.log(propertyData)
    return this.propertyService.saveProperty(propertyData);
  }

  @Post("/fetchAll")
  async fetchAllData(){
    return this.propertyService.fetchAllData();
  }

  @Post("/fetchUserProperty/:email")
  async fetchUserProperty(
    @PathParams("email") email: string
  ){
    return this.propertyService.fetchUserProperty(email);
  }

  @Post("/update/:email")
  @MulterOptions({dest: "./public/uploads/propertyImages"}) 
  updateData(
    @BodyParams() newData: PropertyModel,
    @MultipartFile("file") file: PlatformMulterFile,
    @MultipartFile("files") files: PlatformMulterFile[],
    @PathParams("email") email: string
  ){
    if(file != undefined || file !=null ){
      newData.image = "/public/uploads/propertyImages/" + file.filename ;
      }
      if(files){
        newData.imageFileList = files.map((f) => "/public/uploads/propertyImages/" + f.filename );
      }
    console.log("id = "+email)
    return this.propertyService.updateProperty(email, newData)
  }
 
  @Delete("/delete/:id")
  deleteProperty(
    @PathParams("id") id: string
  ){
    console.log("id = "+id)
    return this.propertyService.deleteProperty(id);
  }

  @Post("/addDelProperty")
  saveDeletedProperty(
    @BodyParams() newData: SoldPropertyModel,
  ){
    return this.propertyService.saveDeletedProperty(newData)
  }

  @Get("/getCount")
  calculatePropertyDeletedCountsByCity(){
    return this.propertyService.calculatePropertyCountsByCity();
  }
}
