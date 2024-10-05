import express from 'express';
const router = express.Router();
import { userController } from '../controllers/user.controller';

router.get('/all-user', userController);
export default router;