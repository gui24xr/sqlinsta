
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS "users"(
	"userId" UUID DEFAULT uuid_generate_v4(),
	"userName" VARCHAR(20) UNIQUE NOT NULL,
	"password" VARCHAR(20) NOT NULL,
	"recoveryPasswordCode" INTEGER  CHECK ("recoveryPasswordCode" >= 0 AND "recoveryPasswordCode" <= 999999),
	"privateProfile" BOOLEAN DEFAULT FALSE,
	"name" VARCHAR(30),
	"lastName" VARCHAR(30),
	"age" INTEGER CHECK("age" >= 18 AND "age"<=120),
	"createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("userId")
);


CREATE TABLE IF NOT EXISTS "posts"(
	"postId" UUID DEFAULT uuid_generate_v4(),
	"textContent" TEXT,
	"urlImage" VARCHAR(2048),
	"likesCount" INTEGER DEFAULT 0,
	"createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	"userId" UUID NOT NULL,
	PRIMARY KEY("postId"),
	FOREIGN KEY("userId") REFERENCES "users"("userId") ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS "comments"(
	"commentId" UUID DEFAULT uuid_generate_v4(),
	"textContent" TEXT,
	"userId" UUID NOT NULL,
	"postId" UUID,
	"rootComment" UUID DEFAULT NULL,
	"createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("commentId"),
	FOREIGN KEY("userId") REFERENCES "users"("userId") ON DELETE CASCADE,
	FOREIGN KEY("postId") REFERENCES "posts"("postId") ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS "postsLikes"(
	"postLikeId" UUID DEFAULT uuid_generate_v4(),
	"userId" UUID NOT NULL,
	"postId" UUID NOT NULL,
	"createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("postLikeId"),
	FOREIGN KEY("userId") REFERENCES "users"("userId") ON DELETE CASCADE,
	FOREIGN KEY("postId") REFERENCES "posts"("postId") ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS "commentsLikes"(
	"commentLikeId" UUID DEFAULT uuid_generate_v4(),
	"userId" UUID NOT NULL,
	"commentId" UUID NOT NULL,
	"createdAt" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("commentLikeId"),
	FOREIGN KEY("userId") REFERENCES "users"("userId") ON DELETE CASCADE,
	FOREIGN KEY("commentId") REFERENCES "comments"("commentId") ON DELETE CASCADE
);
