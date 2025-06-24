/*
Exercise 1: Write a query using the DimProduct table that displays the minimum, maximum,
and average ListPrice of all Product
*/
SELECT 
    MIN(ListPrice),
    MAX(ListPrice),
    AVG(ListPrice)
FROM DimProduct

/*
Exercise 2: Write a query to determine the number of products in the FactInternetSales
table of all time.
*/
SELECT COUNT(DISTINCT ProductKey) AS TOTALPRODUCT
FROM FactInternetSales
 
 /*
The company is about to run a loyalty scheme to retain customers having total
value of orders greater than 5000 USD per year. From FactInternetSales table, retrieve the
list of qualified customers and the corresponding year.
*/
SELECT 
    CustomerKey,
    SUM(SalesAmount) AS TOTALAMOUNT,
    YEAR(OrderDate) AS Order_year
From FactInternetSales
GROUP BY CustomerKey,YEAR(OrderDate)
HAVING SUM(SalesAmount) > 5000
/* Ex1: Từ bảng DimEmployee, tính BaseRate trung bình của từng Title có trong công ty 
*/ 
SELECT
    Title,
    AVG(BaseRate) AS AverageBaseRate
FROM DimEmployee
GROUP BY Title 
/* Ex 2: Từ bảng FactInternetSales, lấy ra cột TotalOrderQuantity, 
sử dụng cột OrderQuantity tính tổng số lượng bán ra với từng ProductKey và từng ngày OrderDate 
*/ 
SELECT
    Productkey,
    SUM(OrderQuantity) AS TotalOrderQuantity,
    OrderDate
FROM FactInternetSales
Group By ProductKey, OrderDate

/* Ex3: Từ bảng DimProduct, FactInternetSales, DimProductCategory và các bảng liên quan nếu cần thiết 
Lấy ra thông tin ngành hàng gồm: CategoryKey, EnglishCategoryName của các dòng thoả mãn điều kiện OrderDate
trong năm 2012 và tính toán các cột sau đối với từng ngành hàng:  
- TotalRevenue sử dụng cột SalesAmount 
- TotalCost sử dụng côt TotalProductCost 
- TotalProfit được tính từ (TotalRevenue - TotalCost) 
Chỉ hiển thị ra những bản ghi có TotalRevenue > 5000  
*/
SELECT
    DPcate.ProductCategoryKey,
    DPcate.EnglishProductCategoryName,
    SUM(SalesAmount) AS TotalRevenue,
    SUM(TotalProductCost) AS TotalCost,
    SUM(SalesAmount)-SUM(TotalProductCost) AS TotalProfit
FROM FactInternetSales AS FIS
LEFT JOIN DimProduct AS DP
ON FIS.ProductKey = DP.ProductKey
LEFT JOIN DimProductSubcategory AS DPSub
ON DP.ProductSubcategoryKey = DPSub.ProductSubcategoryKey
LEFT JOIN DimProductCategory AS DPcate
ON DPSub.ProductCategoryKey = DPcate.ProductCategoryKey
WHERE YEAR(FIS.OrderDate)= 2012
GROUP BY DPcate.ProductCategoryKey, DPcate.EnglishProductCategoryName
HAVING SUM(SalesAmount) > 5000

 /* Ex 4: Từ bảng FactInternetSale, DimProduct, 
- Tạo ra cột Color_group từ cột Color, nếu Color là 'Black' hoặc 'Silver' gán giá trị 'Basic' cho cột Color_group, nếu không lấy nguyên giá trị cột Color sang 
- Sau đó tính toán cột TotalRevenue từ cột SalesAmount đối với từng Color_group mới này  
*/  
 SELECT
    CASE
    WHEN Color IN ('BLACK','SILVER') THEN 'BASIC'
    ELSE Color
    END AS Color_group,
    SUM(FIS.SalesAmount) AS TotalRevenue
 FROM FactInternetSales as FIS
 LEFT JOIN DimProduct AS DP
 ON FIS.ProductKey = DP.ProductKey
 GROUP BY
    CASE
    WHEN COLOR IN ('BLACK','SILVER') THEN 'BASIC'
    ELSE COLOR    
    END

/* Ex 5 (nâng cao) Từ bảng FactInternetSales, FactResellerSales và các bảng liên quan nếu cần, 
sử dụng cột SalesAmount tính toán doanh thu ứng với từng tháng của 2 kênh bán Internet và Reseller 
Kết quả trả ra sẽ gồm các cột sau: Year, Month, InternSales, Reseller_Sales 
Gợi ý: Tính doanh thu theo từng tháng ở mỗi bảng độc lập FactInternetSales và FactResllerSales bằng sử dụng CTE  
Lưu ý khi có nhiều hơn 1 CTE trong mệnh đề thì viết syntax như sau:  
WITH Name_CTE_1 AS ( 
SELECT statement 
) 
, Name_CTE_2 AS ( 
SELECT statement 
)  
SELECT statement 
*/  

WITH InternetSales_CTE AS(
    SELECT
        YEAR(OrderDate) AS YEAR,
        MONTH(OrderDate) AS MONTH,
        SUM(SalesAmount) AS Internet_Sales
    FROM FactInternetSales
    GROUP BY YEAR(OrderDate),MONTH (OrderDate)
),
ResellerSales_CTE AS(
    SELECT
        YEAR(OrderDate) AS YEAR,
        MONTH(OrderDate) AS MONTH,
        SUM(SalesAmount) AS Reseller_Sales
    FROM FactResellerSales
    GROUP BY YEAR(OrderDate),MONTH (OrderDate)
)
SELECT
    COALESCE(I.YEAR,R.YEAR) AS YEAR,
    COALESCE(I.MONTH,R.MONTH) AS MONTH,
    Internet_Sales,
    Reseller_Sales
FROM InternetSales_CTE AS I
FULL JOIN ResellerSales_CTE AS R
ON I.YEAR=R.YEAR AND I.MONTH=R.MONTH

 