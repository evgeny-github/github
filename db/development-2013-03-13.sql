PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
INSERT INTO "schema_migrations" VALUES('20130312084932');
INSERT INTO "schema_migrations" VALUES('20130312085025');
INSERT INTO "schema_migrations" VALUES('20130312094330');
INSERT INTO "schema_migrations" VALUES('20130313103149');
INSERT INTO "schema_migrations" VALUES('20130313103320');
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "email" varchar(255), "password" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO "users" VALUES(1,'user1','u1@mail.ru','12345','2013-03-12 09:55:10.578125','2013-03-12 09:55:10.578125');
INSERT INTO "users" VALUES(2,'user2','u2@mail.ru','12345','2013-03-12 09:55:19.046875','2013-03-12 09:55:19.046875');
INSERT INTO "users" VALUES(3,'user3','u3@mail.ru','12345','2013-03-12 09:55:26.640625','2013-03-12 09:55:26.640625');
INSERT INTO "users" VALUES(6,'user4','u4@mail.ru','','2013-03-12 12:22:16.265625','2013-03-13 09:25:44.609375');
INSERT INTO "users" VALUES(8,NULL,NULL,NULL,'2013-03-12 13:06:51.718750','2013-03-12 13:06:51.718750');
CREATE TABLE "goods" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "count" integer, "price" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO "goods" VALUES(1,'paper A4',123,15,'2013-03-12 09:56:22.656250','2013-03-12 09:56:22.656250');
INSERT INTO "goods" VALUES(3,'paper A3',35,22,'2013-03-12 09:57:02.734375','2013-03-12 09:57:02.734375');
INSERT INTO "goods" VALUES(4,'paper A5',50,13,'2013-03-12 09:57:18.125000','2013-03-12 09:57:18.125000');
INSERT INTO "goods" VALUES(5,'pencil',120,2,'2013-03-12 09:57:32.218750','2013-03-12 09:57:32.218750');
INSERT INTO "goods" VALUES(6,'marker',200,2,'2013-03-12 09:57:44.328125','2013-03-12 09:57:44.328125');
INSERT INTO "goods" VALUES(7,'rubber',100,1,'2013-03-12 09:58:02.187500','2013-03-12 09:58:02.187500');
INSERT INTO "goods" VALUES(8,'ruler 8inch',90,3,'2013-03-12 09:58:30.687500','2013-03-12 09:58:30.687500');
INSERT INTO "goods" VALUES(9,'ruler 12inch',110,6,'2013-03-12 09:58:48.375000','2013-03-12 09:58:48.375000');
INSERT INTO "goods" VALUES(10,'clip',150,2,'2013-03-12 09:59:04.953125','2013-03-12 09:59:04.953125');
INSERT INTO "goods" VALUES(12,'ink pen',5,15,'2013-03-12 15:59:56.531250','2013-03-12 16:00:40.781250');
INSERT INTO "goods" VALUES(13,'ink',20,4,'2013-03-12 16:01:06.500000','2013-03-12 16:01:06.500000');
INSERT INTO "goods" VALUES(14,'notebook',220,14,'2013-03-12 16:01:44.281250','2013-03-12 16:01:44.281250');
INSERT INTO "goods" VALUES(16,'gelly pen',150,7,'2013-03-12 16:03:15.687500','2013-03-12 16:03:15.687500');
CREATE TABLE "baskets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "good_id" integer, "count" integer, "price" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "send" boolean, "send_date" datetime);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('users',13);
INSERT INTO "sqlite_sequence" VALUES('goods',16);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
COMMIT;
