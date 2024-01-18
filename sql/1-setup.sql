------------------------------------------------------------------------------------------------------------------------
-- Select Schema
------------------------------------------------------------------------------------------------------------------------
USE AndreasVacations;

------------------------------------------------------------------------------------------------------------------------
-- Addresses
------------------------------------------------------------------------------------------------------------------------
-- COUNTRIES
CREATE TABLE tbl_countries_iso3166 (
    id NVARCHAR(3) PRIMARY KEY NOT NULL ,
    name_nl NVARCHAR(64) UNIQUE NOT NULL ,
);

-- TOWNS
CREATE TABLE tbl_towns (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    country NVARCHAR(3) NOT NULL FOREIGN KEY REFERENCES tbl_countries_iso3166(id),
    state NVARCHAR(64) NOT NULL,
    town_name NVARCHAR(64) NOT NULL,
    town_postalcode NVARCHAR(12)
);

-- ADDRESSES
CREATE TABLE tbl_addresses (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    town UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_towns(id),
    street NVARCHAR(128) NOT NULL,
    house_number NVARCHAR(12) NOT NULL
);

------------------------------------------------------------------------------------------------------------------------
-- PEOPLE
------------------------------------------------------------------------------------------------------------------------

-- TELEPHONE TYPES
CREATE TABLE tbl_telephone_types (
    id INT PRIMARY KEY NOT NULL,
    name NVARCHAR(8) UNIQUE NOT NULL
);

-- PEOPLE
CREATE TABLE tbl_people (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    name_first NVARCHAR(64) NOT NULL,
    name_middle NVARCHAR(64),
    name_last NVARCHAR(64) NOT NULL,
    date_of_birth DATETIME NOT NULL,
    ssn NVARCHAR(64) UNIQUE NOT NULL,
    passport_number NVARCHAR(64) UNIQUE NOT NULL
);

------------------------------------------------------------------------------------------------------------------------
-- CUSTOMER
------------------------------------------------------------------------------------------------------------------------
-- CUSTOMER
CREATE TABLE tbl_customers (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    username NVARCHAR(16) UNIQUE NOT NULL,
    password NVARCHAR(128) NOT NULL, -- hashed password
    person UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_people(id)
);

-- CUSTOMER EMAILS
CREATE TABLE tbl_customer_emails (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    customer UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_customers(id),
    email NVARCHAR(64) NOT NULL,
    allow_marketing BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_CUSTOMER_EMAIL UNIQUE (customer, email)
);

-- CUSTOMER TELEPHONE
CREATE TABLE tbl_customer_telephones (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    customer UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_customers(id) ,
    type INT NOT NULL FOREIGN KEY REFERENCES tbl_telephone_types(id),
    number NVARCHAR(12) NOT NULL,
    allow_marketing BIT NOT NULL DEFAULT 1
);

------------------------------------------------------------------------------------------------------------------------
-- EMPLOYEE
------------------------------------------------------------------------------------------------------------------------
-- EMPLOYEE
CREATE TABLE tbl_employees (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    person UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tbl_people(id) UNIQUE NOT NULL,
    is_sales BIT,
    is_supervisor BIT,
    is_manager BIT,
    email_internal NVARCHAR(64) NOT NULL
);
------------------------------------------------------------------------------------------------------------------------
-- PAYMENT SYSTEM
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE tbl_payment_types (
    id INT PRIMARY KEY NOT NULL,
    name NVARCHAR(16) UNIQUE NOT NULL
);

