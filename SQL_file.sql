use p421;
select * from p421.sql_file_1;
select * from p421.sql_file_2;

-- KPI 1 Number of Patients across various summaries

select 
sum(`No of pt inc in the transfusion summary`) as Transfusion_Summary,
sum(`No of pt in hypercalcemia summary`) as Hypercalcemia_Summary,
sum(`No of pt in Serum phosphorus summary`) as Serumphosphorus_summary,
sum(`No of pt inc in hospitalization summary`) as Hospitalization_summary,
sum(`No of hplizations inc in hp readmission summary`) as Readmission_summary, 
sum(`No of Pt inc in survival summary`) as Survival_summary,
sum(`No of Pt inc in fistula summary`) as Fistula_summary,
sum(`No of pt in long term catheter summary`) as catheter_summary,
sum(`Number of patients in nPCR summary`) as nPCR_summary from p421.sql_file_1;

-- KPI 2 Profit Vs Non-Profit Stats

SELECT `Profit or Non-Profit`,
  SUM(CASE WHEN `Profit or Non-Profit` = 'profit' THEN 1 ELSE 0 END) as profit,
  SUM(CASE WHEN `Profit or Non-Profit` = 'non-profit' THEN 1 ELSE 0 END) as Non_profit
FROM p421.sql_file_1
GROUP BY `Profit or Non-Profit`;

-- KPI 3 Chain Organizations w.r.t. Total Performance Score as No Score (not done)

SELECT f1.`Chain Organization`,
count(f2.`Total Performance Score`) as 'Total_No_Score'
from sql_file_1 as f1 join sql_file_2 as f2 on
f1.`Facility Name`= f2.`Facility Name` 
where`Total Performance Score` = 0
group by f1.`Chain Organization`
order by Total_No_Score desc
limit 10;

-- KPI 4 Dialysis Stations Stats

SELECT count(`# of Dialysis Stations`), `State`
FROM p421.sql_file_1
GROUP BY `State`
order by count(`# of Dialysis Stations`) desc
limit 10;

-- KPI 5 # of Category Text  - As Expected

SELECT 
COUNT(`Patient Transfusion category text`) AS Patient_Transfusion,
COUNT(`Patient hospitalization category text`) AS Patient_hospitalization,
COUNT(`Patient Survival Category Text`) AS Patient_Survival,
COUNT(`Patient Infection category text`) AS Patient_Infection,
COUNT(`Fistula Category Text`) AS Fistula,
COUNT(`SWR category text`) AS SWR,
COUNT(`PPPW category text`) AS PPPW
FROM 
  p421.sql_file_1
WHERE 
  `Patient Transfusion category text` = 'As Expected'
   AND `Patient hospitalization category text` = 'As Expected'
   AND `Patient Survival Category Text` = 'As Expected'
   AND `Patient Infection category text` = 'As Expected'
   AND `Fistula Category Text` = 'As Expected'
   AND `SWR category text` = 'As Expected'
   AND `PPPW category text` = 'As Expected';
  
-- KPI 6  Average Payment Reduction Rate

SELECT ROUND(AVG(`PY2020 Payment Reduction Percentage`) * 100, 3)
 AS Average_Payment_Reduction_Rate
FROM  p421.sql_file_2;


