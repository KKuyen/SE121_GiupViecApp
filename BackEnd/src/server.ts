import express from 'express';
import user_router from './routes/user.route';

require('dotenv').config();
const app = express();
const port = process.env.PORT || 3000;
app.use("/api/user",user_router);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

