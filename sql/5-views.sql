USE AndreasVacations;
GO

CREATE VIEW vw_InvoiceDetails
AS
SELECT i.id AS InvoiceID,
       i.created,
       i.amount_total_inbound_invoices_pretax,
       i.service_fee,
       i.people_participating,
       e.email_internal AS SalesPersonEmail,
       p.datetime AS PaymentDateTime,
       p.amount AS PaymentAmount,
       pt.name AS PaymentType,
       istt.name AS InvoiceStatus
FROM tbl_invoices i
LEFT JOIN tbl_employees e ON i.sale_made_by = e.id
LEFT JOIN tbl_payments p ON i.id = p.invoice
    LEFT JOIN tbl_payment_types pt ON p.payment_type = pt.id
    LEFT JOIN tbl_invoice_status ist ON i.id = ist.invoice
    LEFT JOIN tbl_invoice_status_types istt ON ist.status = istt.id;
GO

--
CREATE VIEW vw_ItineraryTransportDetails
AS
    SELECT
        ti.id AS ItineraryID,
        tt.name AS TransportationType,
        t.name AS TransportationName,
        t.details AS TransportationDetails
    FROM
        tbl_itinerary_items ti
        LEFT JOIN conn_itinerary_transport cit ON ti.id = cit.itinerary
        LEFT JOIN tbl_transportation t ON t.id = cit.transport_id
        LEFT JOIN tbl_transportation_types tt ON tt.id = t.type;
GO

--
CREATE VIEW vw_CurrentInboundInvoiceStatus
AS
    SELECT ii.id AS InboundInvoiceID, iis.name AS InvoiceStatus, cis.created
    FROM tbl_inbound_invoices ii
    JOIN conn_inbound_invoice_status cis ON ii.id = cis.invoice
    JOIN tbl_inbound_invoice_status_types iis ON cis.status = iis.id
    WHERE cis.created = (
        SELECT MAX(created)
        FROM conn_inbound_invoice_status
        WHERE invoice = ii.id
    );