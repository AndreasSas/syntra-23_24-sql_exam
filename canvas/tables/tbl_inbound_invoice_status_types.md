#table inbound invoice status types

| column_name | column_data_type | index    |
| ----------- | ---------------- | -------- |
| id          | int              | PK NN AI |
| name        | nvarchar(16)      | UQ NN         |

---
```sql
'received orignal',
'received reminder',
'waiting for clients',
'paid in full'
```