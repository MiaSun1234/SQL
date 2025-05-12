USE BankDB;
SELECT account_id,
product.name, 
customer.fed_id, 
branch.name, 
CONCAT(employee.fname, ' ', employee.lname) AS emplyee_name
FROM account
JOIN product ON account.product_cd=product.product_cd
JOIN customer ON account.cust_id=customer.cust_id
JOIN branch ON account.open_branch_id=branch.branch_id
JOIN employee ON account.open_emp_id=employee.emp_id;

SELECT e.emp_id,
CONCAT(e.fname, ' ', e.lname) AS emplyee_name,
NULLIF(COUNT(a.open_emp_id),0)AS opening_account
FROM employee AS e
LEFT JOIN account AS a ON e.emp_id =a.open_emp_id
GROUP BY
e.emp_id, 
e.fname,
e.Lname;

SELECT * 
FROM account AS a
where a.account_id IN (
SELECT DISTINCT account_id 
FROM transaction AS t
);


SELECT  cust_id AS customer_id,
NULL AS account_id,
NULL AS account_balance,
SUM(avail_balance) AS total
FROM account 
GROUP BY cust_id
UNION ALL 
SELECT cust_id  AS customer_id,
account_id AS account_id,
avail_balance AS account_balance,
NULL AS total
FROM account AS a
ORDER BY customer_id,
CASE WHEN total IS NULL THEN 0 ELSE 1 END,
account_id;

CREATE VIEW `vaccount_all` AS
SELECT a*,
p.name AS product_name,
c.fed_id,
b.name AS branch_name,
e.fname AS employee_fname,
e.lname AS employee_lname
FROM account AS a
LEFT JOIN product AS p ON a.product_cd= p.product_cd
LEFT JOIN customer AS c ON a.cust_id=c.cust_id
LEFT JOIN branch AS b ON a.open_branch_id=b.branch_id
LEFT JOIN employee AS e ON a.open_emp_id=e.emp_id;
SELECT * FROM BankDB.vaccount_all;

SELECT * FROM BankDB.vaccount_all WHERE avail_balance>10000;


