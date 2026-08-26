CREATE SCHEMA IF NOT EXISTS control;

CREATE TABLE control.ingestion_log (
    id SERIAL PRIMARY KEY,
    event_timestamp TIMESTAMPTZ NOT NULL,
    dataset VARCHAR(30) NOT NULL,
    status TEXT CHECK (status IN ('success', 'fail')) NOT NULL,
    rows_affected INTEGER NOT NULL DEFAULT 0,
    error_message TEXT
);