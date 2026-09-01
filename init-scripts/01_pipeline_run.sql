CREATE SCHEMA IF NOT EXISTS control;

CREATE TABLE control.pipeline_run (
    id UUID PRIMARY KEY,
    dataset TEXT NOT NULL,
    started_at TIMESTAMPTZ  NOT NULL,
    finished_at TIMESTAMPTZ NULL,
    CONSTRAINT chk_pipeline_temporal CHECK (finished_at >= started_at),
    status TEXT CONSTRAINT chk_pipeline_run_status CHECK (status IN ('running','success','partial_success','fail')) DEFAULT 'running' NOT NULL
);