CREATE TABLE tbl_invoice_status_types (
    id INT PRIMARY KEY NOT NULL,
    name NVARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE tbl_invoices (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    created DATETIME NOT NULL,
    var_percentage FLOAT NOT NULL,
    amount_total_inbound_invoices_pretax INT NOT NULL,
    service_fee INT NOT NULL,
    people_participating INT NOT NULL,
    sale_made_by UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_employees(id)
);

CREATE TABLE tbl_payments (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    invoice UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_invoices(id),
    datetime DATETIME NOT NULL,
    amount INT NOT NULL,
    paymentdata NVARCHAR(MAX),
    payment_type INT NOT NULL FOREIGN KEY REFERENCES tbl_payment_types(id)
);

CREATE TABLE tbl_invoice_status (
    id INT PRIMARY KEY NOT NULL,
    invoice UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_invoices(id),
    status INT NOT NULL FOREIGN KEY REFERENCES tbl_invoice_status_types(id),
    created DATETIME NOT NULL
);

------------------------------------------------------------------------------------------------------------------------
-- TRAVEL GROUP SYSTEM
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE tbl_travelgroups (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    supervisor UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_employees(id) ,
    invoice UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_invoices(id) UNIQUE,
    group_created DATETIME NOT NULL
);

CREATE TABLE conn_people_in_travelgroup (
    id INT PRIMARY KEY NOT NULL,
    travelgroup UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_travelgroups(id) ,
    customer UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_customers(id),
    CONSTRAINT UQ_Travelgroup_Customer UNIQUE (travelgroup, customer)
);

CREATE TABLE tbl_person_has_made_payment_types (
    id INT PRIMARY KEY NOT NULL,
    name NVARCHAR(16) UNIQUE NOT NULL
);

CREATE TABLE conn_person_has_made_payment (
    id INT PRIMARY KEY NOT NULL,
    person_in_travelgroup INT NOT NULL FOREIGN KEY REFERENCES conn_people_in_travelgroup(id),
    payment UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_payments(id) ,
    type INT NOT NULL FOREIGN KEY REFERENCES tbl_person_has_made_payment_types(id)
);
------------------------------------------------------------------------------------------------------------------------
-- INBOUND INVOICES
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE tbl_inbound_invoices (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    invoice_file VARBINARY(MAX), -- Removed FILESTREAM
    amount INT NOT NULL
);

CREATE TABLE tbl_inbound_invoice_status_types (
    id INT PRIMARY KEY NOT NULL,
    name NVARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE conn_inbound_invoice_status (
    id INT PRIMARY KEY NOT NULL,
    invoice UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_inbound_invoices(id),
    status INT NOT NULL FOREIGN KEY REFERENCES tbl_invoice_status_types(id),
    created DATETIME NOT NULL
);

------------------------------------------------------------------------------------------------------------------------
-- ITINERARY SYSTEM
------------------------------------------------------------------------------------------------------------------------
CREATE TABLE tbl_itinerary_items (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    travelgroup UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_travelgroups(id),
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    departure_location UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_addresses(id),
    arrival_location UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_addresses(id)
);

-- Residences
CREATE TABLE tbl_residence_types (
    id INT PRIMARY KEY NOT NULL,
    name NVARCHAR(16) UNIQUE NOT NULL
);

CREATE TABLE tbl_residences (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    type INT NOT NULL FOREIGN KEY REFERENCES tbl_residence_types(id),
    address UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_addresses(id),
    name NVARCHAR(128) NOT NULL,
    details NVARCHAR(MAX),
    CONSTRAINT UQ_Residence_Address_Name UNIQUE (address, name)
);

CREATE TABLE conn_travelgroup_itinerary_residence (
    id INT PRIMARY KEY NOT NULL,
    itinerary UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_itinerary_items(id),
    residence UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_residences(id),
    inbound_invoice UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tbl_inbound_invoices(id) -- a free camping ground, doesn't have a payment
);

-- Transport
CREATE TABLE tbl_transportation_types (
    id INT PRIMARY KEY NOT NULL,
    name NVARCHAR(8) UNIQUE NOT NULL
);

CREATE TABLE tbl_transportation (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    type INT NOT NULL FOREIGN KEY REFERENCES tbl_transportation_types(id),
    name VARCHAR(64) NOT NULL,
    details VARCHAR(MAX),
    inbound_invoice UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tbl_inbound_invoices(id) -- on foor doesn't have a payment
);

CREATE TABLE conn_itinerary_transport (
    id INT PRIMARY KEY NOT NULL,
    itinerary UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_itinerary_items(id),
    transport_id UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_transportation(id)
);

-- POI
CREATE TABLE tbl_poi_type (
    id INT PRIMARY KEY NOT NULL,
    name NVARCHAR(24) UNIQUE NOT NULL
);

CREATE TABLE tbl_point_of_interest (
    id UNIQUEIDENTIFIER PRIMARY KEY NOT NULL,
    name NVARCHAR(128) NOT NULL,
    details NVARCHAR(255),
    poi_type INT NOT NULL FOREIGN KEY REFERENCES tbl_poi_type(id),
    address UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_addresses(id) ,
    CONSTRAINT UQ_Poi_Name UNIQUE (name, address)
);

CREATE TABLE conn_itinerary_poi (
    id INT PRIMARY KEY NOT NULL,
    itinerary UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_itinerary_items(id),
    poi UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES tbl_point_of_interest(id),
    inbound_invoice UNIQUEIDENTIFIER FOREIGN KEY REFERENCES tbl_inbound_invoices(id) -- can be null, as a single statue for example is free
);