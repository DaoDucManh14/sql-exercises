/* Ex1: Từ bộ AdventureWorksDW2019, bảng FactInternetSales,  

lấy tất cả các bản ghi có OrderDate từ ngày '2011-01-01' về sau và ShipDate trong năm 2011  

*/  

-- Your code here 

 

SELECT * 

FROM FactInternetSales 

WHERE OrderDate >= '2011-01-01' 

AND YEAR(ShipDate) = 2011 

 
 

 

 

 

 

/*Ex2: Từ bộ AdventureWorksDW2019, bảng DimProduct, 

Lấy ra thông tin ProductKey, ProductAlternateKey và EnglishProductName của các sản phẩm.  

Lọc các sản phẩn có ProductAlternateKey bắt đầu bằng chữ 'BK-' theo sau đó là 1 ký tự bất kỳ khác chữ T và kết thúc bằng 2 con số bất kỳ 

Đồng thời, thoả mãn điều kiện Color là Black hoặc Red hoặc White  

*/  

-- Your code here 

SELECT 

    Productkey,  

    ProductAlternateKey,  

    EnglishProductName 

FROM DimProduct 

WHERE ProductAlternateKey LIKE 'BK-[^T]%[0-9 

][0-9]'

AND COLOR IN ('BLACK','WHITE','RED') 


 

/* Ex3: Từ bộ AdventureWorksDW2019, bảng DimProduct, lấy ra tất cả các sản phẩm có cột Color là Red */  

-- Your code here 

 

SELECT *  

FROM DimProduct 

Where Color = 'Red' 

 

 

/* Ex4: Từ bộ AdventureWorksDW2019, bảng FactInternetSales chứa thông tin bán hàng,  

lấy ra tất cả các bản ghi bán các sản phẩm có màu là Red */  

(Gợi ý: Sử dụng toán tử IN kết hợp Subquery,  

Có thể tham khảo thêm từ link sau: sqlservertutorial.net/sql-server-basics/sql-server-in/  

*/  

-- Your code here 

 
 

Select * 

From FactInternetSales 

Where Productkey IN ( 

    SELECT ProductKey 

    From DimProduct 

    Where Color = 'Red' 

)  

 

 

 

/* Ex5: Từ bộ AdventureWorksDW2019, bảng DimEmployee, lấy ra EmployeeKey, FirstName, LastName, MiddleName của những nhân viên có MiddleName không bị Null và cột Phone có độ dài 12 ký tự  

*/  

-- Your code here 

SELECT 

    EmployeeKey, 

    FirstName, 

    LastName, 

    MiddleName, 

From DimEmployee 

WHERE MiddleName IS NOT NULL  

AND LEN(Phone) =12 

 

 

/* Ex6: Từ bộ AdventureWorksDW2019, bảng DimEmployee, lấy ra danh sách các EmployeeKey 

Sau đó lấy ra thêm các cột sau:  

a. Cột FullName được lấy ra từ kết hợp 3 trường FirstName, MiddleName và LastName, với dấu cách ngăn cách giữa các trường (sử dụng 2 cách: toán tử '+' và hàm, sau đó so sánh sự khác biệt)  

c. Cột AgeNow tính tuổi nhân viên đến thời điểm hiện tại, sử dụng cột BirthDate 

d. Cột UserName được lấy ra từ phần đằng sau dấu "\" của cột LoginID  

(Ví dụ: LoginID = adventure-works\jun0, vậy Username tương ứng cần được lấy ra là jun0)  

*/  

-- Your code here 

 

SELECT 

    EmployeeKey, 

    FirstName + ' ' + MiddleName + ' ' + lastname AS Fullname, 

    FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName AS FullName, 

    DATEDIFF (YEAR, BirthDate, HireDate) AS AgeHired, 

    DATEDIFF (YEAR, BirthDate, GETDATE()) AS AgeNow, 

    RIGHT(LoginID,CHARINDEX('\',REVERSE(LoginID)) - 1) AS USER_NAME 

FROM DimEmployee 

 