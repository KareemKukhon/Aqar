import { Controller } from "@tsed/di";
import { UseBefore } from "@tsed/platform-middlewares";
import { BodyParams, PathParams } from "@tsed/platform-params";
import { Post, Description, Returns, Delete, Get } from "@tsed/schema";
import { userAuth } from "src/middlewares/UserAuth";
import { PropertyModel } from "src/models/property";
import { SavedProperty } from "src/models/savedProperty";
import { SavedPropertyService } from "src/services/savePropertyService";


@Controller("/saveProperty")
@UseBefore(userAuth)
export class SavePropertyController{

    constructor(private savedPropertyService: SavedPropertyService) {}

  @Post("/create")
  @Description("Add a property to the user's saved list")
  @Returns(200, SavedProperty)
   addSavedProperty(
    @BodyParams() property: SavedProperty
  ): Promise<SavedProperty> {
    return this.savedPropertyService.addSavedProperty( property);
  }

  @Get("/get/:email")
  getSavedProperty(@PathParams("email") email: string): Promise<PropertyModel[]>{
    return this.savedPropertyService.getSavedProperty(email)
  }

  @Delete("/delete/:id")
  @Description("Remove a property from the user's saved list")
  @Returns(204)
   deleteSavedProperty(@PathParams("id") savedPropertyId: string, @BodyParams() property: PropertyModel): Promise<void> {
    return this.savedPropertyService.deleteSavedProperty(savedPropertyId, property);
  }

} 