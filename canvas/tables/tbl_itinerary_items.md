#table itineraries items

| column_name | column_data_type | index |  |  |
| ---- | ---- | ---- | ---- | ---- |
| id | uuid | PK NN |  |  |
| travelgroup | [[canvas/tables/tbl_travelgroups\|tbl_travelgroups]].id | NN |  |  |
| departure_time | datetime | NN |  |  |
| arrival_time | datetime | NN |  |  |
| departure_location | [[canvas/tables/tbl_addresses\|tbl_addresses]].id | FK NN |  |  |
| arrival_location | [[canvas/tables/tbl_addresses\|tbl_addresses]].id | FK NN |  |  |
