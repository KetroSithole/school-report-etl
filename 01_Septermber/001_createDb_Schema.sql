-- Staging database
if not exists (
    select
        1
    from
        sys.databases
    where
        name = 'sa_college_stg'
) create database sa_college_stg;

go
    use sa_college_stg;

go
    if not exists (
        select
            1
        from
            sys.schemas
        where
            name = 'bronze'
    ) execute ('CREATE SCHEMA bronze');

-- raw/dirty data
go
    -- Data warehouse
    if not exists (
        select
            1
        from
            sys.databases
        where
            name = 'sa_college_dwh'
    ) create database sa_college_dwh;

go
    use sa_college_dwh;

go
    if not exists (
        select
            1
        from
            sys.schemas
        where
            name = 'silver'
    ) execute ('CREATE SCHEMA silver');

-- cleaned/conformed data
go
    if not exists (
        select
            1
        from
            sys.schemas
        where
            name = 'gold'
    ) execute ('CREATE SCHEMA gold');

-- business/reporting layer