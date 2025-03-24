import express, { Request, Response } from "express";
import { supabase } from "./supabase";
const app = express();
app.use(express.json());

import { AppDataSource } from "./data-source";
import bodyParser from "body-parser";
import userRouter from "./routes/user.routes";
import admin1Router from "./routes/admin1.routes";
import taskerRouter from "./routes/tasker.routes";
import adminRouter from "./routes/admin2.routes";
import http from "http";
import { MessageService } from "./services/message.service";

import session from "express-session";

import admin, { database } from "firebase-admin";
import { getStorage, ref, uploadBytesResumable } from "firebase/storage";
import { signInWithEmailAndPassword } from "firebase/auth";
import { auth } from "../src/config/firebase.config"; // Ensure you have your Firebase config here
import upload from "../src/middleware/multer";
import dotenv from "dotenv";
dotenv.config();
import cors from "cors";
import axios from "axios";
import { IMessagePayload } from "./types/socket.types";
import { Tasks } from "./entity/Task.entity";

app.use(cors());
//Socket.IO*******************************
const server = http.createServer(app);
const io = require("socket.io")(server);
const clients: { [key: string]: any } = {};
io.on("connection", (socket: any) => {
  console.log("connected");
  console.log(socket.id, "has joined");
  socket.on("login", (id: number) => {
    console.log(id);
    clients[id] = socket;
  });
  socket.on("message", async (e: IMessagePayload) => {
    try {
      let targetId = e.targetId;
      const savedMessage = await MessageService.saveMessage(e);
      let lastMessageTime = "";
      const createdAt = new Date(savedMessage.createdAt);
      const now = new Date();
      if (
        createdAt.getDate() === now.getDate() &&
        createdAt.getMonth() === now.getMonth() &&
        createdAt.getFullYear() === now.getFullYear()
      ) {
        lastMessageTime = createdAt.toLocaleTimeString("en-GB", {
          hour: "2-digit",
          minute: "2-digit",
        });
      } else {
        lastMessageTime = createdAt.toLocaleDateString("en-GB", {
          day: "2-digit",
          month: "2-digit",
        });
      }
      await MessageService.saveMessageReview({
        lastMessage: e.message,
        lastMessageTime: lastMessageTime,
        sourceId: e.sourceId,
        targetId: e.targetId,
      });
      console.log(e.message);
      console.log(e.targetId);
      console.log(e);
      if (clients[targetId]) {
        console.log("sending message to: " + targetId);
        clients[targetId].emit("message", {
          ...e,
          timestamp: savedMessage.createdAt,
        });
        console.log(e);
      }
    } catch (error) {
      console.error("Error handling message:", error);
    }
  });
  socket.on("disconnect", () => {
    // Remove client from connected clients
    const userId = Object.keys(clients).find(
      (key) => clients[key].id === socket.id
    );
    if (userId) {
      delete clients[userId];
    }
  });
});

//Socket.IO*******************************

const serviceAccount = require(process.env.Credential as string);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET, // Ensure this is set
});
interface MulterFile {
  originalname: string;
  mimetype: string;
  buffer: Buffer;
}

