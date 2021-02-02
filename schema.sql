ALTER TABLE IF EXISTS "todo" DROP CONSTRAINT IF EXISTS fk_user_id CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS "todo" CASCADE;

CREATE TABLE "user" (
	id serial,
	name varchar(255));

CREATE TABLE "todo" (
	id serial,
	task varchar(255),
	user_id int,
	done boolean);

ALTER TABLE "user" ADD CONSTRAINT pk_user_id PRIMARY KEY (id);
ALTER TABLE "todo" ADD CONSTRAINT pk_todo_id PRIMARY KEY (id);

ALTER TABLE "todo" ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES "user" (id);
