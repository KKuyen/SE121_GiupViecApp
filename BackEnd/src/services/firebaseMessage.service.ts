import { Complaint } from "./../entity/Complaint.entity";
import { db } from "../config/firebase.config";
import {
  collection,
  addDoc,
  getDocs,
  query,
  where,
  orderBy,
  Timestamp,
} from "firebase/firestore";

export class FirebaseMessageService {
  static async saveMessage(
    sourceId: number,
    targetId: number,
    message: string
  ) {
    try {
      const newMessage = {
        sourceId,
        targetId,
        message,
        createdAt: Timestamp.now(),
      };

      // Lưu tin nhắn vào Firestore (collection 'messages')
      const docRef = await addDoc(collection(db, "messages"), newMessage);
      return { id: docRef.id, ...newMessage };
    } catch (error) {
      console.error("Error saving message:", error);
      throw error;
    }
  }

  static async getChatHistory(sourceId: number, targetId: number) {
    try {
      const messagesQuery = query(
        collection(db, "messages"),
        where("sourceId", "in", [sourceId, targetId]),
        where("targetId", "in", [sourceId, targetId]),
        orderBy("createdAt", "asc")
      );

      const querySnapshot = await getDocs(messagesQuery);
      const messages = querySnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));

      return messages;
    } catch (error) {
      console.error("Error fetching messages:", error);
      throw error;
    }
  }
}
