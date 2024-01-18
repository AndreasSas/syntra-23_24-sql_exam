USE AndreasVacations;

-- Mock Data for tbl_towns
INSERT INTO tbl_towns (id, country, state, town_name, town_postalcode) VALUES
(NEWID(), 'BEL', 'Flemish Brabant', 'Leuven', '3000'),
(NEWID(), 'BEL', 'Brussels Capital', 'Brussels', '1000'),
(NEWID(), 'FRA', N'Île-de-France', 'Paris', '75001'),
(NEWID(), 'ESP', 'Catalonia', 'Barcelona', '08001');

-- Mock Data for tbl_addresses
INSERT INTO tbl_addresses (id, town, street, house_number) VALUES
(NEWID(), dbo.fn_GetCityId('Leuven'), 'Main Street', '123'),
(NEWID(), dbo.fn_GetCityId('Brussels'), 'Grand Avenue', '456'),
(NEWID(), dbo.fn_GetCityId('Paris'), N'Champs-Élysées', '789'),
(NEWID(), dbo.fn_GetCityId('Barcelona'), 'Rambla', '1011');

-- Mock Data for tbl_people
INSERT INTO tbl_people (id, name_first, name_middle, name_last, date_of_birth, ssn, passport_number) VALUES
(NEWID(), 'John', 'Michael', 'Doe', '1985-05-15', '123-45-6789', 'US123456'),
(NEWID(), 'Alice', 'Marie', 'Johnson', '1990-10-22', '456-78-9012', 'UK789012'),
(NEWID(), 'Jane', NULL, 'Smith', '1988-03-08', '789-01-2345', 'DE345678');

-- Mock Data for tbl_customers (assuming John Doe is a customer)
INSERT INTO tbl_customers (id, username, password, person) VALUES
(NEWID(), 'john_doe', 'hashed_password', dbo.fn_GetPersonBySSN('123-45-6789')),
(NEWID(), 'alice_j', 'hashed_password',dbo.fn_GetPersonBySSN('456-78-9012')),
(NEWID(), 'bob_smith', 'hashed_password', dbo.fn_GetPersonBySSN('789-01-2345'));

-- Mock Data for tbl_customer_emails
INSERT INTO tbl_customer_emails (id, customer, email, allow_marketing) VALUES
(NEWID(), dbo.fn_GetCustomerIdByUsername('john_doe'), 'john.doe@email.com', 1),
(NEWID(), dbo.fn_GetCustomerIdByUsername('alice_j'), 'alice.johnson@email.com', 1),
(NEWID(), dbo.fn_GetCustomerIdByUsername('bob_smith'), 'bob.smith@email.com', 0);

-- Mock Data for tbl_customer_telephones
INSERT INTO tbl_customer_telephones (id, customer, type, number, allow_marketing) VALUES
(NEWID(), dbo.fn_GetCustomerIdByUsername('john_doe'), 1, '987-654-3210', 1),
(NEWID(), dbo.fn_GetCustomerIdByUsername('alice_j'), 1, '987-654-3210', 1),
(NEWID(), dbo.fn_GetCustomerIdByUsername('bob_smith'), 2, '123-456-7890', 0);

-- Mock Data for tbl_employees
INSERT INTO tbl_employees (id, person, is_sales, is_supervisor, is_manager, email_internal) VALUES
(NEWID(), (SELECT id FROM tbl_people WHERE name_first = 'John' AND name_last = 'Doe'), 1, 0, 0, 'john.doe@company.com'),
(NEWID(), (SELECT id FROM tbl_people WHERE name_first = 'Jane' AND name_last = 'Smith'), 1, 1, 0, 'jane.smith@company.com');

-- Mock Data for tbl_invoices
INSERT INTO tbl_invoices (id, created, var_percentage, amount_total_inbound_invoices_pretax, service_fee, people_participating, sale_made_by) VALUES
(NEWID(), GETDATE(), 0.1, 1500, 50, 2, (SELECT id FROM tbl_employees WHERE email_internal = 'john.doe@company.com')),
(NEWID(), GETDATE(), 0.15, 2000, 75, 3, (SELECT id FROM tbl_employees WHERE email_internal = 'john.doe@company.com'));

-- Mock Data for tbl_payments
INSERT INTO tbl_payments (id, invoice, datetime, amount, paymentdata, payment_type) VALUES
(NEWID(), (SELECT id FROM tbl_invoices WHERE amount_total_inbound_invoices_pretax = 1500), GETDATE(), 1500, 'Transaction successful', 1),
(NEWID(), (SELECT id FROM tbl_invoices WHERE amount_total_inbound_invoices_pretax = 2000), GETDATE(), 2000, 'Transaction successful', 2);

