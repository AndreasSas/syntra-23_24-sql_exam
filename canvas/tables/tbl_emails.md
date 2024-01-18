#table emails

| column_name     | column_data_type                              | index           |
| --------------- | --------------------------------------------- | --------------- |
| id              | uuid                                          | PK NN AI        |
| customer          | [[canvas/tables/tbl_customers\|tbl_customers]].id | FK NN `UQ TOGETHER`         |
| email           | nvarchar(64)                                  | NN `UQ TOGETHER`             |
| allow_marketing | boolean                                       | NN default=true | 

