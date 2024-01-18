#table employees

| column_name | column_data_type | index |
| ---- | ---- | ---- |
| id | uuid | PK NN |
| person | [[canvas/tables/tbl_persons\|tbl_persons]].id | FK UQ NN |
| is_sales | boolean |  |
| is_supervisor | boolean |  |
| is_manager | boolean |  |
| email_internal | nvarchar(64) | NN |

---

Could also have written this as a different table for the "tags" of what title an employee has, but this is fine for now.