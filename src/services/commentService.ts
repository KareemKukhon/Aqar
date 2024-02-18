import {Inject, Service} from "@tsed/di";
import {MongooseModel} from "@tsed/mongoose";
import { CommentModel } from "src/models/comment";

@Service()
export class CommentService {
  @Inject(CommentModel)
  private comment: MongooseModel<CommentModel>;

  async save(commentObj: CommentModel): Promise<CommentModel> {
    console.log(commentObj);
    const comment = await this.comment.create(commentObj);
    // await comment.save();

    return comment;
  }

  async find(id: string): Promise<CommentModel[]> {
    return this.comment.find({id: id}).exec();
  }
}
