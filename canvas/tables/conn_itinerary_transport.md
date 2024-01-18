#conn itinerary_transport

| column_name  | column_data_type                                            | index    |
| ------------ | ----------------------------------------------------------- | -------- |
| id           | int                                                         | PK NN AI |
| itinerary    | [[canvas/tables/tbl_itinerary_items\|tbl_itineraries]].id       | FK NN    |
| transport.id | [[canvas/tables/tbl_transportation\|tbl_transportation]].id | FK NN    |
