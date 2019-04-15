                               ASSINGMENT 3

1.  

set serveroutput on;
DECLARE
	year number;
	year:='&year';
BEGIN
	
	if mod(year,4)=0 AND mod(year,100)!=0 OR mod(year,400)=0 then
		dbms_output.put_line('The year is Leap Year');
	else
		dbms_output.put_line('The year is not a leap year');
	end if;
END;

2.

set serveroutput on;
DECLARE
	n number;
	m number;
	rev number:=0;
	rem number;
begin
	n:='&n';
	m:=n;
	while n>0
	loop
		rem:=mod(n,10);
		rev:=rev*10+rem;
		n:=trunc(n/10);
	end loop;
if m = rev
    then
        dbms_output.put_line('this is pallindrome'); 
    else
        dbms_output.put_line('this is not pallindrome'); 
    end if; 
end;

3.

set verify off;
set serveroutput on;
DECLARE
	n number;
	m number;
	s number:=0;
	a number;
	len number;
begin
	n:='&n';
	m:=n;
	len := length(to_char(n));
	while n>0
	loop
		a:=mod(n,10);
		s:=s + a**len;
		n:=trunc(n/10);
	end loop;
if m = s
    then
        dbms_output.put_line('this is armstrong'); 
    else
        dbms_output.put_line('this is not armstrong'); 
    end if; 
end;

 
4.

set serveroutput on;
DECLARE
	a number;
	b number;
	c number;
	d number;
BEGIN
	a:='&a';
	b:='&b';
	c:='&c';
	while(a!=0)
	loop
		d:=mod(b,a);
		b:=a;
		a:=d;
	end loop;
	while(b!=0)
	loop
		d:=mod(c,b);
		c:=b;
		b:=d;
	end loop;
	dbms_output.put_line('The GCD of three numbers is '||c);
END;

5.

DECLARE
	a NUMBER:='&a';
	b NUMBER:='&b';
	c NUMBER:='&c';
	r NUMBER;
	lcm NUMBER;
	m NUMBER;
BEGIN
	m:=b*a;
	while b!=0
	loop
		r:=mod(a,b);
		a:=b;
		b:=r;
	end loop;
	lcm:=m/a;
	m:=lcm*c;
	while lcm!=0
	loop
		r:=mod(c,lcm);
		c:=lcm;
		lcm:=r;
	end loop;
	lcm:=m/c;
	dbms_output.put_line('The LCM of the three numbers are '||lcm);
END;

6.

set serveroutput on;
DECLARE
	a number;
	b number;
	c number;
BEGIN
	a:='&a';
	c:=0;
	b:=a-1;
	for i in 1..b
	loop
		if mod(a,i)=0 then
		c:=c+i;
		end if;
	end loop;
	if a=c then
	dbms_output.put_line('The number is a perfect number');
	else
	dbms_output.put_line('The number is not a perfect number');
	end if;
END;


7.

set serveroutput on;
DECLARE
	a varchar2(10);
	b varchar2(2);
	c number;
	d number;
BEGIN
	a:='&a';
	c:=0;
	d:=0;
	for i in 1..length(a)
	loop
		b:=substr(a,i,1);
		if b in ('a','i','e','o','u','A','I','E','O','U') then
			c:=c+1;
		else
			d:=d+1;
		end if;
	end loop;
	dbms_output.put_line('The number of vowels is '||c||' and number of consonants is '||d);
END;


8.

set serveroutput on;
DECLARE
amt number;
BEGIN
select amount into amt from deposit where Act_no='sbi101';
if(amt<5000) then
	update deposit
	set amount=amount+2000;
end if;
END;


9.

create table emp(
	eno varchar2(4),
	name varchar2(10),
	dno varchar2(4),
	sal number(8,2)	
);
insert into emp values('E01','AKASH','D01',8000);
insert into emp	values('E02','PUSHKAR','D02',5000);
insert into emp	values('E03','PRANJAL','D03',6000);
insert into emp	values('E04','PRAVIN','D02',300000);
insert into emp	values('E05','AVIJIT','D03',7500);
insert into emp	values('E06','ROHIT','D02',40000);

a)
DECLARE
	num emp.eno%TYPE:='&num';
	ename VARCHAR2(10);
BEGIN
	SELECT name INTO ename
	FROM emp
	WHERE eno=num;
	IF SQL%FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Name of the employee is '||ename);
	ELSE
		DBMS_OUTPUT.PUT_LINE('There is no such employee with this employee code');
	END IF;
END;


b)
DECLARE
	new_eno emp.eno%TYPE :='&employee_no';
	new_name emp.name%TYPE:='&employee_name';
	new_dno emp.dno%TYPE:='&department_no';
	new_sal emp.sal%TYPE:='&salary';
BEGIN
	 UPDATE emp
 	SET eno=new_eno
 	WHERE eno=new_eno;
 	IF SQL%FOUND THEN
  	DBMS_OUTPUT.PUT_LINE('Duplicate entity');
 	ELSE
  	INSERT INTO emp VALUES(new_eno,new_name,new_dno,new_sal);
  	DBMS_OUTPUT.PUT_LINE('One row is inserted');
 	END IF;
END;






10.

set serveroutput on;
DECLARE
	BRANCH VARCHAR2(10);
	NUM1 NUMBER(2);
	NUM2 NUMBER(2);
	NUM3 NUMBER(2);
BEGIN
	BRANCH := '&BRANCH';
	SELECT COUNT(Loan_no) INTO NUM1 FROM borrow;
	DELETE from borrow where B_name  = BRANCH;
	select count(Loan_no) into NUM2 from borrow;
	NUM3 := NUM1-NUM2;
	DBMS_OUTPUT.PUT_LINE('the number of rows deleted are: '|| NUM3);
END;






	

                     