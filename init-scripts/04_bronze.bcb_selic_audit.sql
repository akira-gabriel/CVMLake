CREATE TABLE IF NOT EXISTS control.bcb_selic_audit (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL
        CONSTRAINT fk_bcb_selic_audit_date
        REFERENCES bronze.bcb_selic(date) ON DELETE RESTRICT,
    old_value NUMERIC(4, 2) NOT NULL,
    new_value NUMERIC(4, 2) NOT NULL,
    old_ingestion_log_id INTEGER NOT NULL
        CONSTRAINT fk_bcb_selic_audit_old_ingestion_log_id
        REFERENCES control.ingestion_log(id) ON DELETE RESTRICT,
    new_ingestion_log_id INTEGER NOT NULL
        CONSTRAINT fk_bcb_selic_audit_new_ingestion_log_id
        REFERENCES control.ingestion_log(id) ON DELETE RESTRICT,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    reviewed_at TIMESTAMPTZ 
);

CREATE INDEX IF NOT EXISTS idx_bcb_selic_audit_new_ingestion_log_id
    ON control.bcb_selic_audit(new_ingestion_log_id);

CREATE INDEX IF NOT EXISTS idx_bcb_selic_audit_pending
    ON control.bcb_selic_audit(changed_at)
    WHERE reviewed_at IS NULL;



CREATE OR REPLACE FUNCTION control.fn_audit_bcb_selic_update()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO control.bcb_selic_audit (
        date, old_value, new_value,
        old_ingestion_log_id, new_ingestion_log_id
    )
    VALUES (
        OLD.date, OLD.value, NEW.value,
        OLD.ingestion_log_id, NEW.ingestion_log_id
    );
    RETURN NULL;
END;
$$;



CREATE TRIGGER trg_bcb_selic_audit
AFTER UPDATE OF value ON bronze.bcb_selic
FOR EACH ROW
WHEN (OLD.value IS DISTINCT FROM NEW.value)
EXECUTE FUNCTION control.fn_audit_bcb_selic_update();