# Data cleaning using SQL
create database mental_health;
select * from mental_health.survey;
# Removing unnecessary columns
ALTER TABLE mental_health.survey
DROP COLUMN Timestamp,
DROP COLUMN comments;

#Data Cleaning
#Removing the null values
SELECT * 
FROM mental_health.survey
WHERE age IS NOT NULL AND gender IS NOT NULL;

#Standardizing the gender column
UPDATE mental_health.survey
SET gender = LOWER(TRIM(gender))
WHERE gender IS NOT NULL;

-- Standardize male labels
UPDATE mental_health.survey
SET gender = 'male'
WHERE gender IN ('m', 'male', 'cis male', 'man', 'male-ish', 'mal', 'maile', 'msle', 'make');

-- Standardize female labels
UPDATE mental_health.survey
SET gender = 'female'
WHERE gender IN ('f', 'female', 'cis female', 'woman', 'femail', 'femake', 'female ', 'cis-female/femme');
-- Replace all others with 'other'
UPDATE mental_health.survey
SET gender = 'other'
WHERE gender NOT IN ('male', 'female');

#Age related issues
SELECT MIN(age), MAX(age) FROM mental_health.survey;
DELETE FROM mental_health.survey
WHERE age < 18 OR age > 65;

#Distribution of mental health conditions
SELECT mental_health_consequence, COUNT(*) AS total
FROM mental_health.survey
GROUP BY mental_health_consequence
ORDER BY total DESC;

#Average age of people who sought treatment
SELECT AVG(age) AS avg_age_treatment
FROM mental_health.survey
WHERE treatment = 'Yes';

#Remote work impact
SELECT remote_work, COUNT(*) AS total
FROM mental_health.survey
WHERE treatment = 'Yes'
GROUP BY remote_work;
SET SQL_SAFE_UPDATES = 0;

-- People seeking mental health treatment by gender
SELECT gender, COUNT(*) AS total,
       SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) AS seeking_treatment
FROM mental_health.survey
GROUP BY gender;
-- Remote work vs mental health benefits
SELECT remote_work, COUNT(*) AS total_responses,
       SUM(CASE WHEN benefits = 'Yes' THEN 1 ELSE 0 END) AS has_benefits
FROM mental_health.survey
GROUP BY remote_work;
-- Employer providing mental health resources
SELECT COUNT(*) AS total,
       SUM(CASE WHEN mental_health_interview = 'Yes' THEN 1 ELSE 0 END) AS open_in_interview,
       SUM(CASE WHEN wellness_program = 'Yes' THEN 1 ELSE 0 END) AS has_wellness_program
FROM mental_health.survey;

-- Country-wise responses
SELECT Country, COUNT(*) AS respondents
FROM mental_health.survey
GROUP BY Country
ORDER BY respondents DESC;

--  Work interference due to mental health
SELECT work_interfere, COUNT(*) AS count
FROM mental_health.survey
GROUP BY work_interfere
ORDER BY count DESC;
select* from mental_health.survey;
