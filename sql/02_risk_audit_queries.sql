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

-- ==============================================================================
-- Portfolio Aggregation Summary: Risk Tranche Capital Exposure
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

SELECT 
    CASE 
        WHEN a.credit_score_fico >= 700 THEN 'PRIME (LOW RISK)'
        ELSE 'SUBPRIME (HIGH RISK)'
    END AS risk_tranche,
    COUNT(l.loan_id) AS total_active_loans,
    SUM(l.loan_amount) AS total_capital_exposure,
    AVG(l.monthly_installment) AS avg_monthly_installment
FROM applicants a
INNER JOIN loans l 
    ON a.applicant_id = l.applicant_id
GROUP BY 
    CASE 
        WHEN a.credit_score_fico >= 700 THEN 'PRIME (LOW RISK)'
        ELSE 'SUBPRIME (HIGH RISK)'
    END;

-- ==============================================================================
-- Portfolio Aggregation Summary: Risk Tranche Capital Exposure
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

SELECT 
    CASE 
        WHEN a.credit_score_fico >= 700 THEN 'PRIME (LOW RISK)'
        ELSE 'SUBPRIME (HIGH RISK)'
    END AS risk_tranche,
    COUNT(l.loan_id) AS total_active_loans,
    SUM(l.loan_amount) AS total_capital_exposure,
    AVG(l.monthly_installment) AS avg_monthly_installment
FROM applicants a
INNER JOIN loans l 
    ON a.applicant_id = l.applicant_id
GROUP BY 
    CASE 
        WHEN a.credit_score_fico >= 700 THEN 'PRIME (LOW RISK)'
        ELSE 'SUBPRIME (HIGH RISK)'
    END;
