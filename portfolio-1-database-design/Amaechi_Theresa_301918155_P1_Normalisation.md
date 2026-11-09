# Ride-hailing / Logistics System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| trip_id | payment records (list) |
| --- | --- |
| 23 | [31] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| payment.payment_id | payment.trip_id | payment.method | trip.trip_id | trip.rider_id | trip.driver_id | trip.pickup_zone | rider.rider_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 31 | 23 | card | 23 | 1 | 12 | South | 1 |

Key: payment_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## payment_example

| payment.payment_id | payment.trip_id | payment.method | trip.trip_id | trip.rider_id | trip.driver_id | trip.pickup_zone | rider.rider_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 31 | 23 | card | 23 | 1 | 12 | South | 1 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## rider

| rider_id | display_name | email | created_at |
| --- | --- | --- | --- |
| 1 | Avery Rider | avery@synthetic.test | 2026-01-05T09:00:00+00:00 |
| 2 | Blake Rider | blake@synthetic.test | 2026-01-06T10:30:00+00:00 |

## driver

| driver_id | display_name | license_code | active | joined_on |
| --- | --- | --- | --- | --- |
| 11 | Casey Driver | SYN-LIC-101 | true | 2025-11-12 |
| 12 | Devon Driver | SYN-LIC-102 | true | 2025-12-03 |

## trip

| trip_id | rider_id | driver_id | scheduled_at | pickup_zone | status | fare |
| --- | --- | --- | --- | --- | --- | --- |
| 21 | 1 | NULL | 2026-02-10T14:00:00+00:00 | North | requested | 18.5 |
| 22 | 2 | 11 | 2026-02-11T08:15:00+00:00 | Central | assigned | 24 |
| 23 | 1 | 12 | 2026-02-12T17:45:00+00:00 | South | completed | 31.25 |

## payment

| payment_id | trip_id | amount | paid_at | method |
| --- | --- | --- | --- | --- |
| 31 | 23 | 31.25 | 2026-02-12T18:10:00+00:00 | card |

## Dependencies

- rider: (rider_id) → display_name, email, created_at
- driver: (driver_id) → display_name, license_code, active, joined_on
- trip: (trip_id) → rider_id, driver_id, scheduled_at, pickup_zone, status, fare
- payment: (payment_id) → trip_id, amount, paid_at, method

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
