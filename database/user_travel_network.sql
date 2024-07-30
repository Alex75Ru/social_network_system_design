CREATE TABLE "users" (
                         "id" integer PRIMARY KEY,
                         "username" varchar,
                         "email" varchar,
                         "password" varchar,
                         "created_at" timestamp
)
    WITH (distributed_by = 'id', num_parts = 4);