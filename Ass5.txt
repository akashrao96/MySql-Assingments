1)

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

create table dep
(
	dno varchar2(3),
	dname varchar2(10)
);
insert into dep
values('D01','IT');
insert into dep
values('D02','CS');
insert into dep
values('D03','ECE');

create table bonus_info
(
	eno varchar2(3),
	bonus number,
	new_sal number
);


DECLARE
	enum emp.eno%type;
	sal emp.sal%type;
	name dep.dname%type;
	cursor cc is 
	select emp.eno, emp.sal, dep.dname from emp,dep
	where emp.dno=dep.dno;

	bonus bonus_info.bonus%type;

BEGIN

	open cc;

	loop
		fetch cc into enum,sal,name;
		exit when cc%notfound;
		if name='IT'
			then bonus := (sal*40)/100;
			if bonus>4000
				then bonus:=4000;
			end if;
		else if name='CS'
			then bonus := (sal*15)/100;
			if bonus>3000
				then bonus:=3000;
			end if;
		else
			bonus:=(sal*10)/100;
			if bonus>5000
				then bonus:=5000;
			end if;
		end if;
		end if;
	insert into bonus_info values(enum,bonus,sal+bonus);
	end loop;
	close cc;
END;



2)



create table salesman
(
	sno varchar2(3),
	name varchar2(10),
	city varchar2(10),
	balance number(4)
);
insert into salesman
values('s1','salman','kolkata',200);
insert into salesman
values('s2','aamir','delhi',300);
insert into salesman
values('s3','ranveer','mumbai',400);
insert into salesman
values('s4','shahid','chennai',400);

create table information
(
	sno varchar2(3),
	balance number(4),
	operation varchar2(10)
);

UPDATE salesman
SET balance=4000
WHERE sno='s2';

create or replace trigger sales
	after delete or update on salesman
	for each row
BEGIN
	insert into information values(:Old.sno,:Old.balance,'update');
end;

delete from salesman where sno='s3';
select * from information;

create or replace trigger sales
	after delete or update on salesman
	for each row
BEGIN
	insert into information values(:Old.sno,:Old.balance,'delete');
end;