-- Mock Data for tbl_travelgroups
DECLARE @TRAVELGROUP1 UNIQUEIDENTIFIER = newid();
DECLARE @TRAVELGROUP2 UNIQUEIDENTIFIER = newid();

INSERT INTO tbl_travelgroups (id, supervisor, invoice, group_created) VALUES
(@TRAVELGROUP1, (SELECT id FROM tbl_employees WHERE email_internal = 'john.doe@company.com'), (SELECT id FROM tbl_invoices WHERE people_participating = 2), '2024-02-15'),
(@TRAVELGROUP2, (SELECT id FROM tbl_employees WHERE email_internal = 'jane.smith@company.com'), (SELECT id FROM tbl_invoices WHERE people_participating = 3), '2024-03-01');

-- Mock Data for tbl_residences
INSERT INTO tbl_residences (id, type, address, name, details) VALUES
(NEWID(), 1, dbo.fn_GetAddressByStreetAndNumber('Main Street','123'), 'Grand Hotel', 'Luxurious hotel with all amenities'),
(NEWID(), 2, dbo.fn_GetAddressByStreetAndNumber(N'Champs-Élysées','789'), 'Camping Paradise', 'Nature-friendly camping site'),
(NEWID(), 3, dbo.fn_GetAddressByStreetAndNumber('Rambla','1011'), 'City Apartment', 'Cozy apartment in the heart of the city');

-- Mock Data for tbl_transportation
INSERT INTO tbl_transportation (id, type, name, details, inbound_invoice) VALUES
(NEWID(), 1, 'Flight XYZ123', 'Direct flight to destination', (SELECT id FROM tbl_invoices WHERE amount_total_inbound_invoices_pretax = 500)),
(NEWID(), 2, 'Eurostar Train', 'Comfortable train journey', (SELECT id FROM tbl_invoices WHERE amount_total_inbound_invoices_pretax = 200));

-- Mock Data for tbl_point_of_interest
INSERT INTO tbl_point_of_interest (id, name, details, poi_type, address) VALUES
(NEWID(), 'Museum of Art', 'Exquisite art collection', 1, dbo.fn_GetAddressByStreetAndNumber('Main Street', '123')),
(NEWID(), 'City Park', 'Beautiful park for relaxation', 2, dbo.fn_GetAddressByStreetAndNumber(N'Champs-Élysées','789')),
(NEWID(), 'Sagrada Familia', 'Architectural marvel', 3, dbo.fn_GetAddressByStreetAndNumber('Rambla','1011'));

-- Mock Data for tbl_inbound_invoices
INSERT INTO tbl_inbound_invoices (id, invoice_file, amount) VALUES
(NEWID(), NULL, 500),
(NEWID(), NULL, 200),
(NEWID(), NULL, 800);

-- Mock Data for conn_inbound_invoice_status
INSERT INTO conn_inbound_invoice_status (id, invoice, status, created) VALUES
(1, (SELECT id FROM tbl_inbound_invoices WHERE amount = 500), 1, GETDATE()),
(2, (SELECT id FROM tbl_inbound_invoices WHERE amount = 200), 1, GETDATE()),
(3, (SELECT id FROM tbl_inbound_invoices WHERE amount = 800), 1, GETDATE());

-- Mock Data for tbl_itinerary_items
DECLARE @ITINERARY1 UNIQUEIDENTIFIER = newid();
DECLARE @ITINERARY2 UNIQUEIDENTIFIER = newid();

INSERT INTO tbl_itinerary_items (id, travelgroup, departure_time, arrival_time, departure_location, arrival_location) VALUES
( @ITINERARY1, (SELECT TOP 1 id FROM tbl_travelgroups WHERE group_created >= '2024-02-15' ORDER BY group_created), '2024-02-01 09:00:00', '2024-02-01 12:00:00', dbo.fn_GetAddressByStreetAndNumber('Main Street','123'), dbo.fn_GetAddressByStreetAndNumber(N'Champs-Élysées','789')),
( @ITINERARY2, (SELECT TOP 1 id FROM tbl_travelgroups WHERE group_created >= '2024-03-01' ORDER BY group_created), '2024-03-01 10:00:00', '2024-03-01 14:00:00', dbo.fn_GetAddressByStreetAndNumber('Rambla','1011'), dbo.fn_GetAddressByStreetAndNumber('Main Street','123'));

