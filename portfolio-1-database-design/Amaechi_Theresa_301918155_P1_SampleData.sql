-- Fictional sample records for Ride-hailing / Logistics System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."rider" ("rider_id", "display_name", "email", "created_at") VALUES (1, 'Avery Rider', 'avery@synthetic.test', '2026-01-05T09:00:00Z');
INSERT INTO portfolio."rider" ("rider_id", "display_name", "email", "created_at") VALUES (2, 'Blake Rider', 'blake@synthetic.test', '2026-01-06T10:30:00Z');
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on") VALUES (11, 'Casey Driver', 'SYN-LIC-101', TRUE, '2025-11-12');
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on") VALUES (12, 'Devon Driver', 'SYN-LIC-102', TRUE, '2025-12-03');
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare") VALUES (21, 1, NULL, '2026-02-10T14:00:00Z', 'North', 'requested', 18.5);
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare") VALUES (22, 2, 11, '2026-02-11T08:15:00Z', 'Central', 'assigned', 24);
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare") VALUES (23, 1, 12, '2026-02-12T17:45:00Z', 'South', 'completed', 31.25);
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method") VALUES (31, 23, 31.25, '2026-02-12T18:10:00Z', 'card');
COMMIT;
