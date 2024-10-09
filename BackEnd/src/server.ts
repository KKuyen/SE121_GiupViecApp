import express, { Request, Response } from "express";
import { AppDataSource } from "./data-source";
import bodyParser from "body-parser";
import userRouter from "./routes/user.routes";
import taskerRouter from "./routes/tasker.routes";

import session from "express-session";

import admin from "firebase-admin";
import { getStorage, ref, uploadBytesResumable } from "firebase/storage";
import { signInWithEmailAndPassword } from "firebase/auth";
import { auth } from "../src/config/firebase.config"; // Ensure you have your Firebase config here
import upload from "../src/middleware/multer";
import dotenv from "dotenv";

dotenv.config();

const app = express();
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

const port = process.env.PORT || 3000;
app.use(bodyParser.json());
app.use("/", userRouter);
app.use("/", taskerRouter);
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
    app.listen(port, () => {
      console.log(`Server is running on port ${port}`);
    });
  })
  .catch((error) => console.log(error));
