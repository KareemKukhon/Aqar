import { BodyParams, PathParams, UseBefore } from "@tsed/common";
import { Controller, Inject } from "@tsed/di";
import { Get, Post } from "@tsed/schema";
import { userAuth } from "src/middlewares/UserAuth";
import { CommentModel } from "src/models/comment";
import { CommentService } from "src/services/commentService";

 
 @Controller("/comment")
 @UseBefore(userAuth)
 export class commentController{

    constructor(private service: CommentService){}

    @Post("/postComment")
    postComment(
        @BodyParams() comment: CommentModel
    ){
        return this.service.save(comment)
    }

    @Get("/get/:id")
    getComments(@PathParams("id") id:string){
        return this.service.find(id);
    }
 }