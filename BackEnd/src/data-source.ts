import "reflect-metadata"
import { DataSource } from "typeorm"
import { User } from "./entity/User.entity";
import { Movie } from "./entity/Movie.entity";
import { User1698321500514  } from "./migration/user.migration"
import { Movie1698321512351  } from "./migration/movie.migration"
export const AppDataSource = new DataSource({
    type: "postgres",
    host: "aws-0-ap-south-1.pooler.supabase.com",
    port: 6543,
    username: "postgres.wbekftdbbgbvuybtvjoi",
    password: "NguyenDuyHung@123456",
    database: "postgres",
    synchronize: false,
    logging: false,
    entities: [User, Movie],
    migrations: [User1698321500514 , Movie1698321512351 ],
    subscribers: [],
})
