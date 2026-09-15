# Prelim Science Marks — Data Warehouse Project Spec

Source file: `prelim_science_students_marks.csv` (100 students, 7 subjects,
wide format). **This is the only file provided.** You split it and build
the layers yourself — nothing below is pre-built for you.

## Goal

Take the flat CSV and produce a Bronze → Silver → Gold warehouse, split
by grade band (10 / 11 / 12), following the Medallion Architecture.

---

## 1. Target pipeline (flow)

```mermaid
flowchart LR
    A[Source CSV\nprelim_science_students_marks.csv] --> B{Split by grade_band}
    B --> B10[Grade 10 subset]
    B --> B11[Grade 11 subset]
    B --> B12[Grade 12 subset]

    B10 --> S10[bronze.grade_10_raw]
    B11 --> S11[bronze.grade_11_raw]
    B12 --> S12[bronze.grade_12_raw]

    S10 --> C10[silver.grade_10_cleaned]
    S11 --> C11[silver.grade_11_cleaned]
    S12 --> C12[silver.grade_12_cleaned]

    C10 --> G1[gold.grade_summary]
    C11 --> G1
    C12 --> G1

    C10 --> G2[gold.subject_performance]
    C11 --> G2
    C12 --> G2
```

---

## 2. Target schema (per layer)

```mermaid
erDiagram
    BRONZE_GRADE_RAW {
        string student_id
        string student_name
        string grade
        int mathematics_mark
        int physical_science_mark
        int life_sciences_mark
        int english_home_language_mark
        int life_orientation_mark
        int information_technology_mark
        int agricultural_science_mark
        int total_mark
        float average_mark
    }

    SILVER_GRADE_CLEANED {
        string student_id
        string student_name
        string grade
        string grade_band
        int mathematics_mark
        int physical_science_mark
        int life_sciences_mark
        int english_home_language_mark
        int life_orientation_mark
        int information_technology_mark
        int agricultural_science_mark
        int total_mark
        float average_mark
        int subjects_failed
        string overall_result
    }

    GOLD_GRADE_SUMMARY {
        string grade_band
        int student_count
        float avg_of_averages
        int pass_count
        int fail_count
        float pass_rate_pct
    }

    GOLD_SUBJECT_PERFORMANCE {
        string grade_band
        string subject
        float avg_mark
        int min_mark
        int max_mark
        int fail_count
    }

    BRONZE_GRADE_RAW ||--o{ SILVER_GRADE_CLEANED : "cleaned into"
    SILVER_GRADE_CLEANED ||--o{ GOLD_GRADE_SUMMARY : "aggregated into"
    SILVER_GRADE_CLEANED ||--o{ GOLD_SUBJECT_PERFORMANCE : "aggregated into"
```

---

## 3. What each layer must do

### Bronze — raw, split, untouched
- Split the source CSV into 3 files/tables by grade band (10, 11, 12).
- No cleaning, no casting, no new columns — copy values as-is.
- Purpose: preserve exactly what was received, per grade, so any
  downstream bug can be traced back to unmodified source data.

### Silver — cleaned, typed, conformed
- Trim/title-case `student_name`.
- Cast all 7 subject marks to integers.
- Add `grade_band` (derived from `grade`, e.g. "10A" → "10").
- Derive `subjects_failed` = count of subjects with mark < 40.
- Derive `overall_result` = `"FAIL"` if `subjects_failed > 0` else `"PASS"`.
- Still split by grade band, one clean table per grade.

### Gold — aggregated, reporting-ready
- `grade_summary`: one row per grade band — student count, average of
  averages, pass count, fail count, pass rate %.
- `subject_performance`: one row per grade band × subject — average,
  min, max mark, and fail count for that subject.
- No row-level student detail at this layer — only aggregates.

---

## 4. What's expected of you

1. **Split the source CSV yourself** into 3 grade-band subsets — this is
   the point of the exercise, so no split files are provided.
2. **Build bronze**: land each grade subset as-is (no transformation).
3. **Build silver**: write the SQL/Python that produces the cleaned
   schema above from bronze — including the pass/fail logic, and be
   ready to justify the 40-mark threshold you use.
4. **Build gold**: aggregate silver into `grade_summary` and
   `subject_performance` using GROUP BY logic — don't compute these
   straight from the source CSV.
5. **Preserve grade_band lineage** end-to-end — no student should lose
   or change grade band between layers.
6. **Submit**: your split/load scripts, transformation scripts,
   aggregation scripts, the resulting tables, and a short note on any
   data quality issue you spotted (outlier marks, duplicate names, etc.)
   and how you handled it.

The diagrams above are the **target shape only** — you produce the
actual tables.
