/*Ex 1: Từ bảng dbo.FactInternetSales và dbo.DimSalesTerritory, lấy ra thông tin SalesOrderNumber, SalesOrderLineNumber, ProductKey, SalesTerritoryCountry  của các bản ghi có SalesAmount trên 1000 

*/ 

-- Your code here 

 

SELECT FIS.SalesOrderNumber, 

    FIS.SalesOrderLineNumber, 

    FIS.ProductKey, 

    DST.SalesTerritoryCountry 

FROM dbo.FactInternetSales AS FIS 

JOIN dbo.DimSalesTerritory AS DST 

ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey 

WHERE FIS.SalesAmount > 1000 

 

 

 

 

 

/*Ex 2: Từ bảng dbo.DimProduct và dbo.DimProductSubcategory. Lấy ra ProductKey, EnglishProductName và Color của các sản phẩm thoả mãn EnglishProductSubCategoryName chứa chữ 'Bikes' và ListPrice có phần nguyên là 3399 

*/ 

-- Your code here 


SELECT 

    DP.ProductKey, 

    DP.EnglishProductName, 

    DP.Color, 

    DP.Listprice 

FROM dbo.DimProduct AS DP 

JOIN dbo.DimProductSubcategory AS DPS 

ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey 

WHERE DPS.EnglishProductSubcategoryName LIKE '%Bikes%' 

AND DP.ListPrice LIKE '3399%' 

 

 

 

 

/* Ex 3: Từ bảng dbo.DimPromotion, dbo.FactInternetSales, lấy ra ProductKey, SalesOrderNumber, SalesAmount từ các bản ghi thoả mãn DiscountPct >= 20%  

*/ 

-- Your code here 

 

 
 

SELECT FIS.ProductKey, 

    FIS.SalesOrderNumber, 

    FIS.SalesAmount 

FROM DBO.DimPromotion AS DP 

JOIN DBO.FactInternetSales AS FIS 

ON DP.PromotionKey = FIS.PromotionKey 

WHERE DiscountPct >= 0.2 

 

 

 

 

/* Ex 4: Từ bảng dbo.DimCustomer, dbo.DimGeography, lấy ra cột Phone, FullName (kết hợp FirstName, MiddleName, LastName kèm khoảng cách ở giữa) và City của các khách hàng có YearlyInCome > 150000 và CommuteDistance nhỏ hơn 5 Miles 

*/ 

 -- Your code here 

 SELECT DC.Phone, 

    CONCAT_WS(' ',FirstName,MiddleName,LastName) AS FullName, 

    CommuteDistance 

FROM dbo.DimCustomer AS DC 

JOIN dbo.DimGeography AS DG 

ON DC.GeographyKey = DG.GeographyKey 

WHERE YearlyIncome > 150000 

AND DC.CommuteDistance IN ('0-1 Miles', '1-2 Miles', '2-5 Miles') 

 

 

 

 

-- LogicalExpression   

/* Ex 5: Từ bảng dbo.DimCustomer, lấy ra CustomerKey và thực hiện các yêu cầu sau:  

a. Tạo cột mới đặt tên là YearlyInComeRange từ các điều kiện sau:  

- Nếu YearlyIncome từ 0 đến 50000 thì gán giá trị "Low Income"  

- Nếu YearlyIncome từ 50001 đến 90000 thì gán giá trị "Middle Income"  

- Nếu YearlyIncome từ  90001 trở lên thì gán giá trị "High Income"  

b. Tạo cột mới đặt tên là AgeRange từ các điều kiện sau:  

- Nếu tuổi của Khách hàng tính đến 31/12/2019 đến 39 tuổi thì gán giá trị "Young Adults"  

- Nếu tuổi của Khách hàng tính đến 31/12/2019 từ 40 đến 59 tuổi thì gán giá trị "Middle-Aged Adults"  

- Nếu tuổi của Khách hàng tính đến 31/12/2019 lớn hơn 60 tuổi thì gán giá trị "Old Adults"  

 */   

-- Your code here 

SELECT 

    CustomerKey, 

CASE 

    WHEN YearlyIncome BETWEEN 0 AND 50000 THEN 'Low Income' 

    WHEN YearlyIncome BETWEEN 50001 AND 90000 THEN 'Middle Income' 

    WHEN YearlyIncome >= 90001 THEN 'High Income' 

    ELSE 'Unknown' 

END AS YearlyInComeRange, 

CASE 

    WHEN DATEDIFF(YEAR,BirthDate,'2019-12-31') <= 39 THEN 'Young Adults' 

    WHEN DATEDIFF(YEAR,BirthDate,'2019-12-31') BETWEEN 40 AND 59 THEN 'Middle-Age Adults' 

    WHEN DATEDIFF(YEAR,BirthDate,'2019-12-31') >= 60 THEN 'Old Adults' 

    ELSE 'Unknown' 

END AS AgeRange 

FROM DimCustomer 

 

 

 

-- UNION concept 

/* Ex 6: Từ bảng FactInternetSales, FactResellerSales và DimProduct. Tìm tất cả SalesOrderNumber có EnglishProductName chứa từ 'Road' và có màu vàng (Yellow) */ 

-- Your code here 

 

SELECT SalesOrderNumber 

FROM FactInternetSales AS FIS 

JOIN DimProduct AS DP 

ON FIS.ProductKey = DP.ProductKey 

WHERE DP.EnglishProductName LIKE '%Road%' 

AND DP.Color = 'Yellow' 

UNION 

SELECT SalesOrderNumber  

FROM FactResellerSales AS FRS 

JOIN DimProduct AS DP 

ON FRS.ProductKey = DP.ProductKey 

WHERE DP.EnglishProductName LIKE '%Road%' 

AND DP.Color = 'Yellow' 

 

 