--SQL 1 Inlämningsuppgift--

-- 1. Vi är i processen av att analysera våra kunders köphistorik. Kan du visa oss den totala mängden kunden Sara Huiting har betalat för via faktura?
-- Ge oss kundens namn, och den totala summan (utan skatt) - 1p

SELECT Sales.Customers.CustomerName, SUM(Sales.CustomerTransactions.AmountExcludingTax) AS TotalAmount
FROM Sales.Customers 
JOIN Sales.CustomerTransactions
ON Sales.Customers.CustomerID = sales.CustomerTransactions.CustomerID
WHERE Sales.Customers.CustomerName = 'Sara Huiting' AND Sales.CustomerTransactions.TransactionTypeID = 1
GROUP BY Sales.Customers.CustomerName

---- OR

SELECT c.CustomerName, SUM(IL.Quantity*IL.Unitprice) AS TotalAmount
FROM Sales.Customers  c
JOIN Sales.Invoices i
ON c.CustomerID = i.CustomerID
JOIN sales.InvoiceLines IL
ON i.InvoiceID = il.InvoiceID
WHERE c.CustomerName = 'Sara Huiting'
GROUP BY c.CustomerName

--2. Ge oss nu top 10 kunders totala köphistorik via faktura. Visa högst totalkostnad först. (utan skatt) - 1p

SELECT TOP 10 c.CustomerName, SUM(t.AmountExcludingTax) AS TotalPurchase
FROM Sales.Customers AS C
JOIN Sales.CustomerTransactions AS T
ON c.CustomerID = t.CustomerID
WHERE TransactionTypeID = 1
Group BY c.CustomerName
ORDER BY TotalPurchase DESC

--3. Vi behöver se över vårt lager. Ge oss en rapport med produktnamn, aktuellt produktantal för 
-- varje produkt med ett nuvarande lagersaldo under 1000 och produktantalgränsen för när nyinventering bör ske. 
--Sortera på nuvarande lagersaldo i fallande ordning. - 1p

SELECT S.StockItemName, h.QuantityOnHand, h.ReorderLevel
FROM Warehouse.StockItemHoldings H
JOIN Warehouse.StockItems S
ON h.StockItemID = s.StockItemID
WHERE h.QuantityOnHand <1000
ORDER BY QuantityOnHand DESC

--4. Hämta fakturaID, fakturadatum och totalbelopp (utan skatt) för fakturor med en totalsumma på över 10 000. - 1p

SELECT S.InvoiceID, s.InvoiceDate, t.AmountExcludingTax 
FROM Sales.Invoices S
JOIN Sales.CustomerTransactions AS T
ON s.InvoiceID = t.InvoiceID
WHERE AmountExcludingTax >10000
ORDER BY s.InvoiceDate
--OR--
SELECT S.InvoiceID, S.InvoiceDate, SUM(il.UnitPrice*IL.Quantity) AS NetAmount
FROM Sales.Invoices S
JOIN Sales.InvoiceLines IL
ON s.InvoiceID = il.InvoiceID
GROUP BY s.InvoiceID, s.InvoiceDate
HAVING SUM(il.UnitPrice*IL.Quantity) >10000
ORDER BY s.InvoiceDate

--5. Skriv ett query som visar alla slutpriser(med skatt, ta värden över 0) för transaktioner, samt räknar hur många gånger varje enskilt pris 
--förekommer i tabellen. Sortera så att högst antal förekommanden av priser är först - 1p

SELECT TransactionAmount, Count(*) AS Frequency
FROM sales.CustomerTransactions
WHERE TransactionAmount >0
Group By TransactionAmount
ORDER BY Frequency DESC;

--6. Titta på specialrabatter. Utgå från rabatt med ID = 2 och gör sedan ett räkneexempel. 
--Ta ner rabatten från procent till decimalform och räkna ut det nya priset efter applicerad rabatt, för en fiktiv produkt som kostar 565kr. - 1p

SELECT 565-(DiscountPercentage/100)*565 AS NewPrice
FROM Sales.SpecialDeals
WHERE SpecialDealID = 2

