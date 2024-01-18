#table transportation

| column_name | column_data_type                                                        | index |
| ----------- | ----------------------------------------------------------------------- | ----- |
| id          | uuid                                                                    | PK NN |
| type        | [[canvas/tables/tbl_transportation_types\|tbl_transportation_types]].id | FK NN |
| name        | varchar(64)                                                             | NN    |
| details     | varchar(max)                                                            |       |
| inbound invoice | [[canvas/tables/tbl_inbound_invoices\|tbl_inbound_invoices]].id    | FK NN       | 
