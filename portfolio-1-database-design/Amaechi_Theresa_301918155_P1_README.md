# Portfolio 1 — Database Design and Modelling

I organised the data into rider, driver, trip, payment. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| rider | 2 |
| driver | 2 |
| trip | 3 |
| payment | 1 |

The 34 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Amaechi_Theresa_301918155_P1_Design.md)
- [ER diagram](Amaechi_Theresa_301918155_P1_ERDiagram.md)
- [Normalisation](Amaechi_Theresa_301918155_P1_Normalisation.md)
- [Schema](Amaechi_Theresa_301918155_P1_Schema.sql)
- [Sample data](Amaechi_Theresa_301918155_P1_SampleData.sql)
- [Constraint tests](Amaechi_Theresa_301918155_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Amaechi_Theresa_301918155_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

