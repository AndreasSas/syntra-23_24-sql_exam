#table point of interest

| column_name | column_data_type                                  | index |
| ----------- | ------------------------------------------------- | ----- |
| id          | uuid                                              | PK NN |
| name        | nvarchar(128)                                     | NN `UQ TOGETHER`    |
| details     | nvarchar(255)                                     |       |
| address     | [[canvas/tables/tbl_addresses\|tbl_addresses]].id | FK NN `UQ TOGETHER` | 

---
