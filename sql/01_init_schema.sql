
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
