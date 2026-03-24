use hr_employee_attirivation;

-- 1. DATA LOADING

CREATE TABLE new_hr_employee_attrition AS
SELECT * FROM `hr-employee-attrition`;

select * from new_hr_employee_attrition;

-- 2. DATA CLEANING

	-- Fix column name issue
ALTER TABLE new_hr_employee_attrition              
CHANGE COLUMN `ï»¿Age` Age INT;                    


	-- Check NULL values
SELECT *                                           
FROM new_hr_employee_attrition
WHERE 
    Age IS NULL OR
    Attrition IS NULL OR
    BusinessTravel IS NULL OR
    DailyRate IS NULL OR
    Department IS NULL OR
    DistanceFromHome IS NULL OR
    Education IS NULL OR
    EducationField IS NULL OR
    EmployeeCount IS NULL OR
    EmployeeNumber IS NULL OR
    EnvironmentSatisfaction IS NULL OR
    Gender IS NULL OR
    HourlyRate IS NULL OR
    JobInvolvement IS NULL OR
    JobLevel IS NULL OR
    JobRole IS NULL OR
    JobSatisfaction IS NULL OR
    MaritalStatus IS NULL OR
    MonthlyIncome IS NULL OR
    MonthlyRate IS NULL OR
    NumCompaniesWorked IS NULL OR
    Over18 IS NULL OR
    OverTime IS NULL OR
    PercentSalaryHike IS NULL OR
    PerformanceRating IS NULL OR
    RelationshipSatisfaction IS NULL OR
    StandardHours IS NULL OR
    StockOptionLevel IS NULL OR
    TotalWorkingYears IS NULL OR
    TrainingTimesLastYear IS NULL OR
    WorkLifeBalance IS NULL OR
    YearsAtCompany IS NULL OR
    YearsInCurrentRole IS NULL OR
    YearsSinceLastPromotion IS NULL OR
    YearsWithCurrManager IS NULL;                   -- no null values
    
    -- Check duplicates
SELECT EmployeeNumber, COUNT(*) as count
FROM new_hr_employee_attrition
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;                                -- all unique employees


SET SQL_SAFE_UPDATES = 0;

-- 3. DATA UNDERSTANDING

SELECT Attrition, COUNT(*) FROM new_hr_employee_attrition GROUP BY Attrition; -- yes 237/ no 1233


SELECT OverTime, COUNT(*) FROM new_hr_employee_attrition GROUP BY OverTime; -- yes 416/ no 1054


SELECT Gender, COUNT(*) FROM new_hr_employee_attrition GROUP BY Gender; -- female 588/ male 882


SELECT BusinessTravel, COUNT(*) FROM new_hr_employee_attrition GROUP BY BusinessTravel;
-- travel_rarely-1043 /travel_frequently-277/ non-travel-150


SELECT Department, COUNT(*) FROM new_hr_employee_attrition GROUP BY Department;
-- sales 446/r&d -961/hr-63

SELECT JobRole, COUNT(*) FROM new_hr_employee_attrition GROUP BY JobRole; 
-- top jobroles are sales executive, research scientist, lab technicinas 


-- 4. FEATURE ENGINEERING

	-- Experience Group
ALTER TABLE new_hr_employee_attrition ADD ExperienceGroup VARCHAR(20);

UPDATE new_hr_employee_attrition
SET ExperienceGroup =
    CASE 
        WHEN YearsAtCompany < 2 THEN '0-2 Years'
        WHEN YearsAtCompany < 5 THEN '2-5 Years'
        ELSE '5+ Years'
    END;
    
select  ExperienceGroup,count(*)
from new_hr_employee_attrition
group by ExperienceGroup ;

	-- Role Experience
ALTER TABLE new_hr_employee_attrition ADD RoleExperience VARCHAR(20);

ALTER TABLE new_hr_employee_attrition ADD RoleExperience VARCHAR(20);

UPDATE new_hr_employee_attrition
SET RoleExperience =
    CASE 
        WHEN YearsInCurrentRole < 2 THEN 'New'
        WHEN YearsInCurrentRole < 5 THEN 'Experienced'
        ELSE 'Long-Term'
    END;
    
select  RoleExperience,count(*)
from new_hr_employee_attrition
group by RoleExperience ;

	-- Promotion Status
ALTER TABLE new_hr_employee_attrition ADD PromotionStatus VARCHAR(20);

UPDATE new_hr_employee_attrition
SET PromotionStatus =
    CASE 
        WHEN YearsSinceLastPromotion <= 1 THEN 'Recently Promoted'
        WHEN YearsSinceLastPromotion <= 3 THEN 'Moderate Gap'
        ELSE 'Long Gap'
    END;

select  PromotionStatus,count(*)
from new_hr_employee_attrition
group by PromotionStatus;

	-- Income Group
