#table people

| column_name     | column_data_type | index    |
| --------------- | ---------------- | -------- |
| id              | uuid             | PK NN AI |
| name_first      | nvarchar(64)      | NN       |
| name_middle     | nvarchar(64)      |          |
| name_last       | nvarchar(64)      | NN       |
| date_of_birth   | datetime         | NN       |
| SSN             | nvarchar(64)      | UQ NN       |
| passport_number | nvarchar(64)      | UQ NN       | 
