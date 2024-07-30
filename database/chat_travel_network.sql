CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar,
  "created_at" timestamp
)
WITH (distributed_by = 'id', num_shards = 4);

CREATE TABLE "messages" (
  "id" integer PRIMARY KEY,
  "sender_user_id" integer,
  "receiver_user_id" integer,
  "created_at" timestamp,
  "read_at" timestamp
)
WITH (distributed_by = 'shard_key', num_shards = 4);

-- Функция хеширования - для хранения сообщений вместе с отправителем / получателем
CREATE OR REPLACE FUNCTION shard_key(sender_user_id integer, receiver_user_id integer) RETURNS integer AS $$
BEGIN
    RETURN (sender_user_id % 4 + receiver_user_id % 4) % 4;
END;
$$ LANGUAGE plpgsql;