ALTER TABLE new_hr_employee_attrition ADD IncomeGroup VARCHAR(20);

UPDATE new_hr_employee_attrition
SET IncomeGroup =
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome < 8000 THEN 'Medium'
        ELSE 'High'
    END;
    
select  IncomeGroup,count(*)
from new_hr_employee_attrition
group by IncomeGroup;

	-- Work-Life Risk
ALTER TABLE new_hr_employee_attrition ADD WorkLifeRisk VARCHAR(20);

UPDATE new_hr_employee_attrition
SET WorkLifeRisk =
    CASE 
        WHEN WorkLifeBalance <= 2 THEN 'Poor'
        ELSE 'Good'
    END;
        
select   WorkLifeRisk,count(*)
from new_hr_employee_attrition
group by  WorkLifeRisk;

	-- Overtime Risk
ALTER TABLE new_hr_employee_attrition ADD OvertimeRisk VARCHAR(20);

UPDATE new_hr_employee_attrition
SET OvertimeRisk =
    CASE 
        WHEN OverTime = 'Yes' THEN 'High'
        ELSE 'Low'
    END;

select OvertimeRisk,count(*)
from new_hr_employee_attrition
group by  OvertimeRisk;

	-- Distance Category
ALTER TABLE new_hr_employee_attrition ADD DistanceCategory VARCHAR(20);

UPDATE new_hr_employee_attrition
SET DistanceCategory =
    CASE 
        WHEN DistanceFromHome < 5 THEN 'Near'
        WHEN DistanceFromHome < 15 THEN 'Medium'
        ELSE 'Far'
    END;
    
select DistanceCategory,count(*)
from new_hr_employee_attrition
group by  DistanceCategory;

	-- Satisfaction Level
ALTER TABLE new_hr_employee_attrition ADD SatisfactionLevel VARCHAR(20);

UPDATE new_hr_employee_attrition
SET SatisfactionLevel =
    CASE 
        WHEN JobSatisfaction <= 2 THEN 'Low'
        ELSE 'High'
    END;
    
select SatisfactionLevel,count(*)
from new_hr_employee_attrition
group by SatisfactionLevel;


-- 5. BUSINESS ANALYSIS
	
	-- 1. Overall Attrition Rate
SELECT 
    COUNT(CASE WHEN Attrition='Yes' THEN 1 END)*100.0/COUNT(*) AS attrition_rate
FROM new_hr_employee_attrition;

	-- 2. Attrition by Department

SELECT Department,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition,
       ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS attrition_rate
FROM new_hr_employee_attrition
GROUP BY Department;

	-- 3. Attrition by Income
    
SELECT  IncomeGroup,
	COUNT(*) AS total,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition,
    ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS attrition_rate
FROM new_hr_employee_attrition
GROUP BY IncomeGroup;

	--  4. Attrition by OvertimeRisk

SELECT OvertimeRisk,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition,
       ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS attrition_rate
FROM new_hr_employee_attrition
GROUP BY OvertimeRisk;

	-- 5. Attrition by WorkLifeRisk

SELECT WorkLifeRisk,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition,
       ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS attrition_rate
FROM new_hr_employee_attrition
GROUP BY WorkLifeRisk;
    
-- 6. Attrition by ExperienceGroup

SELECT ExperienceGroup,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition,
       ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS attrition_rate
FROM new_hr_employee_attrition
GROUP BY ExperienceGroup;

-- 7. Attrition by PromotionStatus

SELECT PromotionStatus,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition,
       ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS attrition_rate
FROM new_hr_employee_attrition
GROUP BY PromotionStatus;

-- It was observed that recently promoted peoples also have a high attriation so calculation(PromotionStatus, OvertimeRisk, IncomeGroup) 

SELECT PromotionStatus, OvertimeRisk, IncomeGroup,  SatisfactionLevel,
       COUNT(*) AS total,
       SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS attrition,
       ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS attrition_rate
FROM new_hr_employee_attrition
GROUP BY PromotionStatus, OvertimeRisk, IncomeGroup,SatisfactionLevel;

-- Key Observations
-- 1.Overall attrition rate is around ~16%, indicating moderate employee turnover.
-- 2.Employees in the low-income group have the highest attrition rates.
-- 3.Overtime significantly increases the likelihood of employee attrition.
-- 4.Poor work-life balance is strongly associated with higher attrition.
-- 5.Employees in their early tenure (0–2 years) are more likely to leave.
-- 6.Recently promoted employees also exhibit notable attrition levels.
-- 7.Certain departments (e.g., Sales) experience higher attrition than others.
-- 8.Low job satisfaction is a key factor contributing to employee exits.
-- 9.Long gaps in promotion can also lead to increased attrition.
-- 10.Highest attrition occurs when multiple factors combine (low income + overtime + low satisfaction).
