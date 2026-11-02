-- Cancer Patient Data - SQL Project
-- Database: cancerpatientdata

-- Q1. How many records are there?
SELECT COUNT(*) FROM cancerpatientdata;

-- Q2. How many patients by gender?
SELECT gender, COUNT(gender) FROM cancerpatientdata GROUP BY gender;

-- Q3. What is the average age?
SELECT AVG(age) FROM cancerpatientdata;

-- Q4. Which patient is oldest?
SELECT age, gender, tumor_type FROM cancerpatientdata ORDER BY age DESC LIMIT 1;

-- Q5. Average age by tumor type and gender
SELECT tumor_type, gender, AVG(age) FROM cancerpatientdata GROUP BY tumor_type, gender;

-- Q6. Most common cancer type in each age group
SELECT CASE WHEN age < 30 THEN 'under 30' WHEN age BETWEEN 30 AND 50 THEN '30-50' ELSE 'over 50' END AS age_group, cancer_stage, COUNT(*) FROM cancerpatientdata GROUP BY age_group, cancer_stage;
