#view supervisors

A quick check to see if all employees assigned to a travelgroup are indeed allowed to be supervisors

```sql
-- pseudo code

select employee from tbl_travelgroup where employee.is_superviror == False 

```
