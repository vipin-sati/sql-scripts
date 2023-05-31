--Stage 1
CREATE TABLE BuildingDetails (
	building_id INT PRIMARY KEY IDENTITY(1,1),
	building_name VARCHAR(100),
)
CREATE TABLE TenantDetails (
	tenant_id INT PRIMARY KEY IDENTITY(1,1),
	tenant_name VARCHAR(100),
)
CREATE TABLE BuildingTenants (
    building_tenant_id INT PRIMARY KEY IDENTITY(1,1),
    building_id INT,
    tenant_id INT,
    start_date DATETIME2,
    end_date DATETIME2,
	CONSTRAINT FK_BuildingTenants_BuildingDetails FOREIGN KEY (building_id) REFERENCES BuildingDetails (building_id),
	CONSTRAINT FK_BuildingTenants_TenantDetails FOREIGN KEY (tenant_id) REFERENCES TenantDetails (tenant_id)
)

--Stage 2
CREATE TABLE ApartmentGuests (
    apartment_guest_id INT PRIMARY KEY IDENTITY(1,1),
    entry_date DATETIME2,
	exit_date DATETIME2,
    apartment_number VARCHAR(10),
    guest_count INT
)

SELECT COUNT(tenant_id) AS total_tenants
FROM BuildingTenants bt INNER JOIN BuildingDetails b ON b.building_id = bt.building_id
WHERE bt.end_date >= GETDATE()

SELECT SUM(guest_count) AS total_guests 
FROM BuildingDetails b INNER JOIN ApartmentGuests ag ON b.building_name = ag.apartment_number
WHERE ag.exit_date >= GETDATE()
