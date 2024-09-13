
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
)