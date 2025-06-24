# SQL Practice

This repository contains a series of SQL practice exercises I completed to build a solid foundation in data querying and analysis.  
The exercises are based on the AdventureWorksDW2019 database, which simulates a real-world star schema used in business intelligence.

## Purpose

My goal with this portfolio is to demonstrate my understanding of core SQL concepts and my ability to apply them to business data in a clear, structured way.  
Each folder in this repository represents one practice session, focusing on different topics commonly used in data analysis workflows.

## Folder Structure

| Day | Folder | Topics Covered |
|-----|--------|----------------|
| Day 01 | [Day 01 – Intro SQL](./Day%2001%20–%20Intro%20SQL) | Basic SELECT, WHERE conditions |
| Day 02 | [Day 02 – JOINs](./Day%2002%20–%20JOINs) | INNER JOIN, LEFT JOIN, multi-table joins |
| Day 03 | [Day 03 – Aggregation & GROUP BY](./Day%2003%20–%20Aggregation%20%26%20GROUP%20BY) | GROUP BY, HAVING, SUM, COUNT |
| Day 04 | [Day 04 – Advanced Queries](./Day%2004%20–%20Advanced%20Queries) | JOINs with conditions, self-joins, anti-joins |
| Day 05 | [Day 05 – Subqueries & CTEs](./Day%2005%20–%20Subqueries%20%26%20CTEs) | Subqueries, CASE WHEN, classification logic |
| Day 06 | [Day 06 – Final Practice](./Day%2006%20–%20Final%20Practice) | Combined practice, monthly analysis, CTEs |

## Key Concepts Practiced

- Filtering data with `WHERE`, `LIKE`, `IN`, `NOT IN`
- Combining data across tables using `JOIN`, `LEFT JOIN`, `SELF JOIN`
- Aggregating and grouping results with `GROUP BY`, `HAVING`
- Writing nested queries and anti-join logic
- Using `CASE WHEN` to create conditional categories
- Summarizing time-based metrics using `CTE` (Common Table Expressions)
- Working with Fact and Dimension tables in a star-schema model

## Example Query

```sql
SELECT 
    CustomerKey,
    YEAR(OrderDate) AS OrderYear,
    SUM(SalesAmount) AS TotalRevenue
FROM FactInternetSales
GROUP BY CustomerKey, YEAR(OrderDate)
HAVING SUM(SalesAmount) > 5000;