async function uploadImage(
  file: MulterFile | MulterFile[],
  quantity: string
): Promise<string | string[]> {
  const storageFB = getStorage();
  const firebaseUser = process.env.FIREBASE_USER;
  const firebaseAuth = process.env.FIREBASE_AUTH;

  if (!firebaseUser || !firebaseAuth) {
    throw new Error(
      "FIREBASE_USER and FIREBASE_AUTH must be set in the environment variables"
    );
  }

  await signInWithEmailAndPassword(auth, firebaseUser, firebaseAuth);

  if (quantity === "single" && !Array.isArray(file)) {
    const dateTime = Date.now();
    const fileName = `images/${dateTime}-${file.originalname}`;
    const storageRef = ref(storageFB, fileName);
    const metadata = {
      contentType: file.mimetype,
    };
    await uploadBytesResumable(storageRef, file.buffer, metadata);
    return fileName;
  } else if (quantity === "multiple" && Array.isArray(file)) {
    const fileNames: string[] = [];
    for (let i = 0; i < file.length; i++) {
      const dateTime = Date.now();
      const fileName = `images/${dateTime}-${file[i].originalname}`;
      const storageRef = ref(storageFB, fileName);
      const metadata = {
        contentType: file[i].mimetype,
      };
      await uploadBytesResumable(storageRef, file[i].buffer, metadata);
      fileNames.push(fileName);
    }
    return fileNames;
  } else {
    throw new Error("Invalid quantity or file type");
  }
}
app.get("/api/v1/messages", async (req, res) => {
  try {
    let sourceId: string = req.query.sourceId as string;
    let targetId: string = req.query.targetId as string;
    if (!targetId) {
      res.status(400).json({ error: "targetId is required" });
      return;
    }
    const messages = await MessageService.getChatHistory(
      parseInt(sourceId),
      parseInt(targetId)
    );
    res.json(messages);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch messages" });
  }
});
app.get("/api/v1/messages-review", async (req, res) => {
  try {
    let sourceId: string = req.query.sourceId as string;
    if (!sourceId) {
      res.status(400).json({ error: "sourceId is required" });
      return;
    }
    const messages = await MessageService.getChatReview(parseInt(sourceId));
    res.json(messages);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch messages" });
  }
});
app.post(
  "/upload-and-get-link",
  upload.single("image"),
  async (req: Request, res: Response) => {
    try {
      // Upload image
      const imageUrl = await uploadImage(req.file as MulterFile, "single");
      const imageUrlWithPath = (imageUrl as string).split("/").pop();
      const fileName = `images/${imageUrlWithPath}`;

      // Generate download link
      const bucket = admin.storage().bucket();
      const file = bucket.file(fileName);

      const [url] = await file.getSignedUrl({
        action: "read",
        expires: Date.now() + 1000 * 60 * 60 * 24 * 7, // 1 week
      });

      // Return download link
      res.status(200).send({ url });
    } catch (error) {
      res.status(500).send({ error: (error as Error).message });
    }
  }
);

app.post(
  "/upload-multi-and-get-links",
  upload.array("images", 12),
  async (req: Request, res: Response) => {
    try {
      // Upload images
      const imageUrls = await uploadImage(
        req.files as MulterFile[],
        "multiple"
      );

      // Generate download links
      const bucket = admin.storage().bucket();

      const downloadLinks = await Promise.all(
        (imageUrls as string[]).map(async (fileName) => {
          const file = bucket.file(fileName);
          const [url] = await file.getSignedUrl({
            action: "read",
            expires: Date.now() + 1000 * 60 * 60 * 24 * 7, // 1 week
          });
          return url;
        })
      );

      // Return download links
      res.status(200).send({ downloadLinks });
    } catch (error) {
      res.status(500).send({ error: (error as Error).message });
    }
  }
);

app.post(
  "/api/v1/supabase/messages",
  async (req: Request, res: Response): Promise<any> => {
    try {
      const { sourceId, targetId, message, sender, comolaintId } = req.body;
      if (!sourceId || !targetId || !message || !sender || !comolaintId) {
        return res.status(400).json({ error: "Missing required fields" });
      }

      const { data, error } = await supabase.from("complaintMessages").insert([
        {
          sourceId: sourceId,
          targetId: targetId,
          message,
          sender: sender,
          comolaintId: comolaintId,
        },
      ]);

      if (error) throw error;
      res.json({ success: true, message: data });
    } catch (error) {
      res.status(500).json({ error: "Failed to send message" });
      console.error("Error sending message:", error);
    }
  }
);
app.post("/callback", async (req: Request, res: Response) => {
  console.log("callback");
  console.log(req.body);
  if (req.body.resultCode === 0) {
    const orderId = req.body.orderId;
    try {
      await AppDataSource.getRepository(Tasks).update(orderId, { isPaid: true });
      console.log(`Order ${orderId} marked as paid.`);
    } catch (error) {
      console.error(`Failed to update order ${orderId}:`, error);
    }
  }
  res.status(200).json(req.body);
 });