--7. Skriv en SQL-fråga som hämtar de två köpleveransmetoderna som är mest populära(mest använda). Visa även antal gånger dessa använts på köpbeställningar(PurchasingOrders) och sortera
--så att högst antal förekommanden är först. - 1p
																					    
SELECT Top 2 d.DeliveryMethodName, count(*) AS NrOfTimes
FROM Purchasing.PurchaseOrders p 
INNER JOIN Application.DeliveryMethods d
ON p.DeliveryMethodID = d.DeliveryMethodID
GROUP BY d.DeliveryMethodName
ORDER BY NrOfTimes DESC

--8. Som nyanställda behöver ni registreras i databasen. Lägg in ert namn och övrig relevant information i Application.People tabellen 
--på liknande sätt som andra registrerade anställda. Fokusera enbart på de kolumner som inte tillåter null värden just nu, resterande kolumner kan vi ta vid senare tillfälle. 
--Låt P.K, Search Name och Datum hanteras automatiskt. Ni får logga in, men är inte External logon provider och heller inte försäljare. Låt LastEditedBy referera till id 1.  - 2p

INSERT INTO Application.People
(FullName, PreferredName, IsPermittedToLogon, IsExternalLogonProvider, IsSystemUser, IsEmployee
 ,IsSalesperson,LastEditedBy)
VALUES
('Andrei Ghejan','Ghejan','1','0','1','1','0','1')

--9. Vi behöver lägga till några nya färger i databasen. Färgerna är: Turquoise, Lime Green, Pink och Jade. 
--Skriv en query för att lägga till de nya färgerna. Ni måste även referera senast ändringen (LastEditedBy) till ert personliga PersonID 2p

INSERT INTO Warehouse.Colors
(ColorName, LastEditedBy)
VALUES
('Turquoise','3262'),
('Lime Green','3262'),
('Pink','3262'),
('Jade','3262')

--10. Det blev en misskommunikation och vi behöver inte den nya färgen Lime Green. Var snäll och radera den från databasen.  2p

DELETE FROM Warehouse.Colors
WHERE ColorName = 'Lime Green'

--11. Vad är det minsta enhetspriset för en orderrad år 2013? Visa orderdatum(OrderDate) i YEAR och det minsta enhetspriset. Ta bort dubletter. - 2p

SELECT DISTINCT YEAR(SO.OrderDate) AS OrderYear, MIN(OL.UnitPrice) AS MinimumLinePrice
FROM sales.OrderLines OL
INNER JOIN sales.Orders SO
ON ol.OrderID = so.OrderID
WHERE YEAR(SO.OrderDate)=2013
GROUP BY YEAR(SO.OrderDate)

--12. Hämta en lista över alla orders som är plockade (PickingCompletedWhen är inte null) och som innehåller produkter som 
--har ett enhetspris högre än det genomsnittliga enhetspriset för alla orderrader. Visa OrderId och enhetspris - 2p

SELECT OrderID, UnitPrice
FROM Sales.OrderLines
WHERE PickingCompletedWhen IS NOT NULL
AND UnitPrice > (
SELECT AVG(UnitPrice)
FROM Sales.OrderLines)
ORDER BY OrderID

--- OR

SELECT so.OrderID, sol.UnitPrice
FROM sales.Orders SO
JOIN sales.OrderLines SOL
ON so.OrderID = sol.OrderID
WHERE so.PickingCompletedWhen IS NOT NULL
AND sol.UnitPrice >
(SELECT AVG(UnitPrice)
FROM Sales.OrderLines)
ORDER BY so.OrderID

--13. Skapa ett index i en tabell med över 50 00 poster. Välj en kolumn som inte redan har ett index. 
--Skriv därefter ett query som inehåller och använder sig av indexerad kolumn och visar exekveringstid i messages. 2p  

CREATE INDEX InvoiceDate
ON Sales.Invoices(InvoiceDate)

SET STATISTICS TIME ON
SELECT*
FROM Sales.Invoices
WHERE InvoiceDate = '2016-05-30'
SET STATISTICS TIME OFF

--14. Visa produkter i lagret med ett enhetspris mellan 5 och 20 och typisk vikt per enhet mellan 0.1 och 0.4. Sortera på enhetspris stigande.
--Därefter, skriv ett nytt query under som räknar totala antalet produkter som uppfyller villkoren av första frågan. - 2p

