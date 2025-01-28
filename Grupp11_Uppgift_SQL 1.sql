--- create Database

CREATE DATABASE TestK;
GO

USE TestK
GO

-- Creating the Household Table
CREATE TABLE Household (
    HouseholdID INT IDENTITY (1,1) PRIMARY KEY,
    Address VARCHAR(255),
);

CREATE TABLE Person (
    PersonID INT IDENTITY (1,1) PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DateOfBirth DATE,
    Gender CHAR(1),
    Parent1ID INT NULL,   -- Parent1 is required
    Parent2ID INT NULL,       -- Parent2 is optional
    EmploymentStatus VARCHAR(50),
    Income DECIMAL(18, 2),
    HouseholdID INT,
    FOREIGN KEY (Parent1ID) REFERENCES Person(PersonID),
    FOREIGN KEY (Parent2ID) REFERENCES Person(PersonID),
    FOREIGN KEY (HouseholdID) REFERENCES Household(HouseholdID)
);

----

INSERT INTO Household (Address)
VALUES
('Storgatan 1, 12345'),
('Vasagatan 12, 11120'),
('Drottninggatan 25, 21145'),
('Kungsgatan 8, 72212'),
('Sveavägen 43, 75331'),
('Nygatan 17, 90329'),
('Hamngatan 4, 70210'),
('Götgatan 56, 60220'),
('Hantverkargatan 9, 25112'),
('Centralvägen 3, 33130'),
('Norra Allén 19, 85234'),
('Södra Vägen 22, 90178'),
('Långgatan 7, 45142'),
('Kyrkogatan 11, 39231'),
('Torggatan 15, 30220'),
('Sturegatan 9, 60214'),
('Bruksgatan 6, 98131'),
('Rådhusgatan 8, 94133'),
('Torget 2, 34145'),
('Kvarngatan 12, 46130'),
('Husargatan 14, 62142'),
('Klockgatan 18, 73123'),
('Östra Hamngatan 4, 85240'),
('Gröna Vägen 3, 62114'),
('Bergsgatan 19, 26133'),
('Parkgatan 8, 56123'),
('Sjövägen 21, 66144'),
('Gamla Vägen 10, 43132'),
('Kaptensgatan 6, 79123'),
('Slottsgatan 16, 87141');

-------------------------

INSERT INTO Person (FirstName, LastName, DateOfBirth, Gender, Parent1ID, Parent2ID, EmploymentStatus, Income, HouseholdID)
VALUES

-- Household 1
('John', 'Doe', '1980-01-15', 'M', NULL, NULL, 'Employed', 50000.00, 1),
('Jane', 'Doe', '1983-05-20', 'F', NULL, NULL, 'Employed', 45000.00, 1),
('Emily', 'Doe', '2019-09-10', 'F', 1, 2, 'Unemployed', 0.00, 1),
('Chris', 'Doe', '2014-12-05', 'M', 1, 2, 'Unemployed', 0.00, 1);

INSERT INTO Person (FirstName, LastName, DateOfBirth, Gender, Parent1ID, Parent2ID, EmploymentStatus, Income, HouseholdID)
VALUES
-- Household 2
('Mike', 'Smith', '1955-12-30', 'M', NULL, NULL, 'Unemployed', 25000.00, 2),
('Sara', 'Smith', '1978-04-18', 'F', NULL, NULL, 'Employed', 30000.00, 2),
('Tom', 'Smith', '2013-03-12', 'M', 5, 6, 'Unemployed', 0.00, 2),

-- Household 3
('Alice', 'Brown', '1990-08-08', 'F', NULL, NULL, 'Employed', 32000.00, 3),
('Bob', 'Brown', '1992-11-11', 'M', NULL, NULL, 'Employed', 30000.00, 3),

-- Household 4
('Michael', 'Johnson', '1972-06-15', 'M', NULL, NULL, 'Employed', 42000.00, 4),
('Angela', 'Johnson', '1974-09-22', 'F', NULL, NULL, 'Employed', 39000.00, 4),
('Chris', 'Johnson', '2014-01-05', 'M', 10, 11, 'Unemployed', 0.00, 4),
('Sophia', 'Johnson', '2009-04-14', 'F', 10, 11, 'Unemployed', 0.00, 4),

-- Household 5
('David', 'Lee', '1965-02-15', 'M', NULL, NULL, 'Employed', 38000.00, 5),
('Susan', 'Lee', '1970-07-19', 'F', NULL, NULL, 'Employed', 36000.00, 5),
('Henry', 'Lee', '1999-08-21', 'M', 14, 15, 'Employed', 27000.00, 5),
('Sophia', 'Lee', '2007-10-25', 'F', 14, 15, 'Unemployed', 21000.00, 5),

