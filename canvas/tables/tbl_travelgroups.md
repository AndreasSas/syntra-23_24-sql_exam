#table travelgroup

| column_name   | column_data_type                                  | index |
| ------------- | ------------------------------------------------- | ----- |
| id            | uuid                                              | PK NN |
| supervisor    | [[canvas/tables/tbl_employees\|tbl_employees]].id | FK NN |
| invoice       | [[canvas/tables/tbl_invoices\|tbl_invoices]].id   | FK UQ NN |
| group_created | datetime                                          | NN    | 
