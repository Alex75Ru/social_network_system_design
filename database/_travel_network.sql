CREATE TABLE "subscriptions" (
  "follower_user_id" integer,
  "followee_user_id" integer,
  "created_at" timestamp
)
WITH (distributed_by = 'follower_user_id', colocate_with = 'users', num_parts = 4);

CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "email" varchar,
  "password" varchar,
  "created_at" timestamp
)
WITH (distributed_by = 'id', num_parts = 4);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "description" text,
  "user_id" integer,
  "status" varchar,
  "place" integer,
  "photos" integer[],
  "created_at" timestamp
)
WITH (distributed_by = 'user_id', colocate_with = 'users', num_parts = 4);

CREATE TABLE "places" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "country" varchar,
  "city" varchar,
  "latitude" double precision,
  "longitude" double precision,
  "created_at" timestamp
)
    WITH (global);

CREATE TABLE "photos" (
  "id" integer PRIMARY KEY,
  "url" varchar,
  "user_id" integer,
  "created_at" timestamp
)
WITH (distributed_by = 'user_id', colocate_with = 'users', num_parts = 4);

CREATE TABLE "messages" (
  "id" integer PRIMARY KEY,
  "sender_user_id" integer,
  "receiver_user_id" integer,
  "created_at" timestamp
)
    WITH (global);

CREATE TABLE "rating" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "value" integer,
  "created_at" timestamp
)
WITH (distributed_by = 'post_id', colocate_with = 'posts', num_parts = 4);

CREATE TABLE "rate_history" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "value" integer,
  "created_at" timestamp
)
WITH (distributed_by = 'post_id', colocate_with = 'posts', num_parts = 4);

CREATE TABLE "comments" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "user_id" integer,
  "text" varchar,
  "created_at" timestamp
)
WITH (distributed_by = 'post_id', colocate_with = 'posts', num_parts = 4);

COMMENT ON COLUMN "posts"."description" IS 'Content of the post';

ALTER TABLE "posts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("follower_user_id") REFERENCES "users" ("id");

ALTER TABLE "subscriptions" ADD FOREIGN KEY ("followee_user_id") REFERENCES "users" ("id");

ALTER TABLE "posts" ADD FOREIGN KEY ("place") REFERENCES "places" ("id");

ALTER TABLE "photos" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");
