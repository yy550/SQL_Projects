-- 1. Which apartments are associated with security deposits over $1,000?
SELECT BuildingID, AptNo, SecurityDeposit
FROM LEASE
WHERE SecurityDeposit > 1000;

-- 2. What is the average number of bedrooms per building?
SELECT BuildingID, ROUND(AVG(NoOfBedrooms)) AS AvgBedrooms
FROM APARTMENT
GROUP BY BuildingID;

-- 3. Retrieve the name of the corporate client and the client who reffered them.
SELECT c1.CCID, c1.CCName AS Recommender, 
       c1.Refers_CCID AS RecommendedCCID, 
       c2.CCName AS ReccomendedCCName
FROM CORPCLIENT c1
JOIN CORPCLIENT c2 ON c1.Refers_CCID = c2.CCID
WHERE c1.Refers_CCID IS NOT NULL;

-- 4. Which corporate client has referred the most clients?
SELECT r.CCID AS ReferrerID, r.CCName AS ReferrerName, 
       COUNT(c.CCID) AS NumberOfReferrals,
       GROUP_CONCAT(DISTINCT c.CCName SEPARATOR ', ') AS ReferredClients
FROM CORPCLIENT c
LEFT JOIN CORPCLIENT r ON c.Refers_CCID = r.CCID
WHERE c.Refers_CCID IS NOT NULL
GROUP BY r.CCID, r.CCName
ORDER BY NumberOfReferrals DESC
LIMIT 3;

-- 5. Which building has the most floors?
SELECT BuildingID, BNoOfFloors
FROM BUILDING
ORDER BY BNoOfFloors DESC
LIMIT 5;

-- 6. When was the last inspection conducted by each inspector?
SELECT INS.InspectorID, INS.InspectorName,
       I.BuildingID, I.DateLast
FROM INSPECTOR INS
JOIN INSPECTS I ON INS.InspectorID = I.InspectorID
WHERE I.DateLast = (
    SELECT MAX(DateLast)
    FROM INSPECTS
    WHERE InspectorID = INS.InspectorID)
ORDER BY INS.InspectorID, I.BuildingID;

-- 7. Order the managers with the greatest to least salary earnings.
SELECT MFirstName, MLastName, MSalary, BuildingID
FROM MANAGER 
ORDER BY MSalary DESC;

-- 8. Which maintenance request is completed, and what is the description of the request?
SELECT RequestID, Description, Status
FROM MREQUEST
WHERE Status = 'Completed';

-- 9. How many unoccupied apartments are there in each building, and who is the manager responsible for each building?
SELECT 
    b.BuildingID,
    COALESCE(COUNT(a.AptNo), 0) AS UnoccupiedUnits,
    m.MFirstName AS ManagerFirstName,
    m.MLastName AS ManagerLastName
FROM BUILDING b
LEFT JOIN APARTMENT a ON b.BuildingID = a.BuildingID AND 
    a.OccupancyStatus = 'Unoccupied'
LEFT JOIN MANAGER m ON b.MID = m.MID
GROUP BY b.BuildingID, m.MFirstName, m.MLastName;

-- 10. Tenants who have missed, failed, or have pending payments.
SELECT T.TenantID, T.TFirstName, T.TLastName, 
       P.PaymentStatus, P.PaymentDate
FROM TENANT T
JOIN SIGNS S ON T.TenantID = S.TenantID
JOIN LEASE L ON S.LeaseID = L.LeaseID
JOIN PAYMENT P ON L.LeaseID = P.LeaseID
WHERE P.PaymentStatus IN ('Failed', 'Pending')
ORDER BY P.PaymentDate DESC;

-- 11. Which tenants have made a payment with the 'Credit Card' method and had a payment status of 'Completed'?
SELECT T.TFirstName, T.TLastName, 
       P.PaymentAmount, P.PaymentStatus, P.PaymentMethod