-- Mock Data for tbl_transportation
DECLARE @TRANSPORT1 UNIQUEIDENTIFIER = newid();
DECLARE @TRANSPORT2 UNIQUEIDENTIFIER = newid();
INSERT INTO tbl_transportation (id, type, name, details, inbound_invoice) VALUES
(@TRANSPORT1, 1, 'Flight ABC456', 'Connecting flight with layover', (SELECT id FROM tbl_inbound_invoices WHERE amount = 800)),
(@TRANSPORT2, 3, 'Bus Tour', 'Scenic bus tour of the city', (SELECT id FROM tbl_inbound_invoices WHERE amount = 200));

-- Mock Data for tbl_residences
DECLARE @RESIDENCE1 UNIQUEIDENTIFIER = newid();
DECLARE @RESIDENCE2 UNIQUEIDENTIFIER = newid();

INSERT INTO tbl_residences (id, type, address, name, details) VALUES
(@RESIDENCE1, 1, dbo.fn_GetAddressByStreetAndNumber('Rambla','1011'), 'Luxury Hotel', 'Five-star hotel with spa and fine dining'),
(@RESIDENCE2, 2, dbo.fn_GetAddressByStreetAndNumber('Main Street','123'), 'Riverside Campsite', 'Campsite with beautiful views of the river');

-- Mock Data for tbl_point_of_interest
INSERT INTO tbl_point_of_interest (id, name, details, poi_type, address) VALUES
(NEWID(), 'National Museum', 'Historical artifacts and exhibits', 1, dbo.fn_GetAddressByStreetAndNumber(N'Champs-Élysées','789')),
(NEWID(), 'City Zoo', 'Wildlife and conservation focus', 2, dbo.fn_GetAddressByStreetAndNumber('Main Street','123'));

-- Mock Data for conn_itinerary_poi
INSERT INTO conn_itinerary_poi (id, itinerary, poi, inbound_invoice) VALUES
(
  0,
  (SELECT TOP 1 id FROM tbl_itinerary_items WHERE travelgroup = @TRAVELGROUP1),
  (SELECT TOP 1 id FROM tbl_point_of_interest WHERE name = 'National Museum'),
  (SELECT TOP 1 id FROM tbl_inbound_invoices WHERE amount = 500)
),
(
  1,
  (SELECT TOP 1 id FROM tbl_itinerary_items WHERE travelgroup = @TRAVELGROUP2),
  (SELECT TOP 1 id FROM tbl_point_of_interest WHERE name = 'City Zoo'),
  (SELECT TOP 1 id FROM tbl_inbound_invoices WHERE amount = 200)
);
    -- Mock Data for conn_travelgroup_itinerary_residence
INSERT INTO conn_travelgroup_itinerary_residence (id, itinerary, residence, inbound_invoice) VALUES
(4,  @ITINERARY1,@RESIDENCE1, NULL),
(5,  @ITINERARY2,@RESIDENCE2, (SELECT id FROM tbl_inbound_invoices WHERE amount = 1200));

-- Mock Data for tbl_person_has_made_payment_types
INSERT INTO tbl_person_has_made_payment_types (id, name) VALUES
(1, 'Deposit'),
(2, 'Final Payment');

INSERT INTO conn_people_in_travelgroup (id, travelgroup, customer) VALUES
(1, @TRAVELGROUP1, dbo.fn_GetCustomerIdByUsername('john_doe')),
(2, @TRAVELGROUP1, dbo.fn_GetCustomerIdByUsername('alice_j')),
(3, @TRAVELGROUP2, dbo.fn_GetCustomerIdByUsername('bob_smith'));

-- Mock Data for conn_person_has_made_payment
INSERT INTO conn_person_has_made_payment (id, person_in_travelgroup, payment, type) VALUES
(1, (SELECT id FROM conn_people_in_travelgroup WHERE customer = dbo.fn_GetCustomerIdByUsername('alice_j')), (SELECT id FROM tbl_payments WHERE amount = 1500), 2),
(2, (SELECT id FROM conn_people_in_travelgroup WHERE customer = dbo.fn_GetCustomerIdByUsername('bob_smith')), (SELECT id FROM tbl_payments WHERE amount = 2000), 1);


-- Mock Data for conn_itineray_transport
INSERT INTO conn_itinerary_transport (id, itinerary, transport_id) VALUES
(1, (SELECT TOP 1 id FROM tbl_itinerary_items WHERE travelgroup = @TRAVELGROUP1), @TRANSPORT1),
(2, (SELECT TOP 1 id FROM tbl_itinerary_items WHERE travelgroup = @TRAVELGROUP2), @TRANSPORT2);

