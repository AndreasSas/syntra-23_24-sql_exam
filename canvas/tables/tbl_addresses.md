#table addresses

| column_name | column_data_type | index |
| ---- | ---- | ---- |
| id | uuid | PK NN |
| town | [[canvas/tables/tbl_towns\|tbl_towns]].id | FK NN |
| street | nvarchar(128) | NN |
| house_number | nvarchar(12) | NN |

