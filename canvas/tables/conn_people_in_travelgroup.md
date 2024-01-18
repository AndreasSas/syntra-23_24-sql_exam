#conn people_in_travelgroup

| column_name | column_data_type                                        | index                         |
| ----------- | ------------------------------------------------------- | ----------------------------- |
| id          | int                                                     | PK NN AI                      |
| travelgroup | [[canvas/tables/tbl_travelgroups\|tbl_travelgroups]].id | FK NN `Unique Index Together` |
| customer      | [[canvas/tables/tbl_customers\|tbl_customers]].id           | FK NN `Unique Index Together` | 
