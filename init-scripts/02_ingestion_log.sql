CREATE TABLE control.ingestion_log (
    id SERIAL PRIMARY KEY,
    run_id UUID NOT NULL CONSTRAINT fk_ingestion_log REFERENCES control.pipeline_run(id),
    event_timestamp TIMESTAMPTZ NOT NULL,
    dataset VARCHAR(30) NOT NULL,
    status TEXT CHECK (status IN ('success', 'fail')) NOT NULL,
    rows_affected INTEGER NOT NULL DEFAULT 0,
    error_message TEXT
);
CREATE INDEX idx_ingestion_log ON control.ingestion_log(run_id);