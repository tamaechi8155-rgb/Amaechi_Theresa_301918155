-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. reject rider pk. Expected: pk_rider, SQLSTATE 23505.
INSERT INTO portfolio."rider" ("rider_id", "display_name", "email", "created_at")
VALUES (1, 'Rider PK Test', 'rider-pk@synthetic.test', '2026-03-01T09:00:00Z');

-- 2. reject rider unique. Expected: uq_rider_0, SQLSTATE 23505.
INSERT INTO portfolio."rider" ("rider_id", "display_name", "email", "created_at")
VALUES (1001, 'Rider Unique Test', 'avery@synthetic.test', '2026-03-01T09:01:00Z');

-- 3. reject rider id null. Expected: rider_id, SQLSTATE 23502.
INSERT INTO portfolio."rider" ("rider_id", "display_name", "email", "created_at")
VALUES (NULL, 'Rider Null ID', 'rider-null-id@synthetic.test', '2026-03-01T09:02:00Z');

-- 4. reject rider name null. Expected: display_name, SQLSTATE 23502.
INSERT INTO portfolio."rider" ("rider_id", "display_name", "email", "created_at")
VALUES (1003, NULL, 'rider-null-name@synthetic.test', '2026-03-01T09:03:00Z');

-- 5. reject rider email null. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."rider" ("rider_id", "display_name", "email", "created_at")
VALUES (1004, 'Rider Null Email', NULL, '2026-03-01T09:04:00Z');

-- 6. reject rider created null. Expected: created_at, SQLSTATE 23502.
INSERT INTO portfolio."rider" ("rider_id", "display_name", "email", "created_at")
VALUES (1005, 'Rider Null Created', 'rider-null-created@synthetic.test', NULL);

-- 7. reject driver pk. Expected: pk_driver, SQLSTATE 23505.
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on")
VALUES (11, 'Driver PK Test', 'SYN-LIC-201', TRUE, '2026-03-01');

-- 8. reject driver unique. Expected: uq_driver_0, SQLSTATE 23505.
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on")
VALUES (1007, 'Driver Unique Test', 'SYN-LIC-101', TRUE, '2026-03-01');

-- 9. reject driver id null. Expected: driver_id, SQLSTATE 23502.
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on")
VALUES (NULL, 'Driver Null ID', 'SYN-LIC-203', TRUE, '2026-03-01');

-- 10. reject driver name null. Expected: display_name, SQLSTATE 23502.
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on")
VALUES (1009, NULL, 'SYN-LIC-204', TRUE, '2026-03-01');

-- 11. reject driver license null. Expected: license_code, SQLSTATE 23502.
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on")
VALUES (1010, 'Driver Null License', NULL, TRUE, '2026-03-01');

-- 12. reject driver active null. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on")
VALUES (1011, 'Driver Null Active', 'SYN-LIC-206', NULL, '2026-03-01');

-- 13. reject driver joined null. Expected: joined_on, SQLSTATE 23502.
INSERT INTO portfolio."driver" ("driver_id", "display_name", "license_code", "active", "joined_on")
VALUES (1012, 'Driver Null Joined', 'SYN-LIC-207', TRUE, NULL);

-- 14. reject trip pk. Expected: pk_trip, SQLSTATE 23505.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (22, 1, NULL, '2026-03-02T10:00:00Z', 'West', 'requested', 12);

-- 15. reject trip rider fk. Expected: fk_trip_0, SQLSTATE 23503.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1014, 9001, NULL, '2026-03-02T10:01:00Z', 'West', 'requested', 12);

-- 16. reject trip driver fk. Expected: fk_trip_1, SQLSTATE 23503.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1015, 1, 9002, '2026-03-02T10:02:00Z', 'West', 'requested', 12);

-- 17. reject trip id null. Expected: trip_id, SQLSTATE 23502.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (NULL, 1, NULL, '2026-03-02T10:03:00Z', 'West', 'requested', 12);

-- 18. reject trip rider null. Expected: rider_id, SQLSTATE 23502.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1017, NULL, NULL, '2026-03-02T10:04:00Z', 'West', 'requested', 12);

-- 19. reject trip scheduled null. Expected: scheduled_at, SQLSTATE 23502.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1018, 1, NULL, NULL, 'West', 'requested', 12);

-- 20. reject trip zone null. Expected: pickup_zone, SQLSTATE 23502.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1019, 1, NULL, '2026-03-02T10:05:00Z', NULL, 'requested', 12);

-- 21. reject trip status null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1020, 1, NULL, '2026-03-02T10:06:00Z', 'West', NULL, 12);

-- 22. reject trip fare null. Expected: fare, SQLSTATE 23502.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1021, 1, NULL, '2026-03-02T10:07:00Z', 'West', 'requested', NULL);

-- 23. reject payment pk. Expected: pk_payment, SQLSTATE 23505.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (31, 22, 24, '2026-03-03T11:00:00Z', 'card');

-- 24. reject payment unique. Expected: uq_payment_0, SQLSTATE 23505.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (1023, 23, 31.25, '2026-03-03T11:01:00Z', 'card');

-- 25. reject payment fk. Expected: fk_payment_0, SQLSTATE 23503.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (1024, 9003, 12, '2026-03-03T11:02:00Z', 'card');

-- 26. reject payment id null. Expected: payment_id, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (NULL, 22, 24, '2026-03-03T11:03:00Z', 'card');

-- 27. reject payment trip null. Expected: trip_id, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (1026, NULL, 24, '2026-03-03T11:04:00Z', 'card');

-- 28. reject payment amount null. Expected: amount, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (1027, 22, NULL, '2026-03-03T11:05:00Z', 'card');

-- 29. reject payment paid null. Expected: paid_at, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (1028, 22, 24, NULL, 'card');

-- 30. reject payment method null. Expected: method, SQLSTATE 23502.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (1029, 22, 24, '2026-03-03T11:06:00Z', NULL);

-- 31. reject trip fare check. Expected: trip_fare_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1030, 1, NULL, '2026-03-04T12:00:00Z', 'East', 'requested', -1);

-- 32. reject trip status check. Expected: trip_status_allowed, SQLSTATE 23514.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1031, 1, NULL, '2026-03-04T12:01:00Z', 'East', 'waiting', 10);

-- 33. reject trip active unique. Expected: one_active_trip_per_driver, SQLSTATE 23505.
INSERT INTO portfolio."trip" ("trip_id", "rider_id", "driver_id", "scheduled_at", "pickup_zone", "status", "fare")
VALUES (1032, 1, 11, '2026-03-04T12:02:00Z', 'East', 'assigned', 10);

-- 34. reject payment amount check. Expected: payment_amount_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."payment" ("payment_id", "trip_id", "amount", "paid_at", "method")
VALUES (1033, 22, -1, '2026-03-04T12:03:00Z', 'card');
