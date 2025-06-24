/*Ex 1: Từ các bảng dbo.DimProduct, dbo.DimPromotion, dbo.FactInternetSales, lấy ra ProductKey, EnglishProductName của các dòng thoả mãn Discount Pct >= 20%  
*/ 
-- Your code here 
SELECT 
    DP.ProductKey, 
    DP.EnglishProductName 
FROM FactInternetSales AS FIS 
JOIN DimProduct AS DP 
ON FIS.ProductKey = DP.ProductKey 
JOIN DimPromotion AS DPR 
ON FIS.PromotionKey = DPR.PromotionKey 
WHERE DiscountPct >= 0.2 

/*Ex 2: Từ các bảng DimProduct, DimProductSubcategory, DimProductCategory, 
lấy ra các cột Product key, EnglishProductName, EnglishProductSubCategoryName, EnglishProductCategoryName 
của sản phẩm thoả mãn điều kiện EnglishProductCategoryName là 'Clothing'  
*/ 
 -- Your code here 
SELECT
    DP.ProductKey, 
    DP.EnglishProductName, 
    DPS.EnglishProductSubcategoryName, 
    DPC.EnglishProductCategoryName 
FROM DimProduct AS DP 
JOIN DimProductSubcategory AS DPS 
ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey 
JOIN DimProductCategory AS DPC 
ON DPS.ProductCategoryKey = DPC.ProductCategoryKey 
WHERE EnglishProductCategoryName = 'Clothing' 


/*Ex 3: Từ bảng FactInternetSales và DimProduct, lấy ra ProductKey, EnglishProductName, ListPrice của những sản phẩm chưa từng được bán.  

Sử dụng 2 cách: toán tử IN và phép JOIN  

*/  -- Your code here 
SELECT
    ProductKey,
    EnglishProductName,
    ListPrice
FROM DimProduct
WHERE ProductKey 
NOT IN 
(SELECT ProductKey
FROM FactInternetSales)
SELECT
    DP.ProductKey,
    DP.EnglishProductName,
    DP.ListPrice
FROM DimProduct AS DP
LEFT JOIN FactInternetSales AS FIS
ON DP.ProductKey = FIS.ProductKey
WHERE FIS.ProductKey IS NULL

/*Ex 4: Từ bảng DimDepartmentGroup, lấy ra thông tin DepartmentGroupKey,
 DepartmentGroupName, ParentDepartmentGroupKey và thực hiện self-join lấy ra ParentDepartmentGroupName  
*/
 -- Your code here 
SELECT
    CHILD.DepartmentGroupKey,
    CHILD.ParentDepartmentGroupKey,
    CHILD.DepartmentGroupName,
    PARENT.DepartmentGroupName AS ParentDepartmentGroupName
FROM DimDepartmentGroup AS CHILD
LEFT JOIN DimDepartmentGroup AS PARENT
ON CHILD.ParentDepartmentGroupKey = PARENT.DepartmentGroupKey

 
/*Ex 5: Từ bảng FactFinance, DimOrganization, DimScenario, lấy ra OrganizationKey,
 OrganizationName, Parent OrganizationKey, và thực hiện self-join lấy ra Parent OrganizationName,
 Amount thoả mãn điều kiện ScenarioName là 'Actual'.  
*/ 
-- Your code here 
SELECT
    DO.OrganizationKey,
    DO.OrganizationName,
    DO.ParentOrganizationKey,
    PDO.OrganizationName AS 'Parent OrganizationName',
    FF.Amount
FROM FactFinance AS FF
LEFT JOIN DimScenario AS DS
ON FF.ScenarioKey = DS.ScenarioKey
LEFT JOIN DimOrganization AS DO
ON FF.OrganizationKey = DO.OrganizationKey
LEFT JOIN DimOrganization AS PDO
ON DO.ParentOrganizationKey = PDO.OrganizationKey
WHERE DS.ScenarioName = 'Actual'