app.post("/payment", async (req: Request, res: Response): Promise<void> => {
  let {money, taskId} = req.body;
  if (!money || !taskId) {
    res.status(400).json({ error: "Missing required fields" });
    return;
  }
  //https://developers.momo.vn/#/docs/en/aiov2/?id=payment-method
  //parameters
  var accessKey = 'F8BBA842ECF85';
  var secretKey = 'K951B6PE1waDMi640xX08PD3vg6EkVlz';
  var orderInfo = 'pay with MoMo';
  var partnerCode = 'MOMO';
  var redirectUrl = 'myapp://callback';
  var ipnUrl = 'https://27f2-14-186-80-243.ngrok-free.app/callback';
  var requestType = "payWithMethod";
  var amount = money;
  var orderId =taskId;
  var requestId = orderId;
  var extraData ='';
  var paymentCode = 'T8Qii53fAXyUftPV3m9ysyRhEanUs9KlOPfHgpMR0ON50U10Bh+vZdpJU7VY4z+Z2y77fJHkoDc69scwwzLuW5MzeUKTwPo3ZMaB29imm6YulqnWfTkgzqRaion+EuD7FN9wZ4aXE1+mRt0gHsU193y+yxtRgpmY7SDMU9hCKoQtYyHsfFR5FUAOAKMdw2fzQqpToei3rnaYvZuYaxolprm9+/+WIETnPUDlxCYOiw7vPeaaYQQH0BF0TxyU3zu36ODx980rJvPAgtJzH1gUrlxcSS1HQeQ9ZaVM1eOK/jl8KJm6ijOwErHGbgf/hVymUQG65rHU2MWz9U8QUjvDWA==';
  var orderGroupId ='';
  var autoCapture =true;
  var lang = 'vi';

  //before sign HMAC SHA256 with format
  //accessKey=$accessKey&amount=$amount&extraData=$extraData&ipnUrl=$ipnUrl&orderId=$orderId&orderInfo=$orderInfo&partnerCode=$partnerCode&redirectUrl=$redirectUrl&requestId=$requestId&requestType=$requestType
  var rawSignature = "accessKey=" + accessKey + "&amount=" + amount + "&extraData=" + extraData + "&ipnUrl=" + ipnUrl + "&orderId=" + orderId + "&orderInfo=" + orderInfo + "&partnerCode=" + partnerCode + "&redirectUrl=" + redirectUrl + "&requestId=" + requestId + "&requestType=" + requestType;
  //puts raw signature
  console.log("--------------------RAW SIGNATURE----------------")
  console.log(rawSignature)
  //signature
  const crypto = require('crypto');
  var signature = crypto.createHmac('sha256', secretKey)
      .update(rawSignature)
      .digest('hex');
  console.log("--------------------SIGNATURE----------------")
  console.log(signature)

  //json object send to MoMo endpoint
  const requestBody = JSON.stringify({
      partnerCode : partnerCode,
      partnerName : "Test",
      storeId : "MomoTestStore",
      requestId : requestId,
      amount : amount,
      orderId : orderId,
      orderInfo : orderInfo,
      redirectUrl : redirectUrl,
      ipnUrl : ipnUrl,
      lang : lang,
      requestType: requestType,
      autoCapture: autoCapture,
      extraData : extraData,
      orderGroupId: orderGroupId,
      signature : signature
  });
  const options = {
    method: 'POST',
    url: "https://test-payment.momo.vn/v2/gateway/api/create",
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(requestBody)
    },
    data: requestBody
  }
  let result;
  try {
    result = await axios(options);
    res.status(200).json(result.data);
  } catch (error) {
     res.status(500).json(error);
    
  }
  
 });
// Lấy lịch sử tin nhắn

const port = process.env.PORT || 3000;
app.use(bodyParser.json());
app.use("/", userRouter);
app.use("/", taskerRouter);
app.use("/", admin1Router);
app.use("/", adminRouter);

app.use(
  session({
    secret: "your_secret_key",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }, // Để `secure: true` khi chạy HTTPS
  })
);
app.get("*", (req: Request, res: Response) => {
  res.status(505).json({ message: "Bad Request" });
});

AppDataSource.initialize()
  .then(async () => {
    server.listen(port, () => {
      console.log(`Server is running on port ${port}`);
    });
  })
  .catch((error) => console.log(error));
