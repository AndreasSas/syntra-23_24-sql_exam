#table invoice_status_types

| column_name | column_data_type | index    |
| ----------- | ---------------- | -------- |
| id          | int              | PK NN AI |
| name        | nvarchar(16)      | UQ NN         |

---
```sql
'created',
'reminder sent',
'paid in full',
'waiting for clients'
```