use bank_loan_db3
select 
	* 
from 
	financial_loan;

--how many users are there
select 
	count(id) as Total_loan_applications 
from 
	financial_loan;

--MTD Loan Applications
select 
	count(id) as MTD_Total_applications
from 
	financial_loan 
where 
	month(issue_date)=12;

--How many loan applications bank has received in november?
select 
	count(id) as PMTD_total_applications
from 
	financial_loan 
where 
	month(issue_date)=11;

--Find out total funded amount
select 
	sum(loan_amount) as total_funded_amount
from
	financial_loan

	
--Find out MTD total funded amount in december
select 
	sum(loan_amount) as MTD_total_funded_amount
from
	financial_loan
where 
	 month(issue_date)=12;

	 --Find out PMTD total funded amount in december
select 
	sum(loan_amount) as PMTD_total_funded_amount
from
	financial_loan
where 
	 month(issue_date)=11;

--Find out total amount received
select 
	sum(total_payment) as total_amount_received
from
	financial_loan
--Find out MTD total amount received
select 
	sum(total_payment) as MTD_total_amount_received
from
	financial_loan
where 
	 month(issue_date)=12;

--Find out PMTD total amount received
select 
	sum(total_payment) as PMTD_total_amount_received
from
	financial_loan
where 
	 month(issue_date)=11;

--what is the average interest rate
select 
	round(avg(int_rate)*100,2) as avg_interest_rate
from
	financial_loan

--what is the MTDaverage interest rate
select 
	round(avg(int_rate)*100,2) as MTD_avg_interest_rate
from
	financial_loan
where 
	 month(issue_date)=12;

--what is the PMTDaverage interest rate
select 
	round(avg(int_rate)*100,2) as PMTD_avg_interest_rate
from
	financial_loan
where 
	 month(issue_date)=11;

--what is the average DTI
select 
	round(avg(dti)*100,2) as avg_dti
from
	financial_loan

--what is the MTD average DTI
select 
	round(avg(dti)*100,2) as MTD_avg_dti
from
	financial_loan 
where 
	 month(issue_date)=12;

--what is the PMTD average DTI
select 
	round(avg(dti)*100,2) as PMTD_avg_dti
from
	financial_loan 
where 
	 month(issue_date)=11;

--good loan percentage
select
	round((count(case when loan_status='Fully Paid' or loan_status='Current' then id end)*100.0)/COUNT(id),2) as good_loan_percentage
from
	financial_loan;

--find out the total good loan applications
select 
	count(*) as good_loan_applications
from
	financial_loan
where 
	loan_status='Current' or loan_status='Fully Paid'

--how much amount is funded for good loan applications
select 
	sum(loan_amount) as good_loan_funded_amount
from
	financial_loan
where 
	loan_status='Current' or loan_status='Fully Paid'

--how much amount is received from good loan applications
select 
	sum(total_payment) as good_loan_received_amount
from
	financial_loan
where 
	loan_status='Current' or loan_status='Fully Paid'

--bad loan percentage
select
	round((count(case when loan_status='Charged Off' then id end)*100.0)/(COUNT(id)),2) as bad_loan_percentage
from
	financial_loan;


--find out the total bad loan applications
select 
	count(*) as bad_loan_applications
from
	financial_loan
where 
	loan_status='Charged off'

--how much amount is funded for bad loan applications
select 
	sum(loan_amount) as bad_loan_funded_amount
from
	financial_loan
where 
	loan_status='Charged off'

--how much amount is received from bad loan applications
select 
	sum(total_payment) as bad_loan_amount_received
from
	financial_loan
where 
	loan_status='Charged off'

--loan applications by loan status
select
	loan_status,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received,
	count(id) as total_loan_applications,
	round(avg(int_rate*100),2) as avg_int_rate,
	round(avg(dti*100),2) as avg_dti
from
	financial_loan
group by 
	loan_status

--group by MTD
select
	loan_status,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received
from
	financial_loan
where
	month(issue_date) = 12
group by
	loan_status

--group by month trend
select
	MONTH(issue_date) as month_number,
	DATENAME(MONTH,issue_date) as month_name,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received,
	count(id) as total_loan_applications,
	round(avg(int_rate*100),2) as avg_int_rate,
	round(avg(dti*100),2) as avg_dti
from
	financial_loan
group by 
	DATENAME(MONTH,issue_date),MONTH(issue_date)
order by 
	MONTH(issue_date)

--Regional  analysis by state
select
	address_state as state,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received,
	count(id) as total_loan_applications,
	round(avg(int_rate*100),2) as avg_int_rate,
	round(avg(dti*100),2) as avg_dti
from
	financial_loan
group by 
	address_state
order by 
	count(id) desc

--group by term
select
	term,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received,
	count(id) as total_loan_applications,
	round(avg(int_rate*100),2) as avg_int_rate,
	round(avg(dti*100),2) as avg_dti
from
	financial_loan
group by 
	term
order by 
	count(id) desc

--group by emp_length
select
	emp_length,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received	
from
	financial_loan
group by 
	emp_length
order by 
	count(id) desc

--group by purpose(purpose of taking loan)
select
	purpose,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received	
from
	financial_loan
group by 
	purpose
order by 
	count(id) desc

--group by homeownership analysis

select
	home_ownership,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received	
from
	financial_loan
group by 
	home_ownership
order by 
	count(id) desc