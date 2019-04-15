create table deposit(
act_no varchar2(10) primary key,
c_name varchar2(10) references customer(c_name),
b_name varchar2(10) references branch(b_name),
amount number(8,2) NOT NULL
);

create table branch(
b_name varchar2(10) primary key,
city varchar2(10) check(city in ('delhi','kolkata','mumbai'))
);


create table customer(
c_name varchar2(10) primary key check(c_name=upper(c_name)),
city varchar2(10) NOT NULL
);

create table borrow(
loan_no varchar2(10) primary key check(loan_no=upper(loan_no)),
c_name varchar2(10) references customer(c_name),
b_name varchar2(10) references branch(b_name),
amount number(8,2) check(amount>1000)
);

insert into customer values
('PUSHKAR','patna');

insert into customer values
('PRANJAL','howrah');

insert into customer values
('AVIJIT','kolkata');

insert into customer values
('ASHAYA','mumbai');

insert into customer values
('PRAVIN','delhi');

insert into customer values
('SATYAM','hyderabad');

insert into customer values
('ROHIT','chennai');

insert into customer values
('HARSHIT','vizag');

insert into customer values
('RAHUL','banglore');

insert into customer values
('SAMIR','pune');

insert into customer values
('SIDHANT','nagpur');

insert into customer values
('KARAN','kolkata');

insert into customer values
('SANDEEP','lucknow');

insert into customer values
('SUPRATIP','chandigarh');

insert into branch values
('SBI','kolkata');

insert into branch values
('UCO','kolkata');

insert into branch values
('PNB','delhi');

insert into branch values
('ICICI','mumbai');

insert into branch values
('AXIS','mumbai');

insert into branch values
('HDFC','delhi');

insert into branch values
('IDFC','kolkata');

insert into deposit values
('sbi101','PUSHKAR','SBI','15000');

insert into deposit values
('UCO101','PUSHKAR','UCO','17000');

insert into deposit values
('axi101','PRANJAL','AXIS','25000');

insert into deposit values
('sbi102','AVIJIT','SBI','10000');

insert into deposit values
('pnb101','ASHAYA','PNB','17000');

insert into deposit values
('ici101','PRAVIN','ICICI','15500');

insert into deposit values
('hdf101','SATYAM','HDFC','19500');

insert into deposit values
('idf101','SAMIR','IDFC','13300');

insert into deposit values
('sbi103','KARAN','SBI','49000');

insert into deposit values
('pnb102','SANDEEP','PNB','85000');


insert into borrow values
('ABC','PUSHKAR','SBI','2000');

insert into borrow values
('BCD','SIDHANT','UCO','17000');

insert into borrow values
('ACD','PRANJAL','AXIS','25000');

insert into borrow values
('ACB','RAHUL','SBI','25000');

insert into borrow values
('CDA','HARSHIT','PNB','17000');

insert into borrow values
('CBC','PRAVIN','ICICI','12500');

insert into borrow values
('ABA','SATYAM','HDFC','9500');

insert into borrow values
('ABE','SAMIR','IDFC','1300');

insert into borrow values
('CBF','KARAN','SBI','3500');

insert into borrow values
('PAB','ROHIT','PNB','5000');
 
1. select customer.c_name from customer,branch,deposit
   where
         branch.b_name=deposit.b_name and
         customer.c_name=deposit.c_name and
         customer.city='nagpur' and branch.city='kolkata'
    union
   select customer.c_name from customer,branch,borrow
   where branch.b_name=borrow.b_name and
         customer.c_name=borrow.c_name and
         customer.city='nagpur' and branch.city='kolkata';



2. select customer.c_name from customer,branch,deposit
   where
         branch.b_name=deposit.b_name and
         customer.c_name=deposit.c_name and
         customer.city='kolkata' and branch.city='kolkata'
    union
   select customer.c_name from customer,branch,borrow
   where branch.b_name=borrow.b_name and
         customer.c_name=borrow.c_name and
         customer.city='kolkata' and branch.city='kolkata';


5. select deposit.c_name from customer,deposit
    where deposit.c_name=customer.c_name
    intersect
    select borrow.c_name from customer,borrow 
    where customer.c_name=borrow.c_name;

8. select deposit.c_name from customer,branch,deposit
   where
         branch.b_name=deposit.b_name and
         customer.c_name=deposit.c_name and
         customer.city='hyderabad' and branch.city='delhi';

3. select deposit.c_name from branch,deposit
   where
       branch.b_name=deposit.b_name and
       deposit.c_name!='PUSHKAR' and
       branch.city in(select city from branch where b_name in (select b_name from deposit where c_name='PUSHKAR'));

4. select * from customer,deposit
   where
       customer.c_name=deposit.c_name and
       customer.c_name!='KARAN' and
       customer.city in(select city from customer where c_name='KARAN')
   Union
   select * from customer,borrow
   where
       customer.c_name=borrow.c_name and
       customer.c_name!='KARAN' and
       customer.city in(select city from customer where c_name='KARAN');
9.  select deposit.c_name from customer,deposit
    where 
        deposit.c_name=customer.c_name and
        customer.city in(select city from customer where c_name='AVIJIT')
    intersect
     select borrow.c_name from customer,borrow 
    where 
        customer.c_name=borrow.c_name and
        customer.city in(select city from customer where c_name='AVIJIT');

6.  select c_name from borrow where amount>(select amount from borrow where c_name = 'SATYAM');

7.   select c_name from deposit where b_name in
           (select b_name from branch where city in
           (select city from branch where b_name in
           (select b_name from deposit where c_name='SAMIR')))
            intersect
           select c_name from customer where city in
           (select city from customer where c_name = 'KARAN');

10.   select c_name from customer where city = 'kolkata'
    intersect
    (
    select c_name from deposit where b_name in
    (select b_name from branch where city in
    (select city from branch where b_name in
    (select b_name from deposit where c_name='SAMIR')))
    union
   select c_name from borrow where b_name in
   (select b_name from branch where city in
   (select city from branch where b_name in
   (select b_name from borrow where c_name='SAMIR')))
   )
   intersect
   (select c_name from deposit union select c_name from borrow);



11.    select city from branch where b_name in
             ( select b_name from deposit where c_name='SANDEEP'or c_name = 'PRAVIN'
           union
             select b_name from borrow where c_name='SANDEEP' or c_name = 'PRAVIN');


12.   select b_name from deposit group by b_name having count(b_name) in
           (select max(cnt) from (select count(b_name) as cnt from deposit group by b_name ));


13.   select C_name from deposit where amount in (select max(amount) as amount from deposit);

14.   select c_name,amount from deposit where
     c_name in (select c_name from customer where city='kolkata')
     union
     select c_name,amount from borrow where
     c_name in (select c_name from customer where city='kolkata');


15.    select c_name from deposit
    where c_name!='PUSHKAR' and b_name in
    (select b_name from deposit where c_name = 'PUSHKAR' union select b_name from borrow where c_name='PUSHKAR');



16.    select sum(amount) from deposit where c_name in
      (select c_name from customer where city in
      (select city from customer having c_name = 'AVIJIT'));



17.    select c_name from deposit where b_name='SBI' and amount in
    (select max(amount) from deposit where b_name = 'SBI');



18.     (select distinct d.C_name
     from deposit d,customer c where c.city in(select city from deposit,Borrow where deposit.C_name='PUSHKAR' or Borrow.C_name='PUSHKAR') and d.amount in(select max(amount) from deposit));



19.  select c_name from deposit where amount in
    (select max(amount) from deposit where b_name='SBI');


20.  select b_name from deposit group by b_name having count(c_name)> any
       (select count(c_name) from borrow group by b_name);



21.   select c_name from borrow,branch where borrow.b_name= branch.b_name and city in(
      select city from branch where b_name in( select b_name from borrow where
       amount in( select max(amount) from borrow)));



22.    select 1.1*amount from deposit,customer,branch where customer.c_name= deposit.c_name
     and deposit.b_name= branch.b_name and customer.city='mumbai' and branch.city='delhi';



23.   update deposit
        set amount=(select max(amount) from deposit where B_name='SBI')
     where C_name='PUSHKAR';
   
  
24.     update deposit
	set amount=amount+1000
	where C_name='SANDEEP' and b_name in(select b_name from deposit where c_name='ASHAYA') 
	update deposit
	set amount=amount-1000
	where C_name='ASHAYA' and b_name in(select b_name from deposit where c_name='SANDEEP');


25.   update deposit
	set amount=amount+1000
	where amount in(select max(amount) from deposit group by B_name);



26.     update deposit
	set amount=amount+1000
	where amount>all(select avg(amount) from deposit group by B_name);


  
27.     delete from borrow where b_name in(select b_name from borrow group by b_name having avg(amount)<2000);



28.      delete from borrow where b_name in(select b_name from borrow group by b_name having count(c_name)=all
	(select min(amount) from borrow group by b_name));



29.       delete from deposit
	where C_name='KARAN' or C_name='AVIJIT'
	and (select City from Customer where C_name='KARAN')=(select City from Customer where C_name='AVIJIT');
 

   
       
    

        

         















