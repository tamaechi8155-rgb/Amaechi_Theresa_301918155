# Ride-hailing / Logistics System — ER diagram

```mermaid
erDiagram
    direction LR
    rider {
        bigint rider_id PK
        text display_name
        text email UK
        timestamptz created_at
    }
    driver {
        bigint driver_id PK
        text display_name
        text license_code UK
        boolean active
        date joined_on
    }
    trip {
        bigint trip_id PK
        bigint rider_id FK
        bigint driver_id FK "Optional"
        timestamptz scheduled_at
        text pickup_zone
        text status
        numeric fare
    }
    payment {
        bigint payment_id PK
        bigint trip_id FK,UK
        numeric amount
        timestamptz paid_at
        text method
    }
    rider ||--o{ trip : "rider_id"
    driver o|--o{ trip : "driver_id"
    trip ||--o| payment : "trip_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Amaechi_Theresa_301918155_ERDiagram.png)
