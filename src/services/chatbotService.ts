import { Inject, Service } from "@tsed/di";
import { MongooseModel } from "@tsed/mongoose";
import Axios, { AxiosResponse } from "axios";
import { PropertyModel } from "src/models/property";

@Service()
export class ChatbotService{

    constructor(@Inject(PropertyModel) private propertyModel: MongooseModel<PropertyModel>){}

    async sendMessage(message: any){
        
        try{
            // const userMessage = JSON.parse(message);
           let response: AxiosResponse = await Axios.post('http://localhost:5000/chat', message);
           console.log(response.data.response);
           let reply = response.data;

           const mongoQuery: any = {};

    // Check if the 'location' property exists in the query
    if (reply.selectedCity == null ) {
        console.log(1);
      delete reply.selectedCity;
    }

    // Check if the 'property_size' property exists in the query
    if (reply.selectedArea == null && reply.selectedArea == undefined) {
        console.log(2);
      delete reply.selectedArea;
    }
    else{
        const numericPart = reply.selectedArea.match(/\d+/);
        reply.selectedArea = {$gt: parseInt(numericPart)-51, $lt: parseInt(numericPart)+51}
        console.log("Area: "+reply.selectedArea);
    }

    // Check if the 'property_type' property exists in the query
    if (reply.propType == null || reply.propType == "Property" || reply.propType == "property") {
        console.log(3);
      delete reply.propType;
    }
    else{
        reply.propType = reply.propType == "House" || reply.propType == "house"? "0": reply.propType == "Apartment" || reply.propType == "apartment"? "1": reply.propType == "Land" || reply.propType == "land"?"2":"3";
    }

    // Check if the 'response' property exists in the message
    // if (message.response) {
    //   mongoQuery.response = message.response;
    // }

           let property = await this.propertyModel.find(reply).exec();
           let msg = {
            "reply": reply.response,
            "location": reply.selectedCity,
            "properties": property
           };
        return msg; 
        }catch(e){
            throw(e);
        }
        
    }
}


