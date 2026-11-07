-- ==============================================================================
-- Phase 2 Enterprise Hardening: Fixed Precision Upgrade & Banking Ledgers
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

-- 1. Modify physical column nodes to enforce exact base-10 decimal scales
ALTER TABLE loans 
    ALTER COLUMN loan_amount TYPE NUMERIC(12, 2),
    ALTER COLUMN monthly_installment TYPE NUMERIC(12, 2);

ALTER TABLE loan_payments 
    ALTER COLUMN payment_amount TYPE NUMERIC(12, 2);

-- 2. Establish an institutional credit firebreak rule
ALTER TABLE loans
    ADD CONSTRAINT enforced_lending_ceiling CHECK (loan_amount <= 500000.00);

-- 3. Extract the updated dictionary metadata to verify hardware precision scale
SELECT table_name, column_name, data_type, numeric_precision, numeric_scale
FROM information_schema.columns
WHERE table_name IN ('loans', 'loan_payments')
  AND column_name IN ('loan_amount', 'monthly_installment', 'payment_amount');
