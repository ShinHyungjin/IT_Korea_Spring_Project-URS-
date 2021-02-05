alter table member add (authkey varchar(50));
alter table member add (authstatus varchar(1));
ALTER TABLE MEMBER modify(authstatus DEFAULT '0');