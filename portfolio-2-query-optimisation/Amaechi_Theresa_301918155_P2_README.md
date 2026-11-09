# Ride-hailing / Logistics System — SQL queries

## 1. Show related trip, rider, driver records (up to 20).

```sql
SELECT t0."trip_id" AS "trip_trip_id",
       t0."scheduled_at" AS "trip_scheduled_at",
       t1."rider_id" AS "rider_rider_id",
       t1."display_name" AS "rider_display_name",
       t2."driver_id" AS "driver_driver_id",
       t2."display_name" AS "driver_display_name"
FROM portfolio."trip" t0
JOIN portfolio."rider" t1 ON t0."rider_id" = t1."rider_id"
JOIN portfolio."driver" t2 ON t0."driver_id" = t2."driver_id"
ORDER BY t0."trip_id", t1."rider_id", t2."driver_id"
LIMIT 20;
```

| trip_trip_id | trip_scheduled_at | rider_rider_id | rider_display_name | driver_driver_id | driver_display_name |
| --- | --- | --- | --- | --- | --- |
| 22 | 2026-02-11T08:15:00+00:00 | 2 | Blake Rider | 11 | Casey Driver |
| 23 | 2026-02-12T17:45:00+00:00 | 1 | Avery Rider | 12 | Devon Driver |

## 2. Find trip records where status matches "requested" (up to 20).

```sql
SELECT * FROM portfolio."trip"
WHERE "status" IS NOT DISTINCT FROM 'requested'
ORDER BY "trip_id"
LIMIT 20;
```

| trip_id | rider_id | driver_id | scheduled_at | pickup_zone | status | fare |
| --- | --- | --- | --- | --- | --- | --- |
| 21 | 1 | NULL | 2026-02-10T14:00:00+00:00 | North | requested | 18.5 |

## 3. Count payment records for each trip_id (up to 20 groups).

```sql
SELECT "trip_id", count(*) AS record_count
FROM portfolio."payment"
GROUP BY "trip_id"
ORDER BY record_count DESC, "trip_id" NULLS LAST
LIMIT 20;
```

| trip_id | record_count |
| --- | --- |
| 23 | 1 |

## 4. Find trip records where status matches "requested" (up to 20).

```sql
SELECT * FROM portfolio."trip"
WHERE "status" IS NOT DISTINCT FROM 'requested'
ORDER BY "trip_id"
LIMIT 20;
```

| trip_id | rider_id | driver_id | scheduled_at | pickup_zone | status | fare |
| --- | --- | --- | --- | --- | --- | --- |
| 21 | 1 | NULL | 2026-02-10T14:00:00+00:00 | North | requested | 18.5 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 1.071 | 1.071, 1.101, 1.069 | Sort → Seq Scan | 131 |
| After index | 0.234 | 0.234, 0.191, 0.309 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 1.071 ms to 0.234 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=1.047..1.048 rows=20 loops=1)
  Seq Scan on trip (actual time=0.015..1.013 rows=20 loops=1)
Planning Time: 0.391 ms
Execution Time: 1.071 ms
```

### Before index, run 2

```text
Sort (actual time=1.075..1.078 rows=20 loops=1)
  Seq Scan on trip (actual time=0.016..1.018 rows=20 loops=1)
Planning Time: 0.36 ms
Execution Time: 1.101 ms
```

### Before index, run 3

```text
Sort (actual time=1.043..1.045 rows=20 loops=1)
  Seq Scan on trip (actual time=0.014..1.009 rows=20 loops=1)
Planning Time: 0.374 ms
Execution Time: 1.069 ms
```

### After index, run 1

```text
Sort (actual time=0.174..0.176 rows=20 loops=1)
  Bitmap Heap Scan on trip (actual time=0.037..0.124 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.02..0.021 rows=20 loops=1)
Planning Time: 2.848 ms
Execution Time: 0.234 ms
```

### After index, run 2

```text
Sort (actual time=0.147..0.149 rows=20 loops=1)
  Bitmap Heap Scan on trip (actual time=0.026..0.111 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.015 rows=20 loops=1)
Planning Time: 0.571 ms
Execution Time: 0.191 ms
```

### After index, run 3

```text
Sort (actual time=0.243..0.246 rows=20 loops=1)
  Bitmap Heap Scan on trip (actual time=0.061..0.186 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.025..0.025 rows=20 loops=1)
Planning Time: 1.086 ms
Execution Time: 0.309 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Amaechi_Theresa_301918155_P2_Queries.sql, then Amaechi_Theresa_301918155_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Amaechi_Theresa_301918155_P2_QueryResults.png) · [Index comparison](screenshots/Amaechi_Theresa_301918155_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

