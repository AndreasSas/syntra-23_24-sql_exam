#table transportation types

| column_name | column_data_type | index |
| ----------- | ---------------- | ----- |
| id          | int              | PK NN AI |
| name        | nvarchar(8)      | UQ NN      |

---
Used an INT, because these types are generally set once, use forever. Could have been an ENUM in code as well, but as this is an exam on designing a database in SQL, went for it this way.
```sql
'bus',
'train',
'airplane'
```