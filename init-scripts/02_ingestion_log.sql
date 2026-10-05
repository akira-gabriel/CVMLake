CREATE TABLE IF NOT EXISTS control.ingestion_log(
    id SERIAL PRIMARY KEY,
    run_id UUID NOT NULL CONSTRAINT fk_ingestion_log_run_id REFERENCES control.pipeline_run(id) ON DELETE RESTRICT,
    event_timestamp TIMESTAMPTZ NOT NULL,
    dataset VARCHAR(30) NOT NULL,
    period_start DATE NOT NULL,
    period_end DATE NOT NULL,
    status TEXT CHECK (status IN ('success', 'fail')) NOT NULL,
    rows_affected INTEGER NOT NULL DEFAULT 0,
    error_message TEXT,
    CONSTRAINT ck_ingestion_log_period CHECK (period_end >= period_start)
);

CREATE INDEX IF NOT EXISTS idx_ingestion_log_marker
    ON control.ingestion_log (dataset, status, period_end);