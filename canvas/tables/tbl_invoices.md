#table invoices

| column_name                          | column_data_type                                  | index |
| ------------------------------------ | ------------------------------------------------- | ----- |
| id                                   | uuid                                              | PK NN |
| created                              | datetime                                          | NN    |
| var_percentage                       | float                                             | NN    |
| amount_total_inbound_invoices_pretax | int                                               | NN    |
| service_fee                          | int                                               | NN    | 
| people_participating                 | int                                               | NN    |
| sale_made_by                         | [[canvas/tables/tbl_employees\|tbl_employees]].id | FK NN |
