import { Controller } from "@tsed/di";
import { UseBefore } from "@tsed/platform-middlewares";
import { BodyParams, PathParams } from "@tsed/platform-params";
import { Post, Get } from "@tsed/schema";
import { userAuth } from "src/middlewares/UserAuth";
import { AppointmentModel } from "src/models/appointment";
import { AppointmentService } from "src/services/appointmentService";

@Controller("appointments")
@UseBefore(userAuth)
export class AppointmentController {
  constructor(
    private appointmentService: AppointmentService) {}

  @Post("/create")
  async createAppointment(@BodyParams() appointment: AppointmentModel): Promise<AppointmentModel> {
    return this.appointmentService.createAppointment(appointment);
  }
 
  @Get("/get/:user1/:user2")
  async getAppointment(
    @PathParams("user1") user1: string,
    @PathParams("user2") user2: string,
  ): Promise<AppointmentModel[]> {
    return this.appointmentService.getAppointment(user1, user2);
  }

  @Get("/get/:user1")
  async getAppointments(
    @PathParams("user1") user1: string,
  ): Promise<AppointmentModel[]> {
    return this.appointmentService.getAppointments(user1);
  }
}
