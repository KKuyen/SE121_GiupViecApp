import { Repository } from "typeorm";
import { IMessagePayload } from "../types/socket.types";
import { AppDataSource } from "../data-source";
import { Message } from "../entity/Message.entity";

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
}