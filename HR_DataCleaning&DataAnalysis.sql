SELECT * FROM gpthr_att.gptdataset;
describe gptdataset;
use gpthr_att;


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'gptdataset';


show columns from gptdataset;



show create table gptdataset;

-- DATA CLEANING AND ANALYZE DULPICATES

alter table gptdataset
change `ï»¿Employee ID` EmployeeId int ,
change `Age` Age text,
change `Gender` Gender text,
change `Department` Department text,
change `Job Role` JobRole text,
change `MonthlyIncome` MonthlyIncome text,
change `Attrition` Attrition text,
change  `OverTime` OverTime text,
change `WorkLocation` WorkLocation text,
change `EducationLevel` EducationLevel text,
change   `YearsAtCompany` YearsAtCompany text,
change `PerformanceRating` PerformanceRating text,
change   `JobSatisfaction` JobSatisfaction int DEFAULT NULL,
change   `ManagerName` ManagerName text,
change   `HireDate` HireDate text;
 
 select * from gptdataset;
 
 
 SELECT *
FROM gptdataset
LIMIT 10;

SELECT *
FROM gptdataset
WHERE Age = '' 
   OR MonthlyIncome = ''
   OR JobSatisfaction = ''
   OR EmployeeId = ''
   OR PerformanceRating = ''
    OR YearsAtCompany = ''
   OR HireDate ='';


update gptdataset
set 
    Age =nullif(Age,''), 
    MonthlyIncome =nullif(MonthlyIncome,''),
    YearsAtCompany =nullif(YearsAtCompany,''),
    JobSatisfaction =nullif(JobSatisfaction,''),
    PerformanceRating =nullif(PerformanceRating,''),
    HireDate =nullif(HireDate,'');

select count(*) from gptdataset
where YearsAtCompany = '';

alter table gptdataset
modify Age int,
modify MonthlyIncome int,
modify YearsAtCompany int,
modify PerformanceRating int,
modify JobSatisfaction int,
modify HireDate date;



SELECT EmployeeId, COUNT(*)
FROM gptdataset
GROUP BY EmployeeId
HAVING COUNT(*) > 1;

select * from gptdataset
where EmployeeId = 1;


CREATE TABLE gptdataset_clean AS
SELECT DISTINCT *
FROM gptdataset;


drop table gptdataset;

select * from gptdataset_clean;

alter table gptdataset_clean
rename to gptdataset;

ALTER TABLE gptdataset
ADD PRIMARY KEY (EmployeeId);

select distinct Department
from gptdataset;

select distinct Gender
from gptdataset;

select distinct Attrition
from gptdataset;

select distinct OverTime
from gptdataset;


SELECT *
FROM gptdataset
WHERE TRIM(Department) = '';

UPDATE gptdataset
SET 
     Department = TRIM(Department),
     Gender = trim(Gender),
     Attrition = trim(Attrition),
     JobRole = trim(JobRole),
     WorkLocation = trim(WorkLocation),
     EducationLevel = trim(EducationLevel),
     ManagerName = trim(ManagerName),
     OverTime = trim(OverTime);

update gptdataset
set 
   Department = nullif(Department,''),
    Gender = nullif(Gender,''),
     Attrition =nullif(Attrition,''),
     JobRole = nullif(JobRole,''),
     WorkLocation =nullif(WorkLocation,''),
     EducationLevel =nullif(EducationLevel,''),
     ManagerName = nullif(ManagerName,''),
     OverTime = nullif(OverTime,'');


update gptdataset
set Department = upper(Department),
    Gender = upper(Gender),
    Attrition = upper(Attrition),
    OverTime = upper(OverTime);
    
select HireDate
from gptdataset
limit 100;


SELECT *
FROM gptdataset
WHERE Age IS NULL 
   OR MonthlyIncome IS NULL;
   
   
   select count(*)
   from gptdataset
   where Age is NULL;
   
update gptdataset
set
    MonthlyIncome = 11105,
     YearsAtCompany = 10,
      PerformanceRating = 3,
      JobSatisfaction =  3,
      Gender = 'Unknown',
      Attrition = 'Unknown',
      Department = 'Unknown',
      Age = 40
   where Age is NULL
   or MonthlyIncome is null
   or YearsAtCompany  is null
   or PerformanceRating is null
   or JobSatisfaction is null
   or Gender is null
   or Department is null
   or Attrition is null;
   
select avg(Age),
       avg(MonthlyIncome),
       avg(YearsAtCompany),
       avg(PerformanceRating),
       avg(JobSatisfaction) from gptdataset;



-- EXPLORATORY DATA ANALYSIS

-- Dataset size
select count(*) as TotalEmployee
from gptdataset;

-- Employee count
select Gender,count(*) as EmployeeCount
from gptdataset
group by Gender;

-- Employees by Department
select Department,count(*) as EmployeeCount
from gptdataset
group by Department
order by count(*) desc;

-- Attrition count
SELECT Attrition, COUNT(*) AS Employees
FROM gptdataset
GROUP BY Attrition;

select count(*) from gptdataset
where Attrition = 'NO';

-- Attrition by Department
SELECT Department, Attrition, COUNT(*) AS Employees
FROM gptdataset
GROUP BY Department, Attrition;

-- Attrition VS Overtiime
select OverTime,Attrition,count(*) as Employees
from gptdataset
group by OverTime,Attrition;

-- Average salary
select avg(MonthlyIncome) as AverageSalary
from gptdataset;

-- Department wise salary 
select Department,avg(MonthlyIncome) as AverageSalary
from gptdataset
group by Department
order by avg(MonthlyIncome) desc;

--  Salary by jobrole
select JobRole,avg(MonthlyIncome) as AverageSalary
from gptdataset
group by JobRole
order by avg(MonthlyIncome) desc;

-- Average years at company
SELECT AVG(YearsAtCompany) AS AvgExperience
FROM gptdataset;

-- Experience from department
select Department,avg(YearsAtCompany)as AverageExperience 
from gptdataset
group by Department;

-- Employees Hired per Year
SELECT YEAR(HireDate) AS HireYear, COUNT(*) AS Employees
FROM gptdataset
GROUP BY YEAR(HireDate)
ORDER BY HireYear;




SELECT * FROM gptdataset;

select min(MonthlyIncome) from gptdataset