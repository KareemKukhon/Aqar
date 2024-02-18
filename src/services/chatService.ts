import { Inject, Service } from "@tsed/common";
import { Exception } from "@tsed/exceptions";
import { MongooseModel } from "@tsed/mongoose";
import {IO, Nsp, Socket, SocketService, SocketSession} from "@tsed/socketio";
import { timeStamp } from "console";
import { send } from "process";
import * as SocketIO from "socket.io";
import { UserModel } from "src/models/UserModel";
import { ChatModel, OnlineUser } from "src/models/chat";
interface Client {
    sensors:string[]
    id: string;
  }
  
@SocketService("socket")
@Service()
export class ChatSocketService {
    @Nsp nsp: SocketIO.Namespace;
    private clients: Map<string, SocketIO.Socket> = new Map();
    // private maping: Map<string, string[]> = new Map();
  @Nsp("/")
  nspOther: SocketIO.Namespace; 

  constructor( 
  @IO() private io: SocketIO.Server,
  @Inject(ChatModel) private chatModel:MongooseModel<ChatModel>,
  @Inject(UserModel) private userModel:MongooseModel<UserModel>,
  @Inject(OnlineUser) private onlineUser:MongooseModel<OnlineUser> 
  ) {}
  setIo(io:SocketIO.Server){
    this.io=io;
  }
  $onNamespaceInit(nsp: SocketIO.Namespace) {}
  $onConnection(@Socket socket: SocketIO.Socket, @SocketSession session: SocketSession) {
    console.log("hi");

    socket.on('sendMessage', async (data) => {
      console.log("data: "+ data["sender"]);
      console.log("kareem")
      try{
        // socket.emit('chatMessage', data);
        let recipient = await this.userModel.findOne({
          email: data['sender']['email'],
          "contacts.email": data['recipient']["email"],
        }).exec();

        if(recipient==null){
          
          await this.userModel.updateOne(
            { email: data['sender']['email'] },
            {
              $push: {
                contacts: { email: data['recipient']["email"], name: data['recipient']["firstName"] },
              },
            }
          ).exec();

          await this.userModel.updateOne(
            { email: data['recipient']['email'] },
            {
              $push: {
                contacts: { email: data['sender']["email"], name: data['sender']["firstName"] },
              },
            }
          ).exec();
        }

        let chat = await this.chatModel.create(data);
        console.log("recipient " + data["recipient"]);
        let user = await this.onlineUser.findOne({"user.email": data["recipient"]["email"]}).exec();
        console.log("user: "+user);
        if(user != null){ 
          console.log("send message from server: "+  user.id);
          socket.to(user.id).emit('chatMessage', data);
        }
      }catch (error) { 
        console.error("Error updating reco list:", error);
        throw error;
      } 
      
    });
    var count1=0;  
    var count2=0;

    socket.on('setUserOnline', (user) => {
      const senderData = JSON.parse(user);
      var onlineUser = {
        "id": socket.id,
        "user": JSON.parse(user),
        // "recipient": recipient
      };  
      this.onlineUser.create(onlineUser);
    });

    
    socket.on('userDetails', async (sender, recipient) => {
      const senderData = JSON.parse(sender);
      const recipientData = JSON.parse(recipient);
      var onlineUser = {
        "id": socket.id,
        "user": JSON.parse(sender), 
        // "recipient": recipient
      };  

      let online = this.onlineUser.findOne({email: onlineUser.user.email}).then(async () => {
        console.log(`${onlineUser.user.firstName} is online...`);
        console.log("sender: "+senderData.firstName + " recipient: "+recipientData.firstName)
        let res = await this.chatModel.find({
          "sender.firstName": { "$in": [senderData.firstName, recipientData.firstName]},
        "recipient.firstName": { "$in": [senderData.firstName, recipientData.firstName]}
        }, ).exec();
        // console.log("res = "+res); 
        
        for(var item of res){
          console.log("message: " + item.message + " sender: "+item.sender.email + " recipient: " + senderData.email)
          if(item.sender.email == senderData.email){
            count1++;
            console.log("outgiong = "+ count1);
            socket.emit('outgoing', item);
          }
      else{
        count2++;
        console.log("incoming = "+ count2);
        socket.emit('incoming', item);
      } 
        }
      });
        
       
      
      
      // this.chatModel.find({
      //   sender: [data.sender, data.recipient],
      //   recipient: [data.sender, data.recipient]
      // },{projection: {_id:0}}).then((res)=>{
      //   console.log("res = "+res);
      //     socket.emit('output', res);
      //   }).catch((err) => {
      //     throw err; 
      //   })


    })

    socket.on('sendNotification', async (data) => { 
      // const senderData = JSON.parse(user);
      // var onlineUser = {
      //   "id": socket.id,
      //   "user": JSON.parse(user),
      //   // "recipient": recipient
      // };  
      // this.onlineUser.create(onlineUser);

      try{
        let user = await this.onlineUser.findOne({"user.email": data["email"]}).exec();
        console.log("user: "+(data['Appointment']['end']));
        if(user != null){ 
          console.log("send message from server: "+  data['Appointment']);
          socket.to(user.id).emit('createNotification', data['Appointment']);
        }
      }catch(e)
      {
        console.error(e);
        throw(e);
      }

    });


  }
  $onDisconnect(@Socket socket: SocketIO.Socket) {
    // socket
    console.log("delete = " + socket.id);
    this.onlineUser.deleteOne({id: socket.id}).exec(); 
  }


}
