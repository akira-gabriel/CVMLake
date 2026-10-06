CREATE SCHEMA IF NOT EXISTS bronze;

CREATE TABLE bronze.bcb_selic (
    date DATE PRIMARY KEY,
    value NUMERIC(4, 2) NOT NULL,
    ingestion_log_id INTEGER NOT NULL CONSTRAINT fk_bcb_selic_ingestion_log_id REFERENCES control.ingestion_log(id) ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_bcb_selic_ingestion_log_id
    ON bronze.bcb_selic (ingestion_log_id);