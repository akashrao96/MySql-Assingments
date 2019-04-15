CREATE table cust
(
	cust_id varchar2(3),
	lname varchar2(15),
	fname varchar2(15),
	area varchar2(2),
	Phone_no number(8)
);

CREATE table movie
(
	Mv_no number(2),
	title varchar2(25),
	type varchar2(10),
	star varchar2(25),
	price number(8,2)
);

CREATE table invoice
(
	Inv_no varchar2(3),
	Mv_no number(2),
	Cust_id varchar2(3),
	Issue_date date,
	Return_date date
);


INSERT into cust
values('D5', 'Rao', 'Akash', 'BG', 98313854);

INSERT into cust
values('D6', 'Biyani', 'Pranjal', 'RB', 98345444);

INSERT into cust
values('D7', 'Totala', 'Naman', 'PS', 98318748);

INSERT into cust
values('D8', 'Das', 'Sumit', 'ED', 98314586);

INSERT into cust
values('D9', 'Rao', 'Rohit', 'CS', 98315454);

INSERT into movie
values(90, 'Possesion','ACTION', 'Billy Talent',400);

INSERT into movie
values(10, 'Anabella','Horror', 'Ward Horton',100);

INSERT into movie
values(50, 'Conjurring','Horror', 'Patrick Wilson',500);

INSERT into movie
values(80, 'Woman in Black','Horror', 'Daniel Radcliffe',150);

INSERT into movie
values(65, 'Insidious','Horror', 'Leigh Whanell',200);

INSERT into invoice
values('A1',90,'D5','05-DEC-2013','06-DEC-2014');

INSERT into invoice
values('A2',10,'D6','10-JUL-2012','12-JUL-2012');

INSERT into invoice
values('A3',50,'D7','15-OCT-2015','20-OCT-2015');

INSERT into invoice
values('A4',80,'D8','05-JAN-2010','25-JAN-2010');

INSERT into invoice
values('A5',65,'D9','17-SEP-2011','19-SEP-2011');

1)
select * from cust;

2)
select fname,area
from cust;

3)
select type
from movie;

4)
select fname,lname
from cust
where Phone_no>5550000;

5)
select Cust_id
from invoice
where Issue_date between '01-SEP-2011' and '30-SEP-2011';


6)
select title
from movie
where type='ACTION' or type='COMEDY';

7)
select title
from movie
where price>150 and price<=200;

8)
select Mv_no,Inv_no
from invoice
where Inv_no<'A5';

9)
select fname,lname
from cust
where fname like '_a%';

10)
select lname
from cust
where lname like 's%' or lname like 'j%';

11)
select fname,lname
from cust
where area like '_a%';

12)
select fname,lname
from cust
where area='da' or area='mu' or area='gh';

13)
select Mv_no,title,type
from movie
where star like 's%';

14)
select title,price*15
from movie
where price>150;

15)
select title
from movie;

16)
select title,type
from movie
where type!='Horror';

17)
select title,sqrt(price) "sqrroot price"
from movie;

18)
select title,price/(price-100) "new cost"
from movie
where title='Conjurring';

19)
select fname,lname,cust_id,area
from cust
where Phone_no is NULL;

20)
select fname
from cust
where lname is NULL;

21)
select count(cust_id)
from cust;

22)
select sum(price)
from movie;

23)
select avg(price)
from movie;

24)
select max(price) as max_price,min(price) as min_price
from movie;

25)
select count(Mv_no)
from movie
where price>=150;

26-a)
select 'Invoice no. of cust_id{'||cust_id||'} is {'|| inv_no ||'} and Movie no is{'||Mv_no||'}'
from invoice;

26-b)
select '{'||cust_id||'} has taken Movie no.{'||Mv_no||'} on {'||Issue_date||'} and will return on {'|| Return_date||'}'
from invoice;

27)
select type,avg(price)
from movie
group by type;

28)
select type,count(Mv_no)
from movie
group by type;

29)
select count(Mv_no)
from movie
where type='comedy' and type='thriller'
group by type;

30)
select type,avg(price)
from movie
where price<=150
group by type;

31)
select type,avg(price)
from movie
where price>=150
having type='comedy' or type='thriller'
group by type;

32)
select Mv_no
from cust,invoice
where cust.cust_id=invoice.cust_id
and fname='Ivan';

33)
select fname,lname,Mv_no
from cust,invoice
where cust.cust_id=invoice.cust_id;

34)
select title,Cust_id,invoice.Mv_no
from movie,invoice
where movie.Mv_no=invoice.Mv_no;

35)
select title,type
from movie
where Mv_no in(select Mv_no from invoice where cust_id in(select cust_id from cust where fname='Vandana'));

36)
select fname,lname
from cust
where Cust_id in(select Cust_id from invoice where Mv_no in(select Mv_no from movie where type='drama'));

37)
select 'The movie taken by{'||cust.fname||'} {'||cust.lname||'} is {'||movie.title||'}'
from cust,movie,invoice
where cust.cust_id in(select cust_id from cust where movie.Mv_no=invoice.Mv_no and invoice.cust_id=cust.cust_id) and movie.Mv_no>=3;

38)
select fname,lname
from cust
where cust_id in(select cust_id from invoice where Mv_no in(select Mv_no from movie where Mv_no=9));

39)
select fname,lname,area
from cust
where cust_id in(select cust_id from invoice where Inv_no='A5');

40)
select fname,lname,Phone_no
from cust
where cust_id in(select cust_id from invoice where Issue_date<'01-AUG-2014');

41)
select title
from movie
where Mv_no in(select Mv_no from invoice where cust_id in(select cust_id from cust where fname='Akash' or fname='Naman'));

42)
select title,Mv_no
from movie
where Mv_no in(select Mv_no from invoice where cust_id in(select cust_id from cust));

43)
select type,Mv_no
from movie
where Mv_no in(select Mv_no from invoice where cust_id in(select cust_id from cust where cust_id='D8' or cust_id='D5'));

44)
select cust_id
from cust
where cust_id in(select cust_id from invoice where Mv_no in(select Mv_no from movie where star='Daniel Radcliffe'));

45)
select fname,lname
from cust
where cust_id in(select cust_id from invoice where Mv_no in(select Mv_no from movie where Mv_no>0));

46)
select Inv_no,to_char(Issue_date,'dd ')day from invoice;

47)
select to_char(Return_date,'month')month from invoice;

48)
select to_char(issue_date,'dd-month-yy')dformat from invoice;

49)
select sysdate +15 from dual;

50)
select abs(trunc(return_date-issue_date)) from invoice;

51)
update cust
set Phone_no=466389
where fname='Akash';

52)
update invoice
set Issue_date='24-Jul-93'
where cust_id='D5';

53)
update movie
set price=250
where title='Conjurring';

54)
delete from invoice
where inv_no='i8';

55)
delete from invoice
where return_date<'10-jul-93';

56)
update cust
set area='vs'
where cust_id='D5';

57)
update invoice
set return_date='16-aug-93'
where cust_id='D7';