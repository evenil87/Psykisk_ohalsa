-- raw table for csv

DROP TABLE IF EXISTS students_raw;

CREATE TABLE students_raw (
  id INTEGER,
  Gender TEXT,
  Age REAL,
  City TEXT,
  Profession TEXT,
  Academic_Pressure REAL,
  Work_Pressure REAL,
  CGPA REAL,
  Study_Satisfaction REAL,
  Job_Satisfaction REAL,
  Sleep_Duration TEXT,
  Dietary_Habits TEXT,
  Degree TEXT,
  Suicidal_Thoughts TEXT,
  Work_Study_Hours REAL,
  Financial_Stress REAL,
  Family_History_Mental_Illness TEXT,
  Depression TEXT
);

-- transform for analytics

DROP VIEW IF EXISTS students_clean;

CREATE VIEW students_clean AS
SELECT
  id,
  LOWER(TRIM(Gender)) AS gender,
  CAST(Age AS REAL) AS age,
  LOWER(TRIM(City)) AS city,
  LOWER(TRIM(Profession)) AS profession,

  -- try-cast if float in CSV, else null
  CASE WHEN Academic_Pressure='' THEN NULL ELSE CAST(Academic_Pressure AS REAL) END AS academic_pressure,
  CASE WHEN Work_Pressure='' THEN NULL ELSE CAST(Work_Pressure AS REAL) END AS work_pressure,
  CASE WHEN CGPA='' THEN NULL ELSE CAST(CGPA AS REAL) END AS cgpa,
  CASE WHEN Study_Satisfaction='' THEN NULL ELSE CAST(Study_Satisfaction AS REAL) END AS study_satisfaction,
  CASE WHEN Job_Satisfaction='' THEN NULL ELSE CAST(Job_Satisfaction AS REAL) END AS job_satisfaction,

  -- Sleep duration text -> hours
  CASE
    WHEN lower(Sleep_Duration) LIKE '%less than 5%' OR lower(Sleep_Duration) LIKE '%<5%' THEN 4.5
    WHEN lower(Sleep_Duration) LIKE '%5-6%' OR lower(Sleep_Duration) LIKE '%5 to 6%' THEN 5.5
    WHEN lower(Sleep_Duration) LIKE '%6-7%' OR lower(Sleep_Duration) LIKE '%6 to 7%' THEN 6.5
    WHEN lower(Sleep_Duration) LIKE '%7-8%' OR lower(Sleep_Duration) LIKE '%7 to 8%' THEN 7.5
    WHEN lower(Sleep_Duration) LIKE '%8-9%' OR lower(Sleep_Duration) LIKE '%8 to 9%' THEN 8.5
    WHEN lower(Sleep_Duration) LIKE '%more than 9%' OR lower(Sleep_Duration) LIKE '%>9%' THEN 9.5
    WHEN Sleep_Duration GLOB '[0-9]*' THEN CAST(Sleep_Duration AS REAL)
    ELSE NULL
  END AS sleep_hours,

  CASE
    WHEN lower(Dietary_Habits) LIKE '%healthy%' THEN 'healthy'
    WHEN lower(Dietary_Habits) LIKE '%unhealthy%' THEN 'unhealthy'
    ELSE lower(trim(Dietary_Habits))
  END AS dietary,

  LOWER(TRIM(Degree)) AS degree,

  CASE
    WHEN lower(trim(Suicidal_Thoughts)) LIKE '%yes%' THEN 1
    WHEN lower(trim(Suicidal_Thoughts)) LIKE '%no%' THEN 0
    ELSE NULL
  END AS suicidal_ever,

  CASE WHEN Work_Study_Hours='' THEN NULL ELSE CAST(Work_Study_Hours AS REAL) END AS work_study_hours,
  CASE WHEN Financial_Stress='' THEN NULL ELSE CAST(Financial_Stress AS REAL) END AS financial_stress,

  CASE
    WHEN lower(trim(Family_History_Mental_Illness)) LIKE '%yes%' THEN 1
    WHEN lower(trim(Family_History_Mental_Illness)) LIKE '%no%' THEN 0
    ELSE NULL
  END AS family_history,

  CASE
    WHEN lower(trim(Depression)) LIKE '%yes%' THEN 1
    WHEN lower(trim(Depression)) LIKE '%no%' THEN 0
    ELSE NULL
  END AS depressed

FROM students_raw;