#conn inbound invoice status

| column_name | column_data_type                                                        | index    |
| ----------- | ----------------------------------------------------------------------- | -------- |
| id          | int                                                                     | PK NN AI |
| invoice     | [[canvas/tables/tbl_inbound_invoices\|tbl_inbound_invoices]].id         | FK NN    |
| status      | [[canvas/tables/tbl_invoice_status_types\|tbl_invoice_status_types]].id | FK NN    |
| created     | datetime                                                                | NN       |
