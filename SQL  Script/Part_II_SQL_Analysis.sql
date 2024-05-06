# SQL Analysis
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Opening the database
use  bank_loan;

# Peek at the data
select * from financial_loan;

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Total number of applications
SELECT COUNT(id) as `Total number of applications` from financial_loan;

# Month to Date Total loan applications
SET @specific_date = '2021-03-09'; # This date can be changed to calculate the Total number of Month to Date applications
SELECT COUNT(id) as `Month to Date total number of applications` from financial_loan
where YEAR(issue_date) = YEAR(@specific_date) AND MONTH(issue_date) = MONTH(@specific_date) and issue_date <= @specific_date;

#Total number of loan applications for each month
select count(*) ,MONTH(issue_date) from financial_loan group by MONTH(issue_date) ORDER BY MONTH(issue_date);

#Let us look at the Month over Month Total number of applications
SELECT 
    MONTH(issue_date) AS 'Month',
    COUNT(id) AS `Current_month_count`,
    LAG(COUNT(*), 1) OVER (ORDER BY MONTH(issue_date)) AS `Previous_month_count`, #Ordering it by month and taking the count and here LAG function takes the COUNT from the previous `1` month
    COUNT(id)-LAG(COUNT(*), 1) OVER (ORDER BY MONTH(issue_date)) AS `Month over month change`, # Different in the COUNT
    ((COUNT(id)-LAG(COUNT(*), 1) OVER (ORDER BY MONTH(issue_date)))/LAG(COUNT(*), 1) OVER (ORDER BY MONTH(issue_date)))*100 AS `Percentage change Month over month` #percentage increase/decrease from previous month
FROM financial_loan
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Distribution Of Total amount funded
SELECT MIN(loan_amount) AS `Min Loan Amount`,
       MAX(loan_amount) AS `Max Loan Amount`,
       AVG(loan_amount) AS `Average Loan Amount`,
       SUM(loan_amount) AS `Total Loan Amount`
FROM financial_loan;


# Total amount funded
SELECT SUM(loan_amount) as `Total amount funded` from financial_loan;

# Month to Date Total amount funded
SET @specific_date = '2021-03-09'; 
SELECT SUM(loan_amount) as `Month to Date total amount funded` from financial_loan
where YEAR(issue_date) = YEAR(@specific_date) AND MONTH(issue_date) = MONTH(@specific_date) and issue_date <= @specific_date;

#Total amount funded for each month
select SUM(loan_amount) AS `Total Amunt Funded` ,MONTH(issue_date) AS `Month` from financial_loan group by MONTH(issue_date) ORDER BY MONTH(issue_date);

#Let us look at the Month over Month Total amount funded
SELECT 
    MONTH(issue_date) AS 'Month',
    SUM(loan_amount) AS `Current_month_amount_funded`,
    LAG(SUM(loan_amount), 1) OVER (ORDER BY MONTH(issue_date)) AS `Previous_month_amount_funded`, #Ordering it by month and taking the count and here LAG function takes the COUNT from the previous `1` month
    SUM(loan_amount)-LAG(SUM(loan_amount), 1) OVER (ORDER BY MONTH(issue_date)) AS `Month over month change`, # Different in the COUNT
    ((SUM(loan_amount)-LAG(SUM(loan_amount), 1) OVER (ORDER BY MONTH(issue_date)))/LAG(SUM(loan_amount), 1) OVER (ORDER BY MONTH(issue_date)))*100 AS `Percentage change Month over month` #percentage increase/decrease from previous month
FROM financial_loan
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Distribution Of Total amount recieved
SELECT MIN(loan_amount) AS `Min Loan Amount`,
       MAX(loan_amount) AS `Max Loan Amount`,
       AVG(loan_amount) AS `Average Loan Amount`,
       SUM(loan_amount) AS `Total Loan Amount`
FROM financial_loan;

# Total amount recieved
SELECT SUM(total_payment) as `Total amount recieved` from financial_loan;

# Month to Date Total amount received
SET @specific_date = '2021-03-09'; 
SELECT SUM(total_payment) as `Month to Date total amount recieved` from financial_loan
where YEAR(issue_date) = YEAR(@specific_date) AND MONTH(issue_date) = MONTH(@specific_date) and issue_date <= @specific_date;

#Total amount recieved for each month
select SUM(total_payment) AS `Total amount recieved`,MONTH(issue_date) AS `Month` from financial_loan group by MONTH(issue_date) ORDER BY MONTH(issue_date);

#Let us look at the Month over Month Total amount recieved
SELECT 
    MONTH(issue_date) AS 'Month',
    SUM(total_payment) AS `Current_month_amount_recieved`,
    LAG(SUM(total_payment), 1) OVER (ORDER BY MONTH(issue_date)) AS `Previous_month_amount_recieved`, #Ordering it by month and taking the count and here LAG function takes the COUNT from the previous `1` month
    SUM(total_payment)-LAG(SUM(total_payment), 1) OVER (ORDER BY MONTH(issue_date)) AS `Month over month change`, # Different in the COUNT
    ((SUM(total_payment)-LAG(SUM(total_payment), 1) OVER (ORDER BY MONTH(issue_date)))/LAG(SUM(total_payment), 1) OVER (ORDER BY MONTH(issue_date)))*100 AS `Percentage change Month over month` #percentage increase/decrease from previous month
FROM financial_loan
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) as `Average Interest Rate` from financial_loan;

# Month to Date Average Interest Rate
SET @specific_date = '2021-03-09'; 
SELECT ROUND(AVG(int_rate)*100,2) as `Month to Date Average Interest Rate` from financial_loan
where YEAR(issue_date) = YEAR(@specific_date) AND MONTH(issue_date) = MONTH(@specific_date) and issue_date <= @specific_date;

#Average Interest Rate for each month
select ROUND(AVG(int_rate)*100,2) AS `Average Interest Rate`,MONTH(issue_date) AS `Month` from financial_loan group by MONTH(issue_date) ORDER BY MONTH(issue_date);

#Let us look at the Month over Month Average Interest Rate
SELECT 
    MONTH(issue_date) AS 'Month',
    ROUND(AVG(int_rate)*100,2) AS `Current_month_average_interest_rate`,
    LAG(ROUND(AVG(int_rate)*100,2), 1) OVER (ORDER BY MONTH(issue_date)) AS `average_interest_rate`, #Ordering it by month and taking the count and here LAG function takes the COUNT from the previous `1` month
    ROUND((AVG(int_rate)-LAG(AVG(int_rate), 1) OVER (ORDER BY MONTH(issue_date)))*100,2) AS `Month over month change`, # Different in the COUNT
    ((AVG(int_rate)-LAG(AVG(int_rate), 1) OVER (ORDER BY MONTH(issue_date)))/LAG(AVG(int_rate), 1) OVER (ORDER BY MONTH(issue_date)))*100 AS `Percentage change Month over month` #percentage increase/decrease from previous month
FROM financial_loan
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# Average dti
SELECT ROUND(AVG(dti)*100,2) as `Average dti` from financial_loan;

# Month to Date Average dti
SET @specific_date = '2021-03-09'; 
SELECT ROUND(AVG(dti)*100,2) as `Month to Date Average dti` from financial_loan
where YEAR(issue_date) = YEAR(@specific_date) AND MONTH(issue_date) = MONTH(@specific_date) and issue_date <= @specific_date;

#Average dti for each month
select ROUND(AVG(dti)*100,2) AS `Average dti`,MONTH(issue_date) AS `Month` from financial_loan group by MONTH(issue_date) ORDER BY MONTH(issue_date);

#Let us look at the Month over Month Average Interest Rate
SELECT 
    MONTH(issue_date) AS 'Month',
    ROUND(AVG(dti)*100,2) AS `Current_month_average_dti`,
    LAG(ROUND(AVG(dti)*100,2), 1) OVER (ORDER BY MONTH(issue_date)) AS `average_dti`, #Ordering it by month and taking the count and here LAG function takes the COUNT from the previous `1` month
    ROUND((AVG(dti)-LAG(AVG(dti), 1) OVER (ORDER BY MONTH(issue_date)))*100,2) AS `Month over month change`, # Different in the COUNT
    ((AVG(dti)-LAG(AVG(dti), 1) OVER (ORDER BY MONTH(issue_date)))/LAG(AVG(dti), 1) OVER (ORDER BY MONTH(issue_date)))*100 AS `Percentage change Month over month` #percentage increase/decrease from previous month
FROM financial_loan
GROUP BY MONTH(issue_date)
ORDER BY MONTH(issue_date);


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Categories in loan_ststus
SELECT loan_status FROM financial_loan GROUP BY loan_status;

# Number of Applications in each category
SELECT loan_status AS `Loan Status`, COUNT(ID) AS `Number of Applications` FROM financial_loan GROUP BY loan_status;

# 'Fully Paid' and 'Current' loan is considered good loans and Charged Off is taken as bad loan.

# Number of good and bad loan applications
SELECT  COUNT(id) AS `Total Number Of applications`, COUNT(CASE WHEN loan_status = "Fully Paid" OR loan_status = "Current" THEN id END) AS `Number of Good loan applications`,
	   COUNT(CASE WHEN loan_status = "Charged Off" THEN id END) AS `Number of bad loan applications`
FROM financial_loan;

# Percentage of Good loan andf bad loan applications
SELECT ROUND(((COUNT(CASE WHEN loan_status = "Fully Paid" OR loan_status = "Current" THEN id END))/ COUNT(id))*100,2) AS `Percentage of Good loan applications`,
	   ROUND(((COUNT(CASE WHEN loan_status = "Charged Off" THEN id END))/ COUNT(id))*100,2) AS `Percentage of bad loan applications`
FROM financial_loan;


# Amount funded for good loan and bad loan applications
SELECT  SUM(loan_amount) AS `Total amount funded`, SUM(CASE WHEN loan_status = "Fully Paid" OR loan_status = "Current" THEN loan_amount END) AS `Amount funded for good loan applications`,
	   SUM(CASE WHEN loan_status = "Charged Off" THEN loan_amount END) AS `Amount funded for bad loan applications`
FROM financial_loan;

	    
# Amount received for good loan and bad loan applications
SELECT  SUM(total_payment) AS `Total amount funded`, SUM(CASE WHEN loan_status = "Fully Paid" OR loan_status = "Current" THEN total_payment END) AS `Amount received for good loan applications`,
	   SUM(CASE WHEN loan_status = "Charged Off" THEN total_payment END) AS `Amount received for bad loan applications`
FROM financial_loan;

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Reports on different loan status


SELECT loan_status,
	   COUNT(id) AS `Total number of applications`,
       SUM(loan_amount) AS `Total amount Funded`,
       SUM(total_payment) AS `Total amount Received`,
       round(AVG(int_rate)*100,2) as `Average Interest Rate`,
       round(AVG(dti)*100,2) as `Average Debt-to-Income Rate`
FROM financial_loan
group by loan_status;


SET @specific_date = '2021-11-30';
SELECT loan_status AS `Loan Status`,
	   COUNT(id) as `Month to Date total number of applications`,
	   SUM(loan_amount) as `Month to Date total amount funded`,
       SUM(total_payment) as `Month to Date total amount recieved`
FROM financial_loan
WHERE YEAR(issue_date) = YEAR(@specific_date) AND MONTH(issue_date) = MONTH(@specific_date) and issue_date <= @specific_date
GROUP BY loan_status;

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


# Number Of Applications by `Grade` and `Loan_Status`
SELECT grade,
       loan_status,
       COUNT(id) AS `Number of Applications`
FROM financial_loan
GROUP BY grade, loan_status
ORDER BY grade, loan_status;



# Loan Status Distribution Over time
SELECT MONTH(issue_date) AS `Month`,
       loan_status,
       COUNT(id) AS `Number of Applications`
FROM financial_loan
GROUP BY MONTH(issue_date), loan_status
ORDER BY MONTH(issue_date), loan_status;

#Loan Term distribution
SELECT term AS `Term`,
       COUNT(id) AS `Number of Applications`
FROM financial_loan
GROUP BY term;
SELECT term AS `Term`,
       COUNT(id) AS `Number of Applications`
FROM financial_loan
GROUP BY term;