FROM TENANT T
LEFT JOIN SIGNS S ON T.TenantID = S.TenantID
LEFT JOIN LEASE L ON S.LeaseID = L.LeaseID
LEFT JOIN PAYMENT P ON L.LeaseID = P.LeaseID
WHERE P.PaymentMethod = 'Credit Card' 
AND P.PaymentStatus = 'Completed'
ORDER BY P.PaymentAmount;

-- 12. Tenants whose rent is above the average rent of all tenants
SELECT  T.TenantID, T.TFirstName, T.TLastName, L.MonthlyRent
FROM SIGNS S
JOIN TENANT T ON S.TenantID = T.TenantID
JOIN LEASE L ON S.LeaseID = L.LeaseID
WHERE L.MonthlyRent > (SELECT AVG(MonthlyRent) FROM LEASE)
ORDER BY L.MonthlyRent;

-- 13. Which tenants have pending payments that are not marked as failed?
SELECT 
    t.TenantID,
    t.TFirstName,
    t.TLastName,
    p.PaymentID,
    p.PaymentAmount,
    p.PaymentDate,
    p.PaymentStatus,
    l.LeaseID,
    l.MonthlyRent,
    l.LeaseStartDate,
    l.LeaseEndDate
FROM PAYMENT p
JOIN LEASE l ON p.LeaseID = l.LeaseID
JOIN SIGNS s ON l.LeaseID = s.LeaseID
JOIN TENANT t ON s.TenantID = t.TenantID
WHERE p.PaymentStatus = 'Pending';

-- 14. View leasing trends across buildings 
SELECT 
    L.BuildingID,
    YEAR(L.LeaseStartDate) AS Year, 
    COUNT(*) AS LeaseCount
FROM LEASE L
JOIN BUILDING B ON L.BuildingID = B.BuildingID
GROUP BY L.BuildingID, Year
ORDER BY L.BuildingID;

-- 15. Tenants and their logged requests by request date
SELECT 
    T.TenantID,
    T.TFirstName,
    T.TLastName,
    T.BuildingID,
    T.AptNo,
    M.Description,
    M.Status,
    MAX(R.RequestDate) AS LatestRequestDate
FROM MREQUEST M
JOIN REQUESTS R ON M.RequestID = R.RequestID
JOIN SUBMITS S ON M.RequestID = S.RequestID
JOIN TENANT T ON S.TenantID = T.TenantID
GROUP BY T.TenantID, T.TFirstName, T.TLastName, T.BuildingID, T.AptNo, M.Description, M.Status
ORDER BY T.TenantID ASC, LatestRequestDate ASC;

-- 16. Create a stored procedure to calculate monthly revenue 
DELIMITER //

CREATE PROCEDURE CalculateMonthlyRevenue(IN targetYear INT, IN targetMonth INT)
BEGIN
    DECLARE TotalMonthlyRevenue DECIMAL(10,2);

    SELECT SUM(MonthlyRent) INTO TotalMonthlyRevenue
    FROM LEASE
    WHERE LeaseStartDate <= LAST_DAY(DATE(CONCAT(targetYear, '-', targetMonth, '-01')))
      AND LeaseEndDate >= DATE(CONCAT(targetYear, '-', targetMonth, '-01'));

    SELECT TotalMonthlyRevenue AS MonthlyRentRevenue;
END //

DELIMITER ;
CALL CalculateMonthlyRevenue(2025, 3);

-- Other
-- Extract apartment details
SELECT DISTINCT AptNo, NoOfBedrooms, OccupancyStatus FROM APARTMENT;
-- Extract tenant details
SELECT DISTINCT TenantID, SSN, TFirstName, TLastName FROM TENANT;
-- Extract building details
SELECT DISTINCT BuildingID, BNoOfFloors FROM BUILDING;
-- Extract inspector details
SELECT DISTINCT InspectorID, InspectorName FROM INSPECTOR;













