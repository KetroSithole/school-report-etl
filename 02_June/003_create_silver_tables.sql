USE sa_college_dwh;
GO

------------------------------------------------------------
-- GRADE 10
------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE s.name = 'silver' AND t.name = 'prelim_science_students_marks_g10')
BEGIN
    CREATE TABLE silver.prelim_science_students_marks_g10 (
        student_id                    NVARCHAR(50),
        student_name                  NVARCHAR(200),
        grade                         NVARCHAR(10),
        mathematics_mark              DECIMAL(5,2),
        physical_science_mark         DECIMAL(5,2),
        life_sciences_mark            DECIMAL(5,2),
        english_home_language_mark    DECIMAL(5,2),
        life_orientation_mark         DECIMAL(5,2),
        information_technology_mark   DECIMAL(5,2),
        agricultural_science_mark     DECIMAL(5,2),
        total_mark                    DECIMAL(6,2),
        average_mark                  DECIMAL(5,2)
    );
END
GO

INSERT INTO silver.prelim_science_students_marks_g10
SELECT
    A.[student_id],
    A.[student_name],
    A.[grade],
    A.[mathematics_mark],
    A.[physical_science_mark],
    A.[life_sciences_mark],
    A.[english_home_language_mark],
    A.[life_orientation_mark],
    A.[information_technology_mark],
    A.[agricultural_science_mark],
    A.[total_mark],
    A.[average_mark]
FROM [sa_college_stg].bronze.[prelim_science_students_marks] AS A
WHERE A.grade IN ('10A','10B')
  AND NOT EXISTS (
        SELECT 1
        FROM [sa_college_dwh].[silver].[prelim_science_students_marks_g10] AS B
        WHERE A.student_id = B.student_id
  );
GO

------------------------------------------------------------
-- GRADE 11
------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE s.name = 'silver' AND t.name = 'prelim_science_students_marks_g11')
BEGIN
    CREATE TABLE silver.prelim_science_students_marks_g11 (
        student_id                    NVARCHAR(50),
        student_name                  NVARCHAR(200),
        grade                         NVARCHAR(10),
        mathematics_mark              DECIMAL(5,2),
        physical_science_mark         DECIMAL(5,2),
        life_sciences_mark            DECIMAL(5,2),
        english_home_language_mark    DECIMAL(5,2),
        life_orientation_mark         DECIMAL(5,2),
        information_technology_mark   DECIMAL(5,2),
        agricultural_science_mark     DECIMAL(5,2),
        total_mark                    DECIMAL(6,2),
        average_mark                  DECIMAL(5,2)
    );
END
GO

INSERT INTO silver.prelim_science_students_marks_g11
SELECT
    A.[student_id],
    A.[student_name],
    A.[grade],
    A.[mathematics_mark],
    A.[physical_science_mark],
    A.[life_sciences_mark],
    A.[english_home_language_mark],
    A.[life_orientation_mark],
    A.[information_technology_mark],
    A.[agricultural_science_mark],
    A.[total_mark],
    A.[average_mark]
FROM [sa_college_stg].bronze.[prelim_science_students_marks] AS A
WHERE A.grade IN ('11A','11B')
  AND NOT EXISTS (
        SELECT 1
        FROM [sa_college_dwh].[silver].[prelim_science_students_marks_g11] AS B
        WHERE A.student_id = B.student_id
  );
GO

------------------------------------------------------------
-- GRADE 12
------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE s.name = 'silver' AND t.name = 'prelim_science_students_marks_g12')
BEGIN
    CREATE TABLE silver.prelim_science_students_marks_g12 (
        student_id                    NVARCHAR(50),
        student_name                  NVARCHAR(200),
        grade                         NVARCHAR(10),
        mathematics_mark              DECIMAL(5,2),
        physical_science_mark         DECIMAL(5,2),
        life_sciences_mark            DECIMAL(5,2),
        english_home_language_mark    DECIMAL(5,2),
        life_orientation_mark         DECIMAL(5,2),
        information_technology_mark   DECIMAL(5,2),
        agricultural_science_mark     DECIMAL(5,2),
        total_mark                    DECIMAL(6,2),
        average_mark                  DECIMAL(5,2)
    );
END
GO

INSERT INTO silver.prelim_science_students_marks_g12
SELECT
    A.[student_id],
    A.[student_name],
    A.[grade],
    A.[mathematics_mark],
    A.[physical_science_mark],
    A.[life_sciences_mark],
    A.[english_home_language_mark],
    A.[life_orientation_mark],
    A.[information_technology_mark],
    A.[agricultural_science_mark],
    A.[total_mark],
    A.[average_mark]
FROM [sa_college_stg].bronze.[prelim_science_students_marks] AS A
WHERE A.grade IN ('12A','12B')
  AND NOT EXISTS (
        SELECT 1
        FROM [sa_college_dwh].[silver].[prelim_science_students_marks_g12] AS B
        WHERE A.student_id = B.student_id
  );
GO