#table inbound invoices

| column_name  | column_data_type | index |
| ------------ | ---------------- | ----- |
| id           | uuid             | PK NN |
| invoice_file | FILESTREAM       |       |
| amount       | int              | NN    | 
