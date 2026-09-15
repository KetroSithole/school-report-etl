-- =========================================================
-- STAGING DATABASE
-- Holds raw / dirty data as landed from source systems
-- =========================================================
CREATE DATABASE curro_stg;

USE curro_stg;
-- Bronze layer: raw ingested data, untransformed
CREATE SCHEMA bronze;

-- =========================================================
-- DATA WAREHOUSE (DWH)
-- Holds clean, modeled data for reporting/analytics
-- =========================================================
CREATE DATABASE curro_dwh;

USE curro_dwh;

-- Silver layer: cleaned, validated, conformed data
CREATE SCHEMA silver;

-- Gold layer: business-ready, aggregated/curated data for consumption
CREATE SCHEMA gold;