SELECT *
FROM Warehouse.StockItems
WHERE UnitPrice BETWEEN 5 AND 20
AND TypicalWeightPerUnit BETWEEN 0.1 AND 0.4
ORDER BY UnitPrice;

SELECT COUNT(*) AS TotalProducts
FROM Warehouse.StockItems
WHERE UnitPrice BETWEEN 5 AND 20
AND TypicalWeightPerUnit BETWEEN 0.1 AND 0.4

--15. Lägg ihop kunder och transaktioner. Vi vill se: KundID, Kundnamn som endast inehåller 4 första tecknen och sedan en sammanfogad order summary. 
--Exmpel på hur order summary ska se ut: Before tax: $100 - Total: $150. Ta endast transaktionsvärden över 0. - 2p

SELECT ct.CustomerID, LEFT(c.CustomerName,4) AS CustName, CONCAT('Before Tax: ',SUM(ct.AmountExcludingTax),' - ','Total: ', SUM(ct.TransactionAmount)) AS OrderSummary
FROM Sales.CustomerTransactions CT
JOIN Sales.Customers C
ON ct.CustomerID = c.CustomerID
WHERE ct.TransactionAmount >0
GROUP BY ct.CustomerID, LEFT(c.CustomerName,4);
--OR

SELECT ct.CustomerID, LEFT(c.CustomerName,4) AS CustName, SUM(ct.AmountExcludingTax) AS BeforeTax, SUM(ct.TransactionAmount) AS TotalAmount
FROM Sales.CustomerTransactions CT
JOIN Sales.Customers C
ON ct.CustomerID = c.CustomerID
WHERE ct.TransactionAmount >0
GROUP BY ct.CustomerID, LEFT(c.CustomerName,4)

--16. Visa KundID och och kundnamn. Sätt därefter ihop en kontaktinfo som ser ut såhär: Contact: (111) 111-1111 | Url: http//www.aaaaaaa.com.
-- Ta endast fram kunder som har en kundkategori som innehåller 'store'. Visa även kategorin. - 2p

SELECT c.CustomerID, c.CustomerName, CONCAT('Contact: ',c.PhoneNumber,' | ','URL: ',c.WebsiteURL) AS ContactInformation, cc.CustomerCategoryName
FROM Sales.Customers C
INNER JOIN Sales.CustomerCategories CC
ON c.CustomerCategoryID = cc.CustomerCategoryID
WHERE cc.CustomerCategoryName LIKE '%store%'

--17. Vi vill se VILKA det var som senaste redigerade information om länder. Sätt ihop person och länder-tabellerna och visa endast personers id och namn, därefter,
-- visa alla övriga kolumner från länder. Ta bara med länder i Europa och Asien och ta bort personid 1. Sortera stigande på giltigt datum.  - 2p

SELECT ap.PersonID, ap.FullName, ac.*
FROM Application.People AP
JOIN Application.Countries AC
ON ap.PersonID = ac.LastEditedBy
WHERE ac.Region IN ('Europe','Asia') AND ap.PersonID != 1
ORDER BY ac.ValidTo ASC;

--18. Vi behöver uppdatera uppgifter för en av våra registrerade personer.
-- Han är tidigare registrerad som Daniel Magnusson och har precis blivit anställd hos oss. Han är numera en systemanvändare, anställd och försäljare,
-- Daniel bytte dock nyligen efternamn till Franzén. Se till att uppdatera hans nya efternamn. 
-- Han ska ha möjlighet attt logga in och har tilldelats ett arbetsmail: danielf@wideworldimporters.com
-- Se till att göra detta till hans login och uppdatera även tidigare registrerad mail. - 2p

UPDATE Application.People
SET FullName = 'Daniel Franzén', IsPermittedToLogon = 1, EmailAddress = 'danielf@wideworldimporters.com' ,
IsSystemUser = 1, IsEmployee = 1, IsSalesperson = 1, LogonName = 'danielf@wideworldimporters.com'
WHERE PersonID = 1383

--19. Skapa en valfri Stored Procedure(SP) med två inputvärden och en inner join som du tycker passar. Demonstrera användandet av den därefter. 3p

