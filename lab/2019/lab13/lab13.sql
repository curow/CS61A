.read data.sql

-- QUESTIONS --



-------------------------------------------------------------------------
------------------------ Give Interest- ---------------------------------
-------------------------------------------------------------------------

update accounts set amount = amount * 1.02;


create table give_interest_result as select * from accounts; -- just for tests

-------------------------------------------------------------------------
------------------------ Split Accounts ---------------------------------
-------------------------------------------------------------------------

update accounts set amount = amount / 2;
create table savings as
  select name || "'s Savings account", amount from accounts;
update accounts set name = name || "'s Checking account";
insert into accounts select * from savings;


create table split_account_results as select * from accounts; -- just for tests

-------------------------------------------------------------------------
-------------------------------- Whoops ---------------------------------
-------------------------------------------------------------------------

drop table if exists accounts;


CREATE TABLE average_prices AS
  SELECT category, avg(MSRP) as average_price from products group by category;

CREATE TABLE lowest_prices AS
  SELECT store, item, min(price) as lowest_price from inventory group by item;

CREATE TABLE shopping_list AS
  SELECT item, store from lowest_prices, products
  where item = name group by category having min(MSRP/rating);

CREATE TABLE total_bandwidth AS
  SELECT sum(Mbs) from shopping_list as a, stores as b where a.store = b.store;
