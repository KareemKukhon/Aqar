import { Inject, Service } from "@tsed/common";
import { MongooseModel } from "@tsed/mongoose";
import { AppointmentModel } from "src/models/appointment";

@Service()
export class AppointmentService {

    constructor(@Inject(AppointmentModel) private appointmentModel: MongooseModel<AppointmentModel>){}
  async createAppointment(appointment: AppointmentModel): Promise<AppointmentModel> {
    console.log("appointment: "+appointment);
    return await this.appointmentModel.create(appointment);
  }

  async getAppointment(user1: String, user2: String): Promise<AppointmentModel[]> {
    const appointments = await this.appointmentModel
  .find({ 
    $or: [
      { 'user1.email': user1 }, 
      { 'user2.email': user2 }
    ] 
  })
  .exec();
  return appointments;
  }

  async getAppointments(user1: String): Promise<AppointmentModel[]> {
    const appointments = await this.appointmentModel
  .find({ 
    $or: [
      { 'user1.email': user1 }, 
      { 'user2.email': user1 }
    ] 
  })
  .exec();
  return appointments;
  }
}
