USE bank_loan_data

-- KPI's 

-- Total Loan Applications
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data_db; 

-- MTD Loans Applications
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 12;
  
  EXPLAIN bank_loan_data_db
  -- PMTD Loan Applications
SELECT COUNT(id) AS Total_Applications 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 11;

-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data_db;

-- MTD Total Funded Amount
 SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 12;

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 11;

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data_db;

-- MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 12;

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 11;

-- Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate 
FROM bank_loan_data_db

-- MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 12;

-- PMTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 11;

-- Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI 
FROM bank_loan_data_db

-- MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 12;

-- MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 11;


-- GOOD LOAN ISSUED


-- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data_db;

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data_db
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data_db
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data_db
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


-- BAD LOAN ISSUED


-- Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data_db;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data_db
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount 
FROM bank_loan_data_db
WHERE loan_status = 'Charged Off'

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received 
FROM bank_loan_data_db
WHERE loan_status = 'Charged Off'


-- LOAN STATUS

-- Loans status
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data_db
    GROUP BY
        loan_status
        
-- MTD loan status
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data_db
WHERE MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) = 12
GROUP BY loan_status



-- BANK LOAN REPORT | OVERVIEW


-- MONTH
SELECT 
    MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')) AS Month_Number, 
    MONTHNAME(STR_TO_DATE(issue_date, '%Y-%m-%d')) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data_db
GROUP BY MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d')), MONTHNAME(STR_TO_DATE(issue_date, '%Y-%m-%d'))
ORDER BY MONTH(STR_TO_DATE(issue_date, '%Y-%m-%d'));

-- state
SELECT 
    address_state AS State,  -- Select the state (renaming the column to "State" in the output)
    COUNT(id) AS Total_Loan_Applications,  -- Count the number of loan applications
    SUM(loan_amount) AS Total_Funded_Amount,  -- Sum of the loan amounts (total funded)
    SUM(total_payment) AS Total_Amount_Received  -- Sum of the total payments received
FROM bank_loan_data_db  -- From the "bank_loan_data_db" table
GROUP BY address_state  -- Group the results by state
ORDER BY address_state;  -- Sort the results alphabetically by state

-- TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data_db
GROUP BY term
ORDER BY term

-- EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data_db
GROUP BY emp_length
ORDER BY emp_length

-- PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data_db
GROUP BY purpose
ORDER BY purpose

-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data_db
GROUP BY home_ownership
ORDER BY home_ownership

