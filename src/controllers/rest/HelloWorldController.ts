import {PathParams} from "@tsed/platform-params";
import {Get} from "@tsed/schema";
import {Controller} from "@tsed/di";
import {MinLength} from "@tsed/schema";
// FIXME remove when esm is ready
interface Calendar {
  id: string;
  name: string;
}
// @Middleware()
// class LocalsMiddleware {
//   use(@Locals() locals: any) {
//     // set some on locals
//     locals.user = "user";
//   }
// }
@Controller("/hello-world")
export class HelloWorldController {

  // @Get("/") 
  @Get("/:id")
  findOne(@PathParams("id") @MinLength(10) id: string) {
    console.log("hi")
    return `This action returns a #${id} calendar`;
  }
}