-- Household 6
('Adam', 'Taylor', '1985-03-12', 'M', NULL, NULL, 'Employed', 32000.00, 6),
('Eva', 'Taylor', '1987-06-23', 'F', NULL, NULL, 'Employed', 29000.00, 6),
('Ben', 'Taylor', '2018-11-30', 'M', 18, 19, 'Unemployed', 0.00, 6),

-- Household 7
('James', 'Williams', '1990-02-05', 'M', NULL, NULL, 'Unemployed', 28000.00, 7),
('Olivia', 'Williams', '1993-07-17', 'F', NULL, NULL, 'Employed', 30000.00, 7),
('Liam', 'Williams', '2018-12-02', 'M', 21, 22, 'Unemployed', 0.00, 7),

-- Household 8
('Daniel', 'Davis', '1982-11-30', 'M', NULL, NULL, 'Employed', 47000.00, 8),
('Rebecca', 'Davis', '1986-01-20', 'F', NULL, NULL, 'Employed', 45000.00, 8),
('Lucas', 'Davis', '2014-03-25', 'M', 24, 25, 'Unemployed', 0.00, 8),

-- Household 9
('Henry', 'Martinez', '1975-04-05', 'M', NULL, NULL, 'Employed', 41000.00, 9),
('Laura', 'Martinez', '1980-05-16', 'F', NULL, NULL, 'Employed', 39000.00, 9),
('Sophia', 'Martinez', '2009-02-20', 'F', 27, 28, 'Unemployed', 0.00, 9),

-- Household 10
('Jack', 'Miller', '1968-07-12', 'M', NULL, NULL, 'Employed', 38000.00, 10),
('Samantha', 'Miller', '1972-10-08', 'F', NULL, NULL, 'Employed', 36000.00, 10),
('Michael', 'Miller', '2010-06-30', 'M', 30, 31, 'Unemployed', 0.00, 10),

-- Household 11
('William', 'Taylor', '1980-01-15', 'M', NULL, NULL, 'Employed', 51000.00, 11),
('Elizabeth', 'Taylor', '1983-03-25', 'F', NULL, NULL, 'Employed', 46000.00, 11),
('Olivia', 'Taylor', '2019-09-15', 'F', 33, 34, 'Unemployed', 0.00, 11),

-- Household 12
('Matthew', 'Brown', '1970-04-20', 'M', NULL, NULL, 'Employed', 42000.00, 12),
('Sophia', 'Brown', '1974-05-02', 'F', NULL, NULL, 'Employed', 41000.00, 12),
('Lucas', 'Brown', '2009-10-10', 'M', 36, 37, 'Unemployed', 0.00, 12),

-- Household 13
('Jacob', 'Wilson', '1990-08-16', 'M', NULL, NULL, 'Employed', 35000.00, 13),
('Emily', 'Wilson', '1993-07-30', 'F', NULL, NULL, 'Employed', 30000.00, 13),
('Ethan', 'Wilson', '2010-05-05', 'M', 39, 40, 'Unemployed', 0.00, 13),

-- Household 14
('George', 'Anderson', '1960-02-14', 'M', NULL, NULL, 'Employed', 50000.00, 14),
('Monica', 'Anderson', '1970-06-09', 'F', NULL, NULL, 'Employed', 47000.00, 14),
('David', 'Anderson', '1995-12-23', 'M', 42, 43, 'Employed', 26000.00, 14),

-- Household 15
('Benjamin', 'Thomas', '1992-03-30', 'M', NULL, NULL, 'Employed', 31000.00, 15),
('Charlotte', 'Thomas', '1995-08-05', 'F', NULL, NULL, 'Employed', 28000.00, 15),
('Mason', 'Thomas', '2014-11-15', 'M', 45, 46, 'Unemployed', 0.00, 15),

-- Household 16
('Samuel', 'Jackson', '1987-01-19', 'M', NULL, NULL, 'Employed', 43000.00, 16),
('Hannah', 'Jackson', '1990-07-25', 'F', NULL, NULL, 'Employed', 42000.00, 16),
('Lily', 'Jackson', '2012-02-10', 'F', 48, 49, 'Unemployed', 0.00, 16),

-- Household 17
('Matthew', 'White', '1981-12-18', 'M', NULL, NULL, 'Employed', 39000.00, 17),
('Olivia', 'White', '1983-05-30', 'F', NULL, NULL, 'Employed', 40000.00, 17),
('Zoe', 'White', '2009-06-25', 'F', 51, 52, 'Unemployed', 0.00, 17),

-- Household 18
('Evan', 'Harris', '1975-03-01', 'M', NULL, NULL, 'Employed', 45000.00, 18),
('Grace', 'Harris', '1978-10-13', 'F', NULL, NULL, 'Employed', 42000.00, 18),
('Benjamin', 'Harris', '2010-12-10', 'M', 53, 54, 'Unemployed', 0.00, 18),

