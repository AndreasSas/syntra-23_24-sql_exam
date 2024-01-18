USE AndreasVacations;
GO

CREATE FUNCTION fn_GetItineraryResidences()
RETURNS TABLE
AS
RETURN
(
    SELECT ti.id AS ItineraryID, r.name AS ResidenceName, r.details AS ResidenceDetails
    FROM tbl_itinerary_items ti
    LEFT JOIN conn_travelgroup_itinerary_residence ctir ON ti.id = ctir.itinerary
    LEFT JOIN tbl_residences r ON ctir.residence = r.id
);
GO

CREATE FUNCTION fn_GetCustomersWithMarketingPreference()
RETURNS TABLE
AS
RETURN
(
    SELECT c.id AS CustomerID, c.username, p.name_first, p.name_last, ce.email
    FROM tbl_customers c
    JOIN tbl_people p ON c.person = p.id
    JOIN tbl_customer_emails ce ON c.id = ce.customer
    WHERE ce.allow_marketing = 1
);
GO

CREATE FUNCTION fn_GetPeopleWithPaymentsInTravelGroup
(
    @TravelGroupID UNIQUEIDENTIFIER
)
RETURNS TABLE
AS
RETURN
(
    SELECT p.name_first, p.name_last, phpmt.name AS PaymentType
    FROM conn_people_in_travelgroup cpit
    JOIN tbl_people p ON cpit.customer = p.id
    JOIN conn_person_has_made_payment phmp ON cpit.id = phmp.person_in_travelgroup
    JOIN tbl_person_has_made_payment_types phpmt ON phmp.type = phpmt.id
    WHERE cpit.travelgroup = @TravelGroupID
);
GO

--
CREATE FUNCTION fn_GetCityId(
    @CityName nvarchar
)
returns uniqueidentifier
AS
BEGIN
    DECLARE @CityId uniqueidentifier

    SELECT TOP 1 @CityId = id
    FROM tbl_towns
    WHERE town_name LIKE '%' + @CityName + '%'

    RETURN @CityId
END;
GO

--
CREATE FUNCTION fn_GetPersonBySSN(
    @SSN nvarchar
)
returns uniqueidentifier
AS
BEGIN
    DECLARE @PersonId uniqueidentifier

    SELECT TOP 1 @PersonId = id
    FROM tbl_people
    WHERE ssn LIKE '%' + @SSN + '%'

    RETURN @PersonId
END;
GO

--
CREATE FUNCTION fn_GetCustomerIdByUsername(
    @Username nvarchar(16)
)
RETURNS uniqueidentifier
AS
BEGIN
    DECLARE @CustomerId uniqueidentifier

    SELECT TOP 1 @CustomerId = id
    FROM tbl_customers

    WHERE username = @Username

    RETURN @CustomerId
END
GO

--
CREATE FUNCTION fn_GetAddressByStreetAndNumber(
    @Street nvarchar,
    @HouseNumber nvarchar
)
returns uniqueidentifier
AS
BEGIN
    DECLARE @AddressId uniqueidentifier

    SELECT TOP 1 @AddressId =id
    FROM tbl_addresses
    WHERE street LIKE '%' + @Street + '%' AND house_number LIKE '%' + @HouseNumber + '%'

    RETURN @AddressId
END;
GO