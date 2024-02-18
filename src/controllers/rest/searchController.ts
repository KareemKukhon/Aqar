import { Controller } from '@tsed/di';
import { UseBefore } from '@tsed/platform-middlewares';
import { BodyParams, QueryParams } from '@tsed/platform-params';
import { Post, Get } from '@tsed/schema';
import { userAuth } from 'src/middlewares/UserAuth';
import { PropertyModel } from 'src/models/property';
import { SearchService } from 'src/services/searchService';

@Controller('/search')
@UseBefore(userAuth)
export class SearchController {
    
  constructor(private searchService: SearchService){}
  @Get('/')
  async search(@QueryParams() params: any): Promise<any> {
    // Construct the query object dynamically
    let query:any = {};
    for (const key in params) {
      if (params[key]) {
        query[key] = params[key];
      }
    }

    // Execute the search query
    const results = this.searchService.fetchData(query);
    return results;
  } 

  @Post("/findProperty")
  
  async searchProp(
    @BodyParams() property: any
  ){    
    const {propType, lowerPrice, upperPrice} = property

    if(propType == "10"){
      delete property.propType;
    }
    delete property.lowerPrice;
    delete property.upperPrice;
    if(property.selectedArea == null){
      delete property.selectedArea
    }
    if(property.selectedBath == null){
      delete property.selectedBath
    }
    if(property.selectedBed == null){
      delete property.selectedBed
    }
    if(property.selectedCity == null){
      console.log("city: "+property.selectedCity);
      delete property.selectedCity
    }
    if(property.selectedGarage == null){
      delete property.selectedGarage
    }
    if(property.selectedStreet == null){
      delete property.selectedStreet
    }
    console.log(property);
    return await this.searchService.searchProperty(property, lowerPrice, upperPrice);
  }
}
