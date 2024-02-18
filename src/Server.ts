import {join} from "path";
import {Configuration, Inject} from "@tsed/di";
import {PlatformApplication} from "@tsed/common";
import "@tsed/platform-express"; // /!\ keep this import
import "@tsed/ajv";
import "@tsed/mongoose";
import {config} from "./config/index";
import * as rest from "./controllers/rest/index";
import { ChatSocketService } from "./services/chatService";

@Configuration({
  ...config,
  acceptMimes: ["application/json"],
  httpPort: process.env.PORT || 8083,
  httpsPort: false, // CHANGE
  disableComponentsScan: true,
  mongoose: [
    {
      id: "default",
      url: "mongodb://127.0.0.1:27017/Aqar",
      connectionOptions: {}
    }
  ],
  mount: {
    "/rest/": [
      ...Object.values(rest)
    ],
    "/socket":[ChatSocketService]
  },

  socketIO: {
    path: "/socket.io",
    serveClient: true,
    cors: {
      origin: "*",
      methods: ["GET", "POST"],
      credentials: true
    },
  },

  middlewares: [
    "cors",
    "cookie-parser",
    "compression",
    "method-override",
    "json-parser",
    { use: "urlencoded-parser", options: { extended: true }}
  ],
  views: {
    root: join(process.cwd(), "../views"),
    extensions: {
      ejs: "ejs"
    }
  },
  exclude: [
    "**/*.spec.ts"
  ],
  statics: {
    "/public": join(process.cwd(), "./public")
  },
  multer: {
    dest: join(process.cwd(), "./public/uploads"),
  },
})
export class Server {
  @Inject()
  protected app: PlatformApplication;
  
  @Configuration()
  protected settings: Configuration;
}