CREATE OR ALTER PROCEDURE InvoicesPerCustomerByDate
@CustomerCategoryID int,
@InvoiceStartDate DATE,
@InvoiceEndDate DATE
AS
BEGIN
SELECT  I.InvoiceID, c.CustomerID, i.InvoiceDate, SUM(IL.UnitPrice*IL.Quantity) AS NetInvoiceAmount, cc.CustomerCategoryName
FROM Sales.Customers C
JOIN Sales.Invoices I
ON c.CustomerID = I.CustomerID
JOIN Sales.CustomerCategories CC
ON c.CustomerCategoryID = cc.CustomerCategoryID
JOIN Sales.InvoiceLines IL
ON i.InvoiceID = il.InvoiceID
WHERE cc.CustomerCategoryID = @CustomerCategoryID AND i.InvoiceDate >= @InvoiceStartDate AND i.InvoiceDate <= @InvoiceEndDate
GROUP BY c.CustomerID, i.InvoiceID, i.InvoiceDate, cc.CustomerCategoryName
ORDER BY i.InvoiceID
END

EXEC InvoicesPerCustomerByDate 3,'2013-01-01','2015-08-08'

--20. Skriv en fråga som visar kundnamn och kundkategori för alla kunder som hade transaktioner under året 2014. För varje kund, visa:
--Kundens namn i stora bokstäver.
--Kundkategori.
--Den totala summan av transaktioner (utan skatt) för 2014, avrundat till noll decimaler.
--Det genomsnittliga transaktionsbeloppet(utan skatt) för 2014, avrundat till en decimal. - 3p

SELECT UPPER(c.customername) AS CustomerName, cat.CustomerCategoryName, FORMAT(ROUND(SUM(ct.amountexcludingtax),0),'N0') AS TotalTransactions,
FORMAT(ROUND(AVG(ct.AmountExcludingTax),1),'N1') AS AverageTransactionAmount2014
FROM Sales.CustomerTransactions CT
INNER JOIN Sales.Customers C
ON ct.CustomerID = c.CustomerID
INNER JOIN Sales.CustomerCategories CAT
ON c.CustomerCategoryID = cat.CustomerCategoryID
WHERE YEAR(CT.TransactionDate) = 2014
GROUP BY UPPER(c.CustomerName), cat.CustomerCategoryName
ORDER BY CustomerName

--21. Skriv en fråga som visar information om produkter (StockItems) som har haft transaktioner under året 2014. För varje produkt visa:
--Produktens namn (StockItemName) i små bokstäver.
--Färg på produkten (ColorName). Ta med alla StockItems även de som inte har en matchning med color.
--Antalet gånger en transaktion med produkten förekommit under året.
--Den totala kvantiteten som förekom i transaktioner under året. Ta endast ingående produktkvantitet(inga minustal).
--Den genomsnittliga kvantiteten per transaktion, avrundad till noll decimaler.
--Sortera resultatet i fallande ordning efter totalt antal sålda enheter. 3p

SELECT LOWER(si.StockItemName) AS ItemName, col.ColorName, COUNT(*) AS TotalTransactions, 
SUM(st.quantity) AS QuantityTransactions, FORMAT(ROUND(AVG(st.Quantity),0),'N0') AS AverageQPerTransaction
FROM Warehouse.StockItemTransactions ST
INNER JOIN Warehouse.StockItems SI
ON st.StockItemID = si.StockItemID
LEFT JOIN Warehouse.Colors COL
ON si.ColorID = col.ColorID
WHERE YEAR(st.TransactionOccurredWhen) = 2014 AND Quantity >0
GROUP BY StockItemName, col.ColorName
ORDER BY QuantityTransactions DESC

--22. Vi har noterat att en vanlig förekommande rapport är översikt kring våra kunders fakturor och transaktioner. Kan du skapa en view som innehåller: 
--kundnamn, kundkategori, fakturaID, fakturadatum, summa (utan skatt) och levereringsinstruktioner. Filtrera bort kostnader under 1000 (utan skatt)
-- Skriv ett query som skapar denna view med ett passande namn och sedan ett query som använder sig av samma view och även filtrerar på kostnad (utan skatt) fallande. - 3p

