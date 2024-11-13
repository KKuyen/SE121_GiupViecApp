import { Repository } from "typeorm";
import { IMessagePayload, IMessageReviewPayload } from "../types/socket.types";
import { AppDataSource } from "../data-source";
import { Message } from "../entity/Message.entity";
import { MessageReview } from "../entity/MessageReview.entity";

export class MessageService {
   

  static  saveMessage=async(payload: IMessagePayload): Promise<Message> =>{
    let messageRepository = AppDataSource.getRepository(Message);
    const message = messageRepository.create({
      content: payload.message,
      sourceId: payload.sourceId,
      targetId: payload.targetId,
    });
    return await messageRepository.save(message);
  }
  static saveMessageReview = async (payload:IMessageReviewPayload) => {
    let messageRepository = AppDataSource.getRepository(MessageReview);
    let existingReview = await messageRepository.findOne({
      where: { sourceId: payload.sourceId, targetId: payload.targetId }
    });

    if (!existingReview) {
      existingReview = messageRepository.create({
        lastMessage: payload.lastMessage,
        lastMessageTime: payload.lastMessageTime,
        sourceId: payload.sourceId,
        targetId: payload.targetId,
      });

    }else{
      existingReview.lastMessage = payload.lastMessage;
      existingReview.lastMessageTime=payload.lastMessageTime;
    }
    
    await messageRepository.save(existingReview);
    let existingReview2 = await messageRepository.findOne({
      where: { sourceId: payload.targetId, targetId: payload.sourceId }
    });

    if (!existingReview2) {
      existingReview2 = messageRepository.create({
        lastMessage: payload.lastMessage,
        lastMessageTime: payload.lastMessageTime,
        sourceId: payload.targetId,
        targetId: payload.sourceId,
      });

    }else{
      existingReview2.lastMessage = payload.lastMessage;
      existingReview2.lastMessageTime=payload.lastMessageTime;
    }
    
     await messageRepository.save(existingReview2);

   }

  static  getChatHistory=async(sourceId: number, targetId: number)=> {
        let messageRepository = AppDataSource.getRepository(Message);
        let messages: Message[] = await messageRepository.find({
      where: [
        { sourceId, targetId },
        { sourceId: targetId, targetId: sourceId }
      ],
      order: {
        createdAt: "ASC"
      }
      });
    return {"messages": messages};
  }
  static getChatReview = async (sourceId: number) => {
        let messageRepository = AppDataSource.getRepository(MessageReview);
      try {
        let messages = await messageRepository
            .createQueryBuilder("message_review")
            .leftJoinAndSelect("message_review.target", "target")
            .orderBy("message_review.updatedAt", "DESC")
          .select([
              "message_review.id",
              "message_review.lastMessage",
              "message_review.lastMessageTime",
              "message_review.sourceId",
              "message_review.targetId",
              "target.id",
              "target.name",
            "target.avatar",
            "target.phoneNumber",
              
            ])
            .where(`message_review.sourceId = :sourceId `, { sourceId }) 
          .getMany();
        if (!messages) {
          return {"messages": []};
        }
        return {"messages": messages};
      } catch (error) {
        console.error("Error fetching chat review:", error);
        return {"messages": []};
        
      }
  }
}