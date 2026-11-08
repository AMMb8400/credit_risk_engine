
-- ==============================================================================
-- Schema Expansion Milestone: Credit Card Asset Integration (3NF child node)
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

CREATE TABLE IF NOT EXISTS credit_cards (
    card_id INT PRIMARY KEY,
    applicant_id INT REFERENCES applicants(applicant_id) ON DELETE RESTRICT,
    credit_limit NUMERIC(12, 2) NOT NULL,
    current_balance NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    card_status VARCHAR(20) DEFAULT 'ACTIVE',
    CONSTRAINT positive_limit CHECK (credit_limit > 0),
    CONSTRAINT balance_under_limit CHECK (current_balance <= credit_limit)
);

-- Seed a sample record for verification testing
INSERT INTO credit_cards (card_id, applicant_id, credit_limit, current_balance, card_status)
VALUES (501, 1, 10000.00, 1250.50, 'ACTIVE')
ON CONFLICT (card_id) DO NOTHING;

-- ==============================================================================
-- Phase 2 Governance: Credit Card State Restrictions & Soft-Deletions
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

-- 1. Apply a check constraint to lock down valid operational states
ALTER TABLE credit_cards
    ADD CONSTRAINT valid_card_status 
    CHECK (card_status IN ('ACTIVE', 'SUSPENDED', 'CANCELLED'));

-- 2. Enforce the Zero-Balance rule to block cancellation of unpaid lines
ALTER TABLE credit_cards
    ADD CONSTRAINT block_active_balance_cancellation 
    CHECK (NOT (card_status = 'CANCELLED' AND current_balance > 0.00));
