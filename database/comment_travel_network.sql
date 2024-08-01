CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "created_at" timestamp
)
WITH (global);

CREATE TABLE "comments" (
  "id" integer PRIMARY KEY,
  "post_id" integer,
  "reply_id" integer,
  "user_id" integer,
  "text" varchar,
  "created_at" timestamp
)
WITH (distributed_by = 'post_id', num_parts = 4);
