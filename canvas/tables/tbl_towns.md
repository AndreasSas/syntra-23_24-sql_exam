#table towns

| column_name     | column_data_type                                  | index |
| --------------- | ------------------------------------------------- | ----- |
| id              | uuid                                              | PK NN |
| country         | [[canvas/tables/tbl_countries\|tbl_countries]].id | FK NN |
| state           | nvarchar(64)                                       | NN    |
| town_name       | nvarchar(64)                                       | NN    |
| town_postalcode | nvarchar(12)                                       |       |