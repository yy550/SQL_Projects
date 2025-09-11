CREATE DATABASE propertyManagement;
USE propertyManagement;

CREATE TABLE STAFF
(
  SMemberID INT NOT NULL,
  SMemberName VARCHAR(100) NOT NULL,
  PRIMARY KEY (SMemberID)
);

INSERT INTO Staff (SMemberID, SMemberName)
VALUES
(1, 'Mario Romero'),
(2, 'Emily Stone'),
(3, 'Jessie Gamez'),
(4, 'David Harris'),
(5, 'Olivia Evans'),
(6, 'James Anderson'),
(7, 'Sophia Turner'),
(8, 'Liam Bennett'),
(9, 'Chloe Martinez'),
(10, 'Noah Brooks');


-- Create INSPECTOR table populated
CREATE TABLE INSPECTOR
(
  InspectorID INT NOT NULL,
  InspectorName VARCHAR(100) NOT NULL,
  PRIMARY KEY (InspectorID)
);

INSERT INTO Inspector (InspectorID, InspectorName)
VALUES
(1, 'Kyle Clark'),
(2, 'Erik Martinez'),
(3, 'Donna Perry'),
(4, 'Liam Green'),
(5, 'Mia Davis'),
(6, 'Lucas White'),
(7, 'Grace Lewis'),   
(8, 'Ethan Reed'),     
(9, 'Zoe Carter'),
(10, 'Henry Scott');

-- Create MREQUEST table
CREATE TABLE MREQUEST
(
  RequestID INT NOT NULL,
  Description TEXT NOT NULL,
  Status VARCHAR(50) NOT NULL,
  SMemberID INT NOT NULL,
  PRIMARY KEY (RequestID),
  FOREIGN KEY (SMemberID) REFERENCES STAFF(SMemberID)
  
);

INSERT INTO MREQUEST (RequestID, Description, Status, SMemberID)
VALUES
(1, 'Fix leaky faucet in kitchen', 'Completed', 1),
(2, 'Repair HVAC system in apartment', 'In Progress', 2),
(3, 'Replace broken window in living room', 'Pending', 3),
(4, 'Repaint apartment walls', 'Completed', 4),
(5, 'Fix electrical issue in bedroom', 'Pending', 5),
(6, 'Inspect plumbing system', 'Completed', 6),
(7, 'Replace light bulbs in hallway', 'In Progress', 7),
(8, 'Fix broken door lock', 'Completed', 8),
(9, 'Clean dryer vent', 'Pending', 9),
(10, 'Repair damaged flooring in hallway', 'In Progress', 10);

-- Create MANAGER table
CREATE TABLE MANAGER
(
  MID INT NOT NULL,
  MFirstName VARCHAR(100) NOT NULL,
  MLastName VARCHAR(100) NOT NULL,
  MSalary INT NOT NULL,
  MBonus INT,
  MBDate DATE NOT NULL,
  BuildingID INT NOT NULL,
  PRIMARY KEY (MID)
);

-- Insert data into MANAGER table
INSERT INTO MANAGER (MID, MFirstName, MLastName, MBDate, MSalary, MBonus, BuildingID)
VALUES
(100, 'Alice', 'Smith', '1990-04-12', 75000, 5000, 30),
(101, 'Robert', 'Smith', '1985-06-23', 80000, 5500, 31),
(102, 'Karen', 'Williams', '1992-08-15', 72000, 4500, 32),
(103, 'Daniel', 'Martinez', '1998-02-19', 77000, 5200, 33),
(104, 'Jessica', 'Brown', '1995-12-01', 76000, 4800, 34),
(105, 'Steven', 'Lopez', '1987-09-10', 81000, 6000, 35),
(106, 'Laura', 'Hernandez', '1993-03-25', 74000, 4700, 36),
(107, 'Christopher', 'Garcia', '1991-05-05', 79000, 5300, 37),
(108, 'Patricia', 'Lee', '1979-07-17', 73000, 4600, 38),
(109, 'Anthony', 'Walker', '1988-1-22', 76000, 4550, 39);


-- Create BUILDING table
CREATE TABLE BUILDING
(
  BuildingID INT NOT NULL,
  BNoOfFloors INT NOT NULL,
  MID INT NOT NULL,
  PRIMARY KEY (BuildingID),
  CONSTRAINT fk_building_manager FOREIGN KEY (MID) REFERENCES MANAGER(MID)

);

-- Insert data into BUILDING table
INSERT INTO BUILDING (BuildingID, BNoOfFloors, MID)
VALUES
(30, 5, 100),
(31, 7, 101),
(32, 10, 102),
(33, 3, 103),
(34, 8, 104),
(35, 6, 105),
(36, 4, 106),
(37, 9, 107),
(38, 12, 108),
(39, 11, 109);

-- Adds the foreign key back into manager 
ALTER TABLE MANAGER
ADD CONSTRAINT fk_manager_building FOREIGN KEY (BuildingID) REFERENCES BUILDING(BuildingID);

-- Create CORPORATE CLIENT table
CREATE TABLE CORPCLIENT
(
  CCID INT NOT NULL,
  CCName VARCHAR(100) NOT NULL,
  CCIndustry VARCHAR(100) NOT NULL,
  CCLocation VARCHAR(100) NOT NULL,
  Refers_CCID INT,
  PRIMARY KEY (CCID),
  UNIQUE (CCName)
);

-- Insert data into CORPORATE CLIENT table
INSERT INTO CORPCLIENT (CCID, CCName, CCIndustry, CCLocation, Refers_CCID)
VALUES
(1, 'Tech Solutions Inc.', 'Technology', 'New York, USA', 3),
(2, 'Green Energy Ltd.', 'Energy', 'San Francisco, USA', 1),
(3, 'HealthCare Partners', 'Healthcare', 'Chicago, USA', 1),
(4, 'Retail World', 'Retail', 'Los Angeles, USA', 5),
(5, 'Global Logistics', 'Logistics', 'Houston, USA', 3),
(6, 'SmartHome Devices', 'Technology', 'Boston, USA', 2),
(7, 'FinTrust Investments', 'Finance', 'Miami, USA', 1),
(8, 'AutoTech Innovations', 'Automotive', 'Detroit, USA', 4),
(9, 'EcoWare Industries', 'Manufacturing', 'Denver, USA', 5),
(10, 'Foodies Delight', 'Food & Beverage', 'Atlanta, USA', 7);

-- Create APARTMENT table
CREATE TABLE APARTMENT
(
  BuildingID INT NOT NULL,
  AptNo INT NOT NULL,
  NoOfBedrooms INT NOT NULL,
  OccupancyStatus VARCHAR(50) NOT NULL,
  CCID INT,
  PRIMARY KEY (BuildingID, AptNo),
  FOREIGN KEY (BuildingID) REFERENCES BUILDING(BuildingID),
  FOREIGN KEY (CCID) REFERENCES CORPCLIENT(CCID)
);

-- Insert data into APARTMENT table
INSERT INTO APARTMENT (BuildingID, AptNo, NoOfBedrooms, OccupancyStatus, CCID)
VALUES
(30, 20, 2, 'Occupied', 1),
(31, 21, 3, 'Unoccupied', 2),
(32, 22, 2, 'Occupied', 3),
(33, 23, 3, 'Unoccupied', 4),
(34, 24, 1, 'Occupied', 5),
(35, 25, 4, 'Occupied', 6),
(36, 26, 3, 'Unoccupied', 7),
(37, 27, 2, 'Occupied', 8),
(38, 28, 3, 'Unoccupied', 9),
(39, 29, 2, 'Occupied', 10);

-- Create TENANT table
CREATE TABLE TENANT
(
  TenantID INT NOT NULL,
  TFirstName VARCHAR(100) NOT NULL,
  TLastName VARCHAR(100) NOT NULL,
  Email VARCHAR(100) NOT NULL,
  SSN VARCHAR(20) NOT NULL,
  Car VARCHAR(50),
  BuildingID INT NOT NULL,
  AptNo INT NOT NULL,
  PRIMARY KEY (TenantID),
  FOREIGN KEY (BuildingID, AptNo) REFERENCES APARTMENT(BuildingID, AptNo),
  UNIQUE (SSN)
);

-- Insert data into TENANT table
INSERT INTO TENANT (TenantID, TFirstName, TLastName, SSN, BuildingID, AptNo, Email, Car)
VALUES
(1, 'John', 'Doe', '111-22-3333', 30, 20, 'john.doe@example.com', 'Yes'),
(2, 'Jane', 'Smith', '222-33-4444', 31, 21,'jane.smith@example.com', 'No'),
(3, 'Alice', 'Johnson', '333-44-5555', 32, 22,'alice.johnson@example.com', 'Yes'),
(4, 'Bob', 'Williams', '444-55-6666', 33, 23,'bob.williams@example.com', 'No'),
(5, 'Charlie', 'Brown', '555-66-7777', 34, 24,'charlie.brown@example.com', 'Yes'),
(6, 'David', 'Wilson', '666-77-8888', 35, 25,'david.wilson@example.com', 'No'),
(7, 'Emma', 'Moore', '777-88-9999', 36, 26,'emma.moore@example.com', 'Yes'),
(8, 'Frank', 'Taylor', '888-99-0000', 37, 27,'frank.taylor@example.com', 'No'),
(9, 'Grace', 'Anderson', '999-00-1111', 38, 28,'grace.anderson@example.com', 'Yes'),
(10, 'Hannah', 'Thomas', '000-11-2222', 39, 29,'hannah.thomas@example.com', 'No');

-- Create LEASE table
CREATE TABLE LEASE
(
  LeaseID INT NOT NULL ,
  MonthlyRent INT NOT NULL,
  SecurityDeposit INT NOT NULL,
  BuildingID INT NOT NULL,
  AptNo INT NOT NULL,
  CCID INT NOT NULL,
  LeaseStartDate DATE NOT NULL,
  LeaseEndDate DATE NOT NULL,
  PRIMARY KEY (LeaseID),
  FOREIGN KEY (BuildingID, AptNo) REFERENCES APARTMENT(BuildingID, AptNo),
  FOREIGN KEY (CCID) REFERENCES CORPCLIENT(CCID)
);

-- Insert data into LEASE table
INSERT INTO LEASE (LeaseID, BuildingID, AptNo, CCID, MonthlyRent, SecurityDeposit,LeaseStartDate,LeaseEndDate)
VALUES
(1, 30, 20, 1, 1500, 3000,'2025-01-01','2025-12-31'),
(2, 31, 21, 2, 1600, 3200,'2025-02-01','2025-12-31'),
(3, 32, 22, 3, 1800, 3600,'2025-03-01','2026-03-01'),
(4, 33, 23, 4, 1700, 3400,'2025-04-01','2026-02-01'),
(5, 34, 24, 5, 2000, 4000,'2025-05-01','2026-04-30'),
(6, 35, 25, 6, 2100, 4200,'2025-06-01','2026-06-30'),
(7, 36, 26, 7, 1400, 2800,'2025-07-01','2026-05-31'),
(8, 37, 27, 8, 1500, 3000,'2025-08-01','2026-08-01'),
(9, 38, 28, 9, 2200, 4400,'2025-09-01','2026-07-01'),
(10, 39, 29, 10, 2500, 5000,'2025-10-01','2026-11-30');



-- Create PAYMENT table
CREATE TABLE PAYMENT
(
  PaymentID INT NOT NULL,
  PaymentAmounT FLOAT(10,2) NOT NULL,
  PaymentDate DATE NOT NULL,
  PaymentStatus VARCHAR(50) NOT NULL,
  PaymentMethod VARCHAR(50) NOT NULL,
  LeaseID INT NOT NULL,
  PRIMARY KEY (PaymentID),
  FOREIGN KEY (LeaseID) REFERENCES LEASE(LeaseID)
);

-- Insert data into PAYMENT table
INSERT INTO PAYMENT (PaymentID, LeaseID, PaymentDate, PaymentAmount, PaymentMethod, PaymentStatus)
VALUES
(1, 1, '2025-03-01', 1500, 'Credit Card', 'Completed'),
(2, 2, '2025-03-05', 1600, 'Bank Transfer', 'Completed'),
(3, 3, '2025-03-10', 1800, 'Cash', 'Pending'),
(4, 4, '2025-03-12', 1700, 'Credit Card', 'Completed'),
(5, 5, '2025-03-15', 2000, 'Bank Transfer', 'Completed'),
(6, 6, '2025-03-18', 2100, 'Credit Card', 'Pending'),
(7, 7, '2025-03-20', 1400, 'Cash', 'Completed'),
(8, 8, '2025-03-22', 1500, 'Bank Transfer', 'Completed'),
(9, 9, '2025-03-25', 2200, 'Credit Card', 'Completed'),
(10, 10, '2025-03-28', 2500, 'Cash', 'Failed');

-- Create REFERS table (Associative Entity)
CREATE TABLE REFERS
(
  CCID_1 INT, -- Referring CorpClient (make sure this matches the data type of CCID in CORPCLIENT) Maybe change name 
  CCID_2 INT NOT NULL, -- Referred CorpClient maybe change name 
  PRIMARY KEY (CCID_1, CCID_2),
  CONSTRAINT fk_refers_referring FOREIGN KEY (CCID_1) REFERENCES CORPCLIENT(CCID),
  CONSTRAINT fk_refers_referred FOREIGN KEY (CCID_2) REFERENCES CORPCLIENT(CCID)
);

INSERT INTO REFERS (CCID_1, CCID_2)
VALUES
(1, 2),
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10);

-- Create REQUESTS table (Associative Entity) junction table possible name change 
CREATE TABLE REQUESTS
(
  BuildingID INT NOT NULL,
  AptNo INT NOT NULL,
  RequestID INT NOT NULL, 
  RequestDate DATE, 
  PRIMARY KEY (BuildingID, AptNo, RequestID),
  CONSTRAINT fk_requests_apartment FOREIGN KEY (BuildingID, AptNo) REFERENCES APARTMENT(BuildingID, AptNo),
  CONSTRAINT fk_requests_request FOREIGN KEY (RequestID) REFERENCES MREQUEST(RequestID)
);
INSERT INTO REQUESTS (BuildingID, AptNo, RequestID, RequestDate)
VALUES
(30, 20, 1, '2025-03-01'),
(31, 21, 2, '2025-03-05'),
(32, 22, 3, '2025-03-10'),
(33, 23, 4, '2025-03-12'),
(34, 24, 5, '2025-03-15'),
(35, 25, 6, '2025-03-18'),
(36, 26, 7, '2025-03-20'),
(37, 27, 8, '2025-03-22'),
(38, 28, 9, '2025-03-25'),
(39, 29, 10, '2025-03-28');

CREATE INDEX idx_apartment_aptno ON APARTMENT(AptNo);
ALTER TABLE APARTMENT ADD UNIQUE(AptNo);

-- Create CLEANS table (Associative Entity), junction 
CREATE TABLE CLEANS
(
  BuildingID INT, 
  AptNo INT,
  SMemberID INT, 
  PRIMARY KEY (BuildingID, AptNo, SMemberID),
  CONSTRAINT fk_cleans_apartment FOREIGN KEY (AptNo) REFERENCES APARTMENT(AptNo),
  CONSTRAINT fk_cleans_building FOREIGN KEY (BuildingID) REFERENCES BUILDING(BuildingID),
  CONSTRAINT fk_cleans_staff FOREIGN KEY (SMemberID) REFERENCES STAFF(SMemberID)
);
INSERT INTO CLEANS (BuildingID, AptNo, SMemberID)
VALUES
(30, 20, 1),
(31, 21, 2),
(32, 22, 3),
(33, 23, 4),
(34, 24, 5),
(35, 25, 6),
(36, 26, 7),
(37, 27, 8),
(38, 28, 9),
(39, 29, 10);


