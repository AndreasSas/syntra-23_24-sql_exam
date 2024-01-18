#conn person_has_made_payment

| column_name           | column_data_type                                                                          | index    |
| --------------------- | ----------------------------------------------------------------------------------------- | -------- |
| id                    | int                                                                                       | PK NN AI |
| person_in_travelgroup | [[canvas/tables/conn_people_in_travelgroup\|conn_people_in_travelgroup]].id               | FK NN    |
| payment               | [[canvas/tables/tbl_payments\|tbl_payments]].id                                           | FK NN    |
| type                  | [[canvas/tables/tbl_person_has_made_mayment_types\|tbl_person_has_made_mayment_types]].id | FK NN    | 

Added because maybe a certain person will make the payment in multiple orders