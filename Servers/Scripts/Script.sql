alter table member add (authkey varchar(50));
alter table member add (authstatus varchar(1));
ALTER TABLE MEMBER modify(authstatus DEFAULT '0');

alter table receipt add (bootpay_id varchar(150));
UPDATE MEMBER SET AUTHSTATUS  = 1;

DELETE FROM reservation;
DELETE FROM receipt;
DELETE FROM tablemap WHERE store_id = 22;