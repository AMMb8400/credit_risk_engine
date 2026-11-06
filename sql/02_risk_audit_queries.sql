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

-- ==============================================================================
-- Advanced Risk Filter: High-Income Subprime Exceptions via CTE
-- Architect: Alexandre Marcel Mbassi
-- ==============================================================================

WITH income_benchmark AS (
    SELECT AVG(monthly_income) AS global_avg_income 
    FROM applicants
),
tranche_mapping AS (
    SELECT 
        applicant_id,
        legal_name,
        monthly_income,
        credit_score_fico,
        CASE 
            WHEN credit_score_fico >= 700 THEN 'PRIME'
            ELSE 'SUBPRIME'
        END AS risk_tranche
    FROM applicants
)
SELECT 
    tm.applicant_id,
    tm.legal_name,
    tm.monthly_income,
    tm.credit_score_fico,
    tm.risk_tranche,
    ROUND(ib.global_avg_income, 2) AS benchmark_income
FROM tranche_mapping tm
CROSS JOIN income_benchmark ib
WHERE tm.monthly_income > ib.global_avg_income
  AND tm.risk_tranche = 'SUBPRIME'
ORDER BY tm.monthly_income DESC;
