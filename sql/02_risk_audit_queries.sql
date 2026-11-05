-- ==============================================================================
-- Portfolio Risk Exposure Audit: High-Risk FICO Filter (< 600)
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

SELECT 
    a.applicant_id,
    a.legal_name,
    a.monthly_income,
    a.credit_score_fico,
    l.loan_amount,
    l.monthly_installment,
    l.loan_status
FROM applicants a
INNER JOIN loans l 
    ON a.applicant_id = l.applicant_id
WHERE a.credit_score_fico < 600
ORDER BY a.credit_score_fico DESC;
