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

-- ==============================================================================
-- Banking Ledger Automation: Atomic Balance Adjustments via Transactions
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

BEGIN;

-- 1. Stream a new chronological repayment record into the append-only ledger
INSERT INTO loan_payments (payment_id, loan_id, payment_amount, payment_date, is_late_payment)
VALUES (999, 1, 550.00, CURRENT_DATE, FALSE);

-- 2. Simultaneously update the master contract parameters to reduce liability debt
UPDATE loans
SET loan_amount = loan_amount - 550.00
WHERE loan_id = 1;

-- 3. Verify balance parity within the isolated transaction state memory
SELECT loan_id, loan_amount, loan_status FROM loans WHERE loan_id = 1;

-- 4. Formally commit all changes to the physical disk storage nodes
COMMIT;

-- ==============================================================================
-- Banking Ledger Automation: Atomic Balance Adjustments via Transactions
-- Phase 2 Milestone: ACID Compliance Engine
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

BEGIN;

-- 1. Stream a new chronological repayment record into the append-only ledger
INSERT INTO loan_payments (payment_id, loan_id, payment_amount, payment_date, is_late_payment)
VALUES (999, 1, 550.00, CURRENT_DATE, FALSE);

-- 2. Simultaneously update the master contract parameters to reduce liability debt
UPDATE loans
SET loan_amount = loan_amount - 550.00
WHERE loan_id = 1;

-- 3. Verify balance parity within the isolated transaction state memory
SELECT loan_id, loan_amount, loan_status FROM loans WHERE loan_id = 1;

-- 4. Formally commit all changes to the physical disk storage nodes
COMMIT;
