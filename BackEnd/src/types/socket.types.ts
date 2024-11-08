export interface IMessagePayload {
  message: string;
  sourceId: number;
  targetId: number;
}
export interface IMessageReviewPayload {
  lastMessage: string;
  lastMessageTime: string;
  sourceId: number;
  targetId: number;
}