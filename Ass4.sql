                                                       ASSIGNMENT-4

1)
set serveroutput on;
DECLARE
	cursor c is select sal from emp;
	sa emp.sal%type;
	s emp.sal%type;
BEGIN
	select max(sal) into s from emp;
	open c;
	loop
		fetch c into sa;
		if c%notfound then
		exit;
		end if;
		if sa=s then
		delete from emp where sal=s;
		end if;
	end loop;
	if c%isopen then
	close c;
	end if;
	select max(sal) into s from emp;
	open c;
	loop
		fetch c into sa;
		if c%notfound then
		exit;
		end if;
		if sa=s then
		delete from emp where sal=s;
		end if;
	end loop;
	if c%isopen then
	close c;
	end if;
END;


2)
create table employee
(
ecode varchar2(5),
name varchar2(10),
salary number(6),
city varchar2(10)
);
insert into employee
values('abc','Avijit',10000,'Bangalore');
insert into employee
values('asd','pranjal',5000,'Delhi');
insert into employee
values('xyz','Rohit',15000,'Kolkata');
insert into employee
values('wru','pushkar',25000,'Mumbai');
insert into employee
values('ghj','karan',12000,'Kolkata');

set serveroutput on;
DECLARE
	cursor c is select city from employee;
	m employee.city%type;
	count1 number;
BEGIN
	count1:=0;
	open c;
	loop
		fetch c into m;
		if c%notfound then
		exit;
		end if;
		if m='Kolkata' then
			update employee set salary=salary+(salary*0.15) where city=m;
			count1:= count1+1;
		end if;
	end loop;
	dbms_output.put_line('No. of records updated is '|| count1);
	if c%isopen then
	close c;
	end if;
END;


3)a)


set serveroutput on
DECLARE
	ac_no1 varchar(8):='&ac_no1';
	ac_no2 varchar(10):='&ac_no2';
	CURSOR c IS SELECT Act_no FROM deposit;
	a deposit.Act_no%type;
	b deposit.amount%type;
BEGIN
 	DBMS_OUTPUT.PUT_LINE('Amount of Rs. 2000/- is transfered from Account No:  '||ac_no1||' to Account No: '||ac_no2);
	open c;
	loop
	    	fetch c into a;
		if c%notfound THEN
                	EXIT;
                END IF;
                if a=ac_no1 then
			select amount into b from deposit where Act_no=a;
			if b>0 then
				update deposit set amount=amount- 2000 where Act_no=a;
				update deposit set amount=amount + 2000 where Act_no=ac_no2;	
			else
			DBMS_OUTPUT.PUT_LINE('Insufficient amt.amt of Rs. 2000/- cannot be transfered from Account No: '||ac_no1);  	
		        end if;
		end if;
	end loop;
	IF c%ISOPEN THEN  
        	CLOSE c;
	end if;
end;


b)


set serveroutput on;
DECLARE
	cursor c is select age from employee;
	a employee.age%type;
	t integer:=0;
BEGIN
	open c;
	loop
		fetch c into a;
		if c%notfound then
			exit;
		end if;
		if a>60 then
			if t<3 then
				update employee set salary=1.05*salary where age=a;
				t:=t+1;
			end if;
		end if;
	end loop;
	if c%isopen then
		close c;
	end if;
END;

4)

set serveroutput on;
DECLARE
	cursor c is select salary from employee;
	s employee.salary%type;
	
BEGIN
	open c;
	loop
		fetch c into s;
		if c%notfound then
			exit;
		end if;
		update employee
		set salary=salary+2000
		where salary=s;
	end loop;
	if c%isopen then
		close c;
	end if;
	open c;
	loop
		fetch c into s;
		if c%notfound then
			exit;
		end if;
		if s>20000 then
			update employee
			set salary=salary-2000
			where salary=s;
		end if;
	end loop;
	if c%isopen then
		close c;
	end if;
END;

5)



declare 
	dnum employee.DNUM%type:='&dnum';
	e_sal number(10,2);
begin 
	select salary into e_sal from employee where employee.DNUM = dnum;
	dbms_output.put_line('Salary of employee having '||dnum ||' is '||e_sal);
exception
	 WHEN no_data_found THEN
      	 	dbms_output.put_line('No such department!');
	 WHEN too_many_rows then
		dbms_output.put_line('More than one entry!');
end;


6)


create table product
(pno varchar2(3),
pname varchar2(10),
actual_price number(10,2),
sale_price number(10,2)
);


insert into product
values('p0','V',100,75);

insert into product
values('p1','W',120,130);

insert into product
values('p2','X',100,90);

insert into product
values('p3','Y',100,100);

insert into product
values('p4','Z',130,220);

DECLARE
	pnum product.pno%type:='&pnum';
	profit number(10,2);
	zero_profit exception;
BEGIN
	select (sale_price-actual_price) into profit 
	from product where product.pno=pnum;
	if profit>0 then
		dbms_output.put_line('Profit is '||profit);
	else
		raise zero_profit;
	end if;
EXCEPTION
	WHEN no_data_found THEN
      	 	dbms_output.put_line('No such product!');
	WHEN zero_profit THEN
		dbms_output.put_line('NO PROFIT !!!');
END;








        