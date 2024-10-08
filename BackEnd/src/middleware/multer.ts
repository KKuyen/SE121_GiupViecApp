import multer, { StorageEngine, FileFilterCallback } from "multer";
import path from "path";
import { Request } from "express";

const storage: StorageEngine = multer.memoryStorage();

const upload = multer({
  storage: storage,
  fileFilter: function (
    req: Request,
    file: Express.Multer.File,
    cb: FileFilterCallback
  ) {
    checkFileType(file, cb);
  },
});

function checkFileType(file: Express.Multer.File, cb: FileFilterCallback) {
  const filetypes = /jpeg|jpg|png|gif|mp4|avi|mkv/;
  const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = filetypes.test(file.mimetype);
  if (mimetype && extname) {
    return cb(null, true);
  } else {
    cb(new Error("Error: Images Only!"));
  }
}

export default upload;