-- Household 19
('Elijah', 'Clark', '1984-02-02', 'M', NULL, NULL, 'Employed', 41000.00, 19),
('Ella', 'Clark', '1988-09-17', 'F', NULL, NULL, 'Employed', 39000.00, 19),
('Aiden', 'Clark', '2012-07-15', 'M', 55, 56, 'Unemployed', 0.00, 19),

-- Household 20
('Isaac', 'Lewis', '1991-08-25', 'M', NULL, NULL, 'Employed', 46000.00, 20),
('Mia', 'Lewis', '1994-01-03', 'F', NULL, NULL, 'Employed', 44000.00, 20),
('Isaac', 'Lewis', '2016-05-25', 'M', 57, 58, 'Unemployed', 0.00, 20),

-- Household 21
('David', 'Young', '1983-11-20', 'M', NULL, NULL, 'Employed', 45000.00, 21),
('Catherine', 'Young', '1987-06-12', 'F', NULL, NULL, 'Employed', 42000.00, 21),
('Daniel', 'Young', '2013-04-18', 'M', 59, 60, 'Unemployed', 0.00, 21),
('Anna', 'Young', '2009-03-29', 'F', 59, 60, 'Unemployed', 0.00, 21),

-- Household 22
('Brian', 'King', '1974-07-30', 'M', NULL, NULL, 'Employed', 48000.00, 22),
('Lily', 'King', '1978-02-05', 'F', NULL, NULL, 'Employed', 46000.00, 22),
('Sophia', 'King', '2016-06-21', 'F', 61, 62, 'Unemployed', 0.00, 22),
('James', 'King', '2012-10-03', 'M', 61, 62, 'Unemployed', 0.00, 22),

-- Household 23
('Oliver', 'Scott', '1980-05-11', 'M', NULL, NULL, 'Employed', 47000.00, 23),
('Chloe', 'Scott', '1984-11-25', 'F', NULL, NULL, 'Employed', 44000.00, 23),
('Isabella', 'Scott', '2014-09-20', 'F', 63, 64, 'Unemployed', 0.00, 23),
('Aiden', 'Scott', '2011-03-06', 'M', 63, 64, 'Unemployed', 0.00, 23),

-- Household 24
('William', 'Adams', '1973-01-22', 'M', NULL, NULL, 'Employed', 46000.00, 24),
('Sarah', 'Adams', '1976-09-09', 'F', NULL, NULL, 'Employed', 43000.00, 24),
('Liam', 'Adams', '2015-07-18', 'M', 65, 66, 'Unemployed', 0.00, 24),
('Emma', 'Adams', '2009-02-17', 'F', 65, 66, 'Unemployed', 0.00, 24),

-- Household 25
('Henry', 'Baker', '1986-04-10', 'M', NULL, NULL, 'Employed', 50000.00, 25),
('Natalie', 'Baker', '1989-02-22', 'F', NULL, NULL, 'Employed', 47000.00, 25),
('George', 'Baker', '2012-11-01', 'M', 67, 68, 'Unemployed', 0.00, 25),
('Maya', 'Baker', '2008-01-19', 'F', 67, 68, 'Unemployed', 0.00, 25),

-- Household 26
('Matthew', 'Nelson', '1981-03-29', 'M', NULL, NULL, 'Employed', 54000.00, 26),
('Madeline', 'Nelson', '1983-07-08', 'F', NULL, NULL, 'Employed', 51000.00, 26),
('Lilly', 'Nelson', '2014-04-15', 'F', 69, 70, 'Unemployed', 0.00, 26),
('Ethan', 'Nelson', '2011-09-12', 'M', 69, 70, 'Unemployed', 0.00, 26),

-- Household 27
('David', 'Hughes', '1990-12-05', 'M', NULL, NULL, 'Employed', 51000.00, 27),
('Lauren', 'Hughes', '1992-05-18', 'F', NULL, NULL, 'Employed', 47000.00, 27),
('Nathan', 'Hughes', '2014-01-22', 'M', 71, 72, 'Unemployed', 0.00, 27),
('Olivia', 'Hughes', '2012-08-30', 'F', 71, 72, 'Unemployed', 0.00, 27),

-- Household 28
('Jacob', 'Perez', '1985-07-18', 'M', NULL, NULL, 'Employed', 47000.00, 28),
('Sophia', 'Perez', '1987-04-07', 'F', NULL, NULL, 'Employed', 44000.00, 28),
('Ryan', 'Perez', '2017-01-29', 'M', 73, 74, 'Unemployed', 0.00, 28),
('Amelia', 'Perez', '2011-03-10', 'F', 73, 74, 'Unemployed', 0.00, 28),

-- Household 29
('Andrew', 'Roberts', '1991-03-10', 'M', NULL, NULL, 'Employed', 48000.00, 29),
('Rebecca', 'Roberts', '1994-06-25', 'F', NULL, NULL, 'Employed', 46000.00, 29),
('Luca', 'Roberts', '2018-02-07', 'M', 75, 76, 'Unemployed', 0.00, 29),
('Zoe', 'Roberts', '2013-07-21', 'F', 75, 76, 'Unemployed', 0.00, 29),

-- Household 30
('Joshua', 'Walker', '1982-09-30', 'M', NULL, NULL, 'Employed', 50000.00, 30),
('Samantha', 'Walker', '1985-11-12', 'F', NULL, NULL, 'Employed', 47000.00, 30),
('Ethan', 'Walker', '2016-07-23', 'M', 77, 78, 'Unemployed', 0.00, 30),
('Chloe', 'Walker', '2012-05-30', 'F', 77, 78, 'Unemployed', 0.00, 30);

SELECT * FROM Person
--1.School starts as age 6. 2025 can be replaced with any year to find who started school that year
 SELECT PersonID, FirstName, LastName, Gender, DateOfBirth, Parent1ID, Parent2ID
 FROM Person
 WHERE YEAR(DateOfBirth) = 2025 - 6 

 --• Hur många pojkar och flickor kommer börja skolan år X? (SQL Query)
 SELECT Gender, COUNT(*) AS ChildrenToSchool
FROM Person
WHERE YEAR(DateOfBirth) = 2025 - 6
GROUP BY Gender;


 
--2. Ta fram en lista på deras föräldrar så man kan skicka ut post till dom (STORED PROC)
GO
CREATE OR ALTER PROCEDURE GetParentsOfKidsTurningSix
    @TargetYear INT
AS
BEGIN
    -- Declare the year when kids turn 6
    DECLARE @BirthYear INT = @TargetYear - 6;

    SELECT  p.FirstName, p.LastName, p.DateOfBirth,
	p1.FirstName AS Parent1FirstName, p1.LastName AS Parent1LastName,
	p2.FirstName AS Parent2FirstName, p2.LastName AS Parent2LastName, h.Address
    FROM Person p
    LEFT JOIN Person p1 ON p.Parent1ID = p1.PersonID   -- Join for Parent1
    LEFT JOIN Person p2 ON p.Parent2ID = p2.PersonID   -- Join for Parent2
	INNER JOIN Household h ON p.HouseholdID = h.HouseholdID
    WHERE 
        YEAR(p.DateOfBirth) = @BirthYear;  -- Filter for kids born in the year when they turn 6 in the target year
END

Exec GetParentsOfKidsTurningSix 2025

--3. Ta fram lista på alla som kommer bli ålderspensionärer (fylla 67) år X (SQL Query)

SELECT 
    PersonID, 
    FirstName, 
    LastName, 
    DateOfBirth, 
    Gender, 
    EmploymentStatus, 
    Income
FROM Person  --- när vi har en specific året så fick resultat
WHERE YEAR(DateOfBirth) = 2025 - 67; -- those born in 1958 will turn 67


--4• Hur många hushåll består av minst X personer (SQL Query)

-- Query to find households with at least 3 people
SELECT HouseholdID, COUNT(PersonID) AS NumberOfPeople
FROM Person
GROUP BY HouseholdID
HAVING COUNT(PersonID) >= 3; --X=3


--5.• Hur många hushåll har minst en medlem som är arbetslös (VIEW)

GO
CREATE OR ALTER VIEW HouseholdsWithUnemployed AS 
SELECT DISTINCT HouseholdID
FROM Person
WHERE EmploymentStatus = 'Unemployed' 
    AND Income = 0 
    AND DATEDIFF(YEAR, DateOfBirth, GETDATE())>= 15;  -- Filters for unemployed with zero income and age 15
GO

--SQL query utan View
SELECT 
    HouseholdID, 
    COUNT(*) AS UnemployedMembers
FROM Person
WHERE 
    EmploymentStatus = 'Unemployed' 
    AND DATEDIFF(year, DateOfBirth, GETUTCDATE()) >= 15
	AND Income = 0
GROUP BY 
    HouseholdID
HAVING 
    COUNT(*) >= 1;


SELECT * FROM HouseholdsWithUnemployed

SELECT COUNT(*) AS HouseholdsWithUnemployedCount
FROM HouseholdsWithUnemployed;

--6• Hur många hushåll tjänar totalt mindre än X kronor, dvs. kan vara aktuella för socialbidrag 


SELECT HouseholdID, SUM(Income) AS IncomePerHousehold
FROM Person
GROUP BY HouseholdID
HAVING SUM(Income) < 80000

SELECT HouseholdID, SUM(Income) AS IncomePerHousehold
FROM Person
GROUP BY HouseholdID
HAVING SUM(Income) < 100000