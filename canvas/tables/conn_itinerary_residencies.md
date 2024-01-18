#conn travelgroup_itinerary_residence

| column_name     | column_data_type                                                   | index    |
| --------------- | ------------------------------------------------------------------ | -------- |
| id              | int                                                                | PK NN AI |
| itinerary       | [[canvas/tables/tbl_itinerary_items\|conn_travelgroup_itineraries]].id | FK NN    |
| residence       | [[canvas/tables/tbl_residences\|tbl_residences]].id                | FK NN    |
| inbound invoice | [[canvas/tables/tbl_inbound_invoices\|tbl_inbound_invoices]].id    | FK NN       |
