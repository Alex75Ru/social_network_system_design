CREATE TABLE "subscriptions" (
  "follower_user_id" integer,
  "followee_user_id" integer,
  "created_at" timestamp
);

CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "email" varchar,
  "password" varchar,
  "created_at" timestamp
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "description" text,
  "user_id" integer,
  "status" varchar,
  "place" integer,
  "photos" integer[],
  "created_at" timestamp
);

CREATE TABLE "places" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "country" varchar,
  "city" varchar,
  "latitude" double,
  "longitude" double,
  "created_at" timestamp
);

CREATE TABLE "photos" (
  "id" integer PRIMARY KEY,
  "url" varchar,
  "user_id" integer,
  "created_at" timestamp
);

CREATE TABLE "messages" (
  "id" integer PRIMARY KEY,
  "sender_user_id" integer,
  "receiver_user_id" integer,
  "created_at" timestamp
);

CREATE TABLE "rating" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "value" integer,
  "created_at" timestamp
);

CREATE TABLE "rate_history" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "value" integer,
  "created_at" timestamp
);

CREATE TABLE "comments" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "text" varchar,
  "created_at" timestamp
);

COMMENT ON COLUMN "posts"."description" IS 'Content of the post';

ALTER TABLE "posts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("follower_user_id") REFERENCES "users" ("id");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("followee_user_id") REFERENCES "users" ("id");

ALTER TABLE "posts" ADD FOREIGN KEY ("place") REFERENCES "places" ("id");

ALTER TABLE "photos" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
