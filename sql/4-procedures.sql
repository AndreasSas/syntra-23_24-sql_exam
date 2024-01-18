USE AndreasVacations;
GO

-- prod 1
CREATE PROCEDURE sp_GetCustomerByUsername
    @Username NVARCHAR(16)
AS
BEGIN
    SELECT *
    FROM tbl_customers c
    JOIN tbl_people p ON c.person = p.id
    WHERE c.username = @Username;
END;
GO


-- prod 2
CREATE PROCEDURE sp_GetTravelGroupDetails
    @TravelGroupID UNIQUEIDENTIFIER
AS
BEGIN
    SELECT *
    FROM tbl_travelgroups tg
    JOIN conn_people_in_travelgroup c ON tg.id = c.travelgroup
    JOIN tbl_customers cu ON c.customer = cu.id
    WHERE tg.id = @TravelGroupID;
END;
GO

-- prod 3
CREATE PROCEDURE sp_GetCustomersWithEmails
AS
BEGIN
    SELECT c.id AS CustomerID, c.username, p.name_first, p.name_last, ce.email
    FROM tbl_customers c
    JOIN tbl_people p ON c.person = p.id
    JOIN tbl_customer_emails ce ON c.id = ce.customer;
END;