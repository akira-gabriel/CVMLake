CREATE SCHEMA IF NOT EXISTS bronze;

CREATE TABLE bronze.bcb_selic (
    date DATE PRIMARY KEY,
    value NUMERIC(4, 2) NOT NULL,
    ingestion_log_id INTEGER NOT NULL REFERENCES control.ingestion_log(id)
);