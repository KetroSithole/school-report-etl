USE sa_college_stg;
GO

------------------------------------------------------------
-- GRADE 10
------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE s.name = 'bronze' AND t.name = 'prelim_science_students_marks_g10')
BEGIN
    CREATE TABLE bronze.prelim_science_students_marks_g10 (
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

INSERT INTO bronze.prelim_science_students_marks_g10
SELECT
    [student_id],
    [student_name],
    [grade],
    [mathematics_mark],
    [physical_science_mark],
    [life_sciences_mark],
    [english_home_language_mark],
    [life_orientation_mark],
    [information_technology_mark],
    [agricultural_science_mark],
    [total_mark],
    [average_mark]
FROM [sa_college_stg].[bronze].[prelim_science_students_marks]
WHERE grade IN ('10A','10B');
GO

------------------------------------------------------------
-- GRADE 11
------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE s.name = 'bronze' AND t.name = 'prelim_science_students_marks_g11')
BEGIN
    CREATE TABLE bronze.prelim_science_students_marks_g11 (
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

INSERT INTO bronze.prelim_science_students_marks_g11
SELECT
    [student_id],
    [student_name],
    [grade],
    [mathematics_mark],
    [physical_science_mark],
    [life_sciences_mark],
    [english_home_language_mark],
    [life_orientation_mark],
    [information_technology_mark],
    [agricultural_science_mark],
    [total_mark],
    [average_mark]
FROM [sa_college_stg].[bronze].[prelim_science_students_marks]
WHERE grade IN ('11A','11B');
GO

------------------------------------------------------------
-- GRADE 12
------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables t JOIN sys.schemas s ON t.schema_id = s.schema_id
               WHERE s.name = 'bronze' AND t.name = 'prelim_science_students_marks_g12')
BEGIN
    CREATE TABLE bronze.prelim_science_students_marks_g12 (
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

INSERT INTO bronze.prelim_science_students_marks_g12
SELECT
    [student_id],
    [student_name],
    [grade],
    [mathematics_mark],
    [physical_science_mark],
    [life_sciences_mark],
    [english_home_language_mark],
    [life_orientation_mark],
    [information_technology_mark],
    [agricultural_science_mark],
    [total_mark],
    [average_mark]
FROM [sa_college_stg].[bronze].[prelim_science_students_marks]
WHERE grade IN ('12A','12B');
GO