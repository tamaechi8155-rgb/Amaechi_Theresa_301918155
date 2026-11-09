# Ride-hailing / Logistics System — database design

My case study records rider, driver, trip, payment.

## Users

- Dispatchers reviewing requested trips and assigning drivers
- Operations analysts reviewing trip activity and driver revenue

## Main operations

- Register riders and drivers
- Request, assign, and update trips
- Record a payment for a trip

## Entities

| Entity | Information stored |
| --- | --- |
| rider | Stores rider details referenced by trips. |
| driver | Stores drivers eligible for trip assignment. |
| trip | Records a rider's requested trip, its optional driver assignment, and its status. |
| payment | Records a trip's payment amount, date, and method. |

## rider

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| rider_id | BIGINT | PK | Yes |
| display_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
- Unique key: (email).

## driver

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| driver_id | BIGINT | PK | Yes |
| display_name | TEXT |  | Yes |
| license_code | TEXT | Unique | Yes |
| active | BOOLEAN |  | Yes |
| joined_on | DATE |  | Yes |
- Unique key: (license_code).

## trip

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| trip_id | BIGINT | PK | Yes |
| rider_id | BIGINT | FK | Yes |
| driver_id | BIGINT | FK | No |
| scheduled_at | TIMESTAMPTZ |  | Yes |
| pickup_zone | TEXT |  | Yes |
| status | TEXT |  | Yes |
| fare | NUMERIC(18,2) |  | Yes |
- rider_id → rider.rider_id
- driver_id → driver.driver_id

## payment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| payment_id | BIGINT | PK | Yes |
| trip_id | BIGINT | FK, Unique | Yes |
| amount | NUMERIC(18,2) |  | Yes |
| paid_at | TIMESTAMPTZ |  | Yes |
| method | TEXT |  | Yes |
- trip_id → trip.trip_id
- Unique key: (trip_id).

## Relationships and business rules

- Each rider email identifies at most one rider.
- Each driver license code identifies at most one driver.
- Every trip references an existing rider through rider_id.
- A non-null trip driver_id references an existing driver.
- Every payment references an existing trip through trip_id.
- Trip fare must be zero or greater.
- Trip status must be requested, assigned, in_progress, completed, or cancelled.
- A partial unique rule on driver_id applies only when status is assigned or in_progress, so each driver has at most one active trip.
- At most one payment record may reference a trip.
- Payment amount must be zero or greater.

## Assumptions

- All records use synthetic values. Each entity has one single-column primary key, and all primary-key identifiers are globally distinct across the exercise dataset.
- A trip has one rider and may have no driver until assigned; a payment is optional and there is at most one payment per trip.
- For a simple normalization exercise, start with a denormalized payment record containing trip time and pickup zone, then move those trip-specific attributes to trip. Payment references trip as its single ancestor role in this example.