CREATE VIEW CustomersInvoiceAndTransactions AS
SELECT i.InvoiceID, i.InvoiceDate, SUM(IL.Quantity * IL.UnitPrice) AS TotalAmount, c.CustomerName, cc.CustomerCategoryName,  i.DeliveryInstructions
FROM sales.CustomerCategories cc
JOIN sales.Customers c
   ON cc.CustomerCategoryID = c.CustomerCategoryID
JOIN  sales.Invoices i
    ON c.CustomerID = i.CustomerID
JOIN sales.InvoiceLines il
    ON i.InvoiceID = il.InvoiceID
GROUP BY i.InvoiceID, i.InvoiceDate, c.CustomerName, cc.CustomerCategoryName,  i.DeliveryInstructions
HAVING SUM(IL.Quantity * IL.UnitPrice) >= 1000

---

SELECT*
FROM CustomersInvoiceAndTransactions
ORDER BY TotalAmount DESC;

--23. Titta på beställningar och beräkna det genomsnittliga enhetspriset per kundID år 2013. Visa sedan endast rader med ett genomsnittligt enhetspris lika med och över 60 -3p

SELECT o.CustomerID, AVG(ol.UnitPrice) As AverageUnitPrice
FROM sales.Orders O
JOIN sales.OrderLines OL
ON o.OrderID = ol.OrderID
WHERE YEAR(o.OrderDate) = 2013
GROUP BY o.CustomerID
HAVING AVG(ol.UnitPrice) >= 60
ORDER BY AverageUnitPrice DESC;

--24. Skriv en query som hämtar CustomerID, en kolumn kallad "OrderCount" som räknar antalet beställningar varje kund har gjort,
--en kolumn kallad "AvgOrderValue" som visar det genomsnittliga enhetspriset på ordrar avrundat till två decimaler, samt en kolumn kallad 
--"CustomerSummary" som innehåller en sammanfattning i formatet "Customer [CustomerID] - Orders: [OrderCount] - Avg: $[AvgOrderValue]". 
--Filtrera för kunder som har lagt fler eller lika med 100 beställningar och sortera resultatet i fallande ordning efter AvgOrderValue. - 3p

SELECT o.CustomerID, COUNT(o.OrderID) AS OrderCount, FORMAT(ROUND(AVG(ol.UnitPrice), 2),'N2') AS AvgOrderValue, 
CONCAT('Customer',' ',o.CustomerID,' - ','Orders:',' ',COUNT(o.OrderID),' - ','Avg:',' ','$','',FORMAT(ROUND(AVG(ol.UnitPrice), 2),'N2')) AS CustomerSummary
FROM Sales.Orders O
JOIN Sales.OrderLines OL
on o.OrderID = ol.OrderID
GROUP BY o.CustomerID
HAVING COUNT(o.OrderID) >=100
ORDER BY AvgOrderValue DESC;

-- 25. Skriv en query som hämtar CustomerID, CustomerName, antalet beställningar per kund, samt det totala beloppet (enhetspris gånger kvantitet) 
--för alla deras beställningar av items i kategorin 'Clothing'. Filtrera för kunder vars totala belopp är större än 10 000 
--och sortera resultatet i fallande ordning efter totalbeloppet. - 3p

SELECT  o.CustomerID, c.CustomerName, COUNT(o.OrderID) AS TotalOrders, SUM(OL.Quantity*OL.UnitPrice) AS TotalAmount
FROM Sales.Orders O
JOIN Sales.Customers C
ON o.CustomerID = c.CustomerID
JOIN Sales.OrderLines OL
ON O.OrderID = OL.OrderID
JOIN Warehouse.StockItemTransactions SIT
ON c.CustomerID = sit.CustomerID
JOIN Warehouse.StockItems SI
ON SIT.StockItemID = SI.StockItemID
JOIN Warehouse.StockItemStockGroups SISD
ON si.StockItemID = sisd.StockItemID
JOIN Warehouse.StockGroups SG
ON sisd.StockGroupID = sg.StockGroupID
WHERE sg.StockGroupName = 'Clothing'
GROUP BY o.CustomerID, c.CustomerName
HAVING SUM(OL.Quantity*OL.UnitPrice) > 10000
ORDER BY TotalAmount DESC;
