-- Ride-hailing / Logistics System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."rider" (
  "rider_id" bigint NOT NULL,
  "display_name" text NOT NULL,
  "email" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  CONSTRAINT "pk_rider" PRIMARY KEY ("rider_id"),
  CONSTRAINT "uq_rider_0" UNIQUE ("email")
);
CREATE TABLE portfolio."driver" (
  "driver_id" bigint NOT NULL,
  "display_name" text NOT NULL,
  "license_code" text NOT NULL,
  "active" boolean NOT NULL,
  "joined_on" date NOT NULL,
  CONSTRAINT "pk_driver" PRIMARY KEY ("driver_id"),
  CONSTRAINT "uq_driver_0" UNIQUE ("license_code")
);
CREATE TABLE portfolio."trip" (
  "trip_id" bigint NOT NULL,
  "rider_id" bigint NOT NULL,
  "driver_id" bigint,
  "scheduled_at" timestamptz NOT NULL,
  "pickup_zone" text NOT NULL,
  "status" text NOT NULL,
  "fare" numeric(18,2) NOT NULL,
  CONSTRAINT "pk_trip" PRIMARY KEY ("trip_id")
);
CREATE TABLE portfolio."payment" (
  "payment_id" bigint NOT NULL,
  "trip_id" bigint NOT NULL,
  "amount" numeric(18,2) NOT NULL,
  "paid_at" timestamptz NOT NULL,
  "method" text NOT NULL,
  CONSTRAINT "pk_payment" PRIMARY KEY ("payment_id"),
  CONSTRAINT "uq_payment_0" UNIQUE ("trip_id")
);
ALTER TABLE portfolio."trip" ADD CONSTRAINT "fk_trip_0" FOREIGN KEY ("rider_id") REFERENCES portfolio."rider" ("rider_id");
ALTER TABLE portfolio."trip" ADD CONSTRAINT "fk_trip_1" FOREIGN KEY ("driver_id") REFERENCES portfolio."driver" ("driver_id");
ALTER TABLE portfolio."payment" ADD CONSTRAINT "fk_payment_0" FOREIGN KEY ("trip_id") REFERENCES portfolio."trip" ("trip_id");
ALTER TABLE portfolio."trip" ADD CONSTRAINT "trip_fare_nonnegative" CHECK ("fare" >= 0);
ALTER TABLE portfolio."trip" ADD CONSTRAINT "trip_status_allowed" CHECK (("status" = 'requested') OR ("status" = 'assigned') OR ("status" = 'in_progress') OR ("status" = 'completed') OR ("status" = 'cancelled'));
CREATE UNIQUE INDEX "one_active_trip_per_driver" ON portfolio."trip" ("driver_id") WHERE ((("status" = 'assigned') OR ("status" = 'in_progress')) AND ("driver_id" IS NOT NULL));
ALTER TABLE portfolio."payment" ADD CONSTRAINT "payment_amount_nonnegative" CHECK ("amount" >= 0);
COMMIT;
