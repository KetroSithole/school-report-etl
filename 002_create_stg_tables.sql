
  ---------grade 10 
select [student_id],
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
from   [sa_college_stg].[bronze].[prelim_science_students_marks]
where  grade in ('10A', '10B');

-- grade 11 table 
select [student_id],
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
from   [sa_college_stg].[bronze].[prelim_science_students_marks]
where  grade in ('11A', '11B');

-- grade 12 
select [student_id],
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
from   [sa_college_stg].[bronze].[prelim_science_students_marks]
where  grade in ('12A', '12B');