import "reflect-metadata"
require("dotenv").config()
import { DataSource } from "typeorm"
import { User } from "./entity/User.entity";
import { TaskerInfo } from "./entity/TaskerInfo.entity";
import { AddPriceDetails } from "./entity/AddPriceDetails.entity"
import { AddPrices } from "./entity/AddPrices.entity"
import {BlockTaskers} from "./entity/BlockTasket.entity"
import { LoveTaskers } from "./entity/LoveTasker.entity"
import { MyVouchers } from "./entity/MyVoucher.entity"
import { Notifications } from "./entity/Notification.entity"
import { Reviews } from "./entity/Review.entity"
import {TaskerList} from "./entity/TaskerList.entity"
import { TaskTypes } from "./entity/TaskTypes.entity"
import { Location } from "./entity/Location.entity"
import { ReTasks } from "./entity/Retasks.entity"
import{UserSettings} from "./entity/UserSetting.entity"
import { Tasks } from "./entity/Task.entity"
import {Vouchers} from "./entity/Voucher.entity"

import { UsersMigration1698321500515 } from "./migration/user.migration"
import { TaskerInfoMigration1698321400516 } from "./migration/taskerInfo.migration"
import { AddPriceDetailsMigration1698324600523 } from "./migration/addPriceDetail.migration"
import { AddPricesMigration1698324600525 } from "./migration/addPrice.migration"
import { BlockTaskersMigration1698322600520 } from "./migration/blockTasker.migration"
import { LoveTaskersMigration1698322600519 } from "./migration/loveTasker.migration"
import { MyVouchersMigration1698324600531 } from "./migration/myVoucher.migration"
import { NotificationsMigration1698324600529 } from "./migration/nofitication.migration"
import { ReviewsMigration1698324600528 } from "./migration/review.migration"
import { TaskerListMigration1698324600527 } from "./migration/taskList.migration"
import { TaskTypesMigration1698324600522 } from "./migration/taskType.migration"
import { LocationsMigration1698321600518 } from "./migration/location.migration"
import { ReTasksMigration1698324600526 } from "./migration/reTask.migration"
import { UserSettingsMigration1698323600521 } from "./migration/userSetting.migration"
import { TasksMigration1698324600524 } from "./migration/taskt.migration"
import { VouchersMigration1698324600530 } from "./migration/voucher.migration"
import { Message } from "./entity/Message.entity";
import { CreateMessageTable1634567890123 } from "./migration/message.migration";
import { MessageReview } from "./entity/MessageReview.entity";
import { CreateMessageReviewTable1634567890123 } from "./migration/messageReview.migration";


export const AppDataSource = new DataSource({
    type: "postgres",
    host: process.env.DB_HOST,
    port: parseInt(process.env.DB_PORT!),
    username:  process.env.DB_USERNAME,
    password:   process.env.DB_PASSWORD,
    database:   process.env.DB_NAME,
    synchronize: false,
    logging: false,
    entities: [User,Message,MessageReview,TaskerInfo, AddPriceDetails, AddPrices, BlockTaskers, LoveTaskers, MyVouchers, Notifications, Reviews, TaskerList, TaskTypes, Location, ReTasks, UserSettings, Tasks, Vouchers],
    migrations: [UsersMigration1698321500515,CreateMessageReviewTable1634567890123,TaskerInfoMigration1698321400516, AddPriceDetailsMigration1698324600523, AddPricesMigration1698324600525, BlockTaskersMigration1698322600520, LoveTaskersMigration1698322600519, MyVouchersMigration1698324600531, NotificationsMigration1698324600529, ReviewsMigration1698324600528, TaskerListMigration1698324600527, TaskTypesMigration1698324600522, LocationsMigration1698321600518, ReTasksMigration1698324600526, UserSettingsMigration1698323600521, TasksMigration1698324600524, VouchersMigration1698324600530],
    subscribers: [],
})
