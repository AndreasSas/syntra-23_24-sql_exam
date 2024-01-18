#table telephones

| column_name | column_data_type | index |
| ---- | ---- | ---- |
| id | uuid | PK NN AI |
| customer | [[canvas/tables/tbl_customers\|tbl_customers]].id | FK NN |
| type | [[canvas/tables/tbl_telephone_types\|tbl_telephone_type]].id | FK NN |
| number | nvarchar(12) | NN |
| allow_marketing | boolean | NN default=true |
