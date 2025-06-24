/* Ex1: Dựa và bảng FactInternetSales, tính tổng số lượng sản phẩm (OrderQuantity) 
đã được bán cho mỗi khách hàng (CustomerKey). Hiển thị kết quả theo thứ tự giảm dần của tổng số lượng.  
*/ 
SELECT
    CustomerKey,
    SUM(OrderQuantity) AS TOTALQUANTITY
FROM FactInternetSales
GROUP BY CustomerKey
ORDER BY TOTALQUANTITY DESC

 

/* Ex2: Dựa vào bảng FactInternetSales và DimProduct, thống kê tổng số lượng sản phẩm được bán (TotalOrderQuantity) 
cho mỗi sản phẩm (EnglishProductName). Hiển thị kết quả theo thứ tự giảm dần của TotalOrderQuantity.  
*/ 
SELECT
    EnglishProductName,
    SUM(OrderQuantity)AS TotalOrderQuantity
FROM FactInternetSales AS FIS
JOIN DimProduct AS DP
ON FIS.ProductKey=DP.ProductKey
GROUP BY EnglishProductName
ORDER BY TotalOrderQuantity DESC

/* Ex3: Dựa vào bảng FactInternetSales, DimCustomer. Tạo ra trường FullName 
từ (FirstName, MiddleName, LastName và sử dụng dấu cách ' ' để ghép nối)   
và thống kê số lượng đơn đặt hàng (OrderCount) mà họ đã thực hiện trong năm 2014. Và chỉ lấy những khách hàng có ít nhất 2 đơn đặt hàng.  */ 
SELECT
    YEAR(OrderDate) AS YEAR,
    COUNT(*) AS OrderCount,
    CONCAT_WS(' ',FirstName,MiddleName,LastName) AS FullName
FROM FactInternetSales AS FIS
JOIN DimCustomer AS DC
ON FIS.CustomerKey=DC.CustomerKey
WHERE
    YEAR(OrderDate) = 2014
GROUP BY 
    FirstName,MiddleName,LastName,OrderDate
HAVING
    COUNT(*) >=2
ORDER BY OrderCount ASC

/*  Ex4: Từ bảng DimProduct, DimProductSubCategory, DimProductCategory và FactInternetSales. 
Viết truy vấn lấy ra EnglishProductCategoryName, TotalAmount (tính theo SaleAmount) của 2 danh mục có doanh thu cao nhất trong năm 2014 */ 
SELECT TOP 2
    DPC.EnglishProductCategoryName,
    SUM(FIS.SalesAmount)AS TotalAmount
FROM FactInternetSales AS FIS
JOIN DimProduct AS DP
ON FIS.ProductKey= DP.ProductKey
JOIN DimProductSubcategory AS DPS
ON DP.ProductSubcategoryKey= DPS.ProductSubcategoryKey
JOIN DimProductCategory AS DPC
ON DPS.ProductCategoryKey=DPC.ProductCategoryKey
WHERE YEAR (OrderDate)=2014
GROUP BY EnglishProductCategoryName
ORDER BY SUM(FIS.SalesAmount) DESC


/* Ex5: Từ bảng FactInternetSale và bảng FactResellerSale, 
thực hiện từ 2 nguồn bán là Internet và Reseller đưa ra tất cả tất cả các SaleOrderNumber và doanh thu của mỗi SaleOrderNumber */ 
SELECT
    SalesOrderNumber,
    SalesAmount
FROM FactInternetSales
UNION ALL
SELECT
    SalesOrderNumber,
    SalesAmount
FROM FactResellerSales
ORDER BY SalesAmount DESC 
/* Ex6: Dựa vào 2 bảng DimDepartmentGroup và bảng FactFinace, 
thực hiện lấy ra TotalAmount (dựa vào Amount) của DepartmentGroupName và ParentDepartmentGroupName */ 
SELECT
    DPG.DepartmentGroupName,
    PDPG.DepartmentGroupName AS ParentDepartmentGroupName,
    SUM( Amount) AS TotalAmount
FROM FactFinance AS FF
LEFT JOIN DimDepartmentGroup AS DPG
ON FF.DepartmentGroupKey=DPG.DepartmentGroupKey
LEFT JOIN DimDepartmentGroup AS PDPG
ON DPG.ParentDepartmentGroupKey=PDPG.DepartmentGroupKey
GROUP BY DPG.DepartmentGroupName,PDPG.DepartmentGroupName
