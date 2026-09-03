CREATE TABLE control.ingestion_log (
    id SERIAL PRIMARY KEY,
    run_id UUID NOT NULL CONSTRAINT fk_ingestion_log_run_id REFERENCES control.pipeline_run(id) ON DELETE RESTRICT,
    event_timestamp TIMESTAMPTZ NOT NULL,
    dataset VARCHAR(30) NOT NULL,
    status TEXT CHECK (status IN ('success', 'fail')) NOT NULL,
    rows_affected INTEGER NOT NULL DEFAULT 0,
    error_message TEXT
);
CREATE INDEX idx_ingestion_log_run_id ON control.ingestion_log(run_id);