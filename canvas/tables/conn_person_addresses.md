#conn person_addresses

| column_name            | column_data_type                                  | index    |
| ---------------------- | ------------------------------------------------- | -------- |
| id                     | int                                               | PK NN AI |
| person                 | [[canvas/tables/tbl_persons\|tbl_persons]].id     | FK NN    |
| address                | [[canvas/tables/tbl_addresses\|tbl_addresses]].id | FK NN    |
