#table residences

| column_name | column_data_type | index |
| ---- | ---- | ---- |
| id | uuid | PK NN |
| type | [[canvas/tables/tbl_residence_types\|tbl_residence_types]].id | FK NN |
| address | [[canvas/tables/tbl_addresses\|tbl_addresses]].id | FK NN `UQ TOGETHER` |
| name | nvarchar(128) | NN `UQ TOGETHER` |
| details | nvarchar(MAX) |  |
|  |  |  |