CREATE TABLE INSPECTS
(
  InspectorID INT, 
  BuildingID INT, 
  DateLast DATE NOT NULL,
  DateNext DATE NOT NULL,
  PRIMARY KEY (InspectorID, BuildingID),
  CONSTRAINT fk_inspects_inspector FOREIGN KEY (InspectorID) REFERENCES INSPECTOR(InspectorID),
  CONSTRAINT fk_inspects_building FOREIGN KEY (BuildingID) REFERENCES BUILDING(BuildingID)
);
INSERT INTO INSPECTS (InspectorID, BuildingID, DateLast, DateNext)
VALUES
(1, 30, '2025-01-01', '2025-07-01'),
(2, 31, '2025-02-01', '2025-08-01'),
(3, 32, '2025-03-01', '2025-09-01'),
(4, 33, '2025-04-01', '2025-10-01'),
(5, 34, '2025-05-01', '2025-11-01'),
(6, 35, '2025-06-01', '2025-12-01'),
(7, 36, '2025-07-01', '2026-01-01'),
(8, 37, '2025-08-01', '2026-02-01'),
(9, 38, '2025-09-01', '2026-03-01'),
(10, 39, '2025-10-01', '2026-04-01');

CREATE TABLE TENANT_TContactInfo
(
  TenantID INT NOT NULL, 
  TContactInfo VARCHAR(255) NOT NULL, 
  PRIMARY KEY (TenantID, TContactInfo), 
  CONSTRAINT fk_tenant_contact FOREIGN KEY (TenantID) REFERENCES TENANT(TenantID)
);
INSERT INTO TENANT_TContactInfo (TenantID, TContactInfo)
VALUES
(1, '555-1234 (Emergency Contact)'),
(2, '555-5678 (Emergency Contact)'),
(3, '555-9876 (Emergency Contact)'),
(4, '555-4321 (Emergency Contact)'),
(5, '555-8765 (Emergency Contact)'),
(6, '555-6789 (Emergency Contact)'),
(7, '555-3456 (Emergency Contact)'),
(8, '555-2345 (Emergency Contact)'),
(9, '555-5432 (Emergency Contact)'),
(10, '555-3210 (Emergency Contact)');

CREATE TABLE MANAGER_MContactInfo
(
  MID INT NOT NULL, -- Manager identifier (Foreign Key)
  MContactInfo VARCHAR(255) NOT NULL, -- Manager Contact Information
  PRIMARY KEY (MID, MContactInfo), -- Composite primary key
  CONSTRAINT fk_manager_contact FOREIGN KEY (MID) REFERENCES MANAGER(MID)
);
INSERT INTO MANAGER_MContactInfo (MID, MContactInfo)
VALUES
(100, '555-0001 (Office)'),
(101, '555-0002 (Office)'),
(102, '555-0003 (Office)'),
(103, '555-0004 (Office)'),
(104, '555-0005 (Office)'),
(105, '555-0006 (Office)'),
(106, '555-0007 (Office)'),
(107, '555-0008 (Office)'),
(108, '555-0009 (Office)'),
(109, '555-0010 (Office)');

CREATE TABLE Submits
(
  TenantID INT NOT NULL, -- Tenant identifier (Foreign Key)
  RequestID INT NOT NULL, -- Maintenance Request identifier (Foreign Key)
  PRIMARY KEY (TenantID, RequestID), -- Composite primary key
  CONSTRAINT fk_submits_request FOREIGN KEY (RequestID) REFERENCES MREQUEST(RequestID),
  CONSTRAINT fk_submits_tenant FOREIGN KEY (TenantID) REFERENCES TENANT(TenantID)
);

INSERT INTO SUBMITS (TenantID, RequestID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

CREATE TABLE SIGNS
(
  TenantID INT NOT NULL,
  LeaseID INT NOT NULL,
  PRIMARY KEY (TenantID, LeaseID),
  FOREIGN KEY (TenantID) REFERENCES TENANT(TenantID),
  FOREIGN KEY (LeaseID) REFERENCES LEASE(LeaseID)
);

INSERT INTO SIGNS (TenantID, LeaseID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);




















