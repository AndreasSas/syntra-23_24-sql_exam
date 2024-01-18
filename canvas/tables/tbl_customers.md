#table customer

| column_name | column_data_type           | index    |
| ----------- | -------------------------- | -------- |
| id          | uuid                       | PK UQ NN |
| username    | nvarchar(16)               | UQ NN    |
| password    | nvarchar(128) `use bcrypt` | NN       |
| person      | [[canvas/tables/tbl_persons\|tbl_persons]].id | FK UQ    |


