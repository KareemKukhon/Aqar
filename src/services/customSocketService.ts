// import { Inject } from "@tsed/di";
// import { MongooseModel } from "@tsed/mongoose";
// import {IO, Nsp, Socket, SocketService, SocketSession} from "@tsed/socketio";
// import * as SocketIO from "socket.io";
// import { UserModel } from "src/models/UserModel";
// interface Client {
//     sensors:string[]
//     id: string;
//   }
  
// @SocketService("socket")
// export class CustomSocketService {
//     @Nsp nsp: SocketIO.Namespace;
//     private clients: Map<string, SocketIO.Socket> = new Map();
//     private maping: Map<string, string[]> = new Map();
//   @Nsp("/")
//   nspOther: SocketIO.Namespace; 

//   constructor(@IO() private io: SocketIO.Server,@Inject(UserModel)private userModel:MongooseModel<UserModel>) {}
//   setIo(io:SocketIO.Server){
//     this.io=io;
//   }
//   $onNamespaceInit(nsp: SocketIO.Namespace) {}
//   $onConnection(@Socket socket: SocketIO.Socket, @SocketSession session: SocketSession) {
//     console.log("hi");
//     socket.on("setId", (data: Client) => {
//         for(let i of data.sensors){
//           if(!this.maping.has(i)){
//             this.maping.set(i,[]);
//           }
//           let users=this.maping.get(i)!;
//           if(!users.includes(data.id)){
//             users.push(data.id);
//           this.maping.set(i,users);
//           }
//         }
//         this.clients.set(data.id, socket);
//     });
//   }
//   $onDisconnect(@Socket socket: SocketIO.Socket) {
//     this.clients.forEach((sockett, id) =>{
//         if(socket.id==sockett.id){
//             this.clients.delete(id);
//             console.log(`${id} has disconnected`);
//         }
//     });
//   }
// //   sensorAdded(user:string,sensor:string){
// //     if(!this.maping.has(sensor)){
// //       this.maping.set(sensor,[]);
// //     }
// //     let users=this.maping.get(sensor)!;
// //     if(!users.includes(user)){
// //       users.push(user);
// //     this.maping.set(sensor,users);
// //     }
// //   }
// //   sensorChanged(id:string,data:any){
// //     if(this.maping.has(id)){
// //       for(let i of this.maping.get(id)!){
// //         this.sendEventToClient(i,{'UUID':id,'data':data});
// //       }
// //     }
// //   }

//   sendEventToClient(id: string, data: any) { 
//     let client = this.clients.get(id);
//     if (client) {
//       client.emit(id, data);
//       return id;
//     }
//     else return this.clients.size;
//   }
// }
