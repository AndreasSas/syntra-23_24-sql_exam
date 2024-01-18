#view invoice_items

```sql
-- pseudo code

select tbl_inbound_invoice.amount
where tbl_inbound_invoices.id == 
	any invoice where invoice.group = '...'
		in conn_itinerary_residence.id
		in conn_itinerary_poi.id
		in conn_itinerary_transport.id


```
