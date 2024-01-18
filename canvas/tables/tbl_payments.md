#table payments

| column_name  | column_data_type                                          | index |
| ------------ | --------------------------------------------------------- | ----- |
| id           | uuid                                                      | PK NN |
| invoice      | [[canvas/tables/tbl_invoices\|tbl_invoices]].id                                                          | FK NN |
| datetime     | datetime                                                  | NN    |
| amount       | int                                                       | NN    |
| paymentdata  | nvarchar(max)                                             |       |
| payment_type | [[canvas/tables/tbl_payment_types\|tbl_payment_types]].id | FK NN    |
