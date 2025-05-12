USE BankDB;
CREATE TABLE AuditTxDelete AS SELECT * FROM transaction;
ALTER TABLE AuditTxDelete
ADD COLUMN DeleteTimeStamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
SELECT * FROM BankDB.AuditTxDelete;

SELECT * FROM BankDB.AuditTxDelete;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM BankDB.AuditTxDelete WHERE txn_id=1;
SELECT * FROM BankDB.transaction;
SELECT * FROM BankDB.AuditTxDelete;

CALL WEEK6HW2(1, @total_balance);
SELECT @total_balance AS 'Total Available Balance';

CALL WEEK6HW2(2, @total_balance);
SELECT CONCAT('$', FORMAT(@total_balance, 2)) AS 'Total Available Balance for Customer 1';
