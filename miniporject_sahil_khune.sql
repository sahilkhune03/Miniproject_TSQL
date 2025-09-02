--1
drop database if exists petpals
create database petpals;
use petpals;
--2
create table pets
(petid int primary key,
name varchar(50) not null,
age int not null,
breed varchar(50) not null,
type varchar(50),
availableforadoption bit,
foreign key(shelterid) references shelters(shelterid)
ownerid int.
foreign key(ownerid) references participants(participantid));

create table shelters
(shelterid int primary key,
name  varchar(50),
location varchar(50));

create table donations
(donationid int primary key,
donorname  varchar(50),
donationtype  varchar(50),
donationamount decimal,
donationitem  varchar(50),
donationdate datetime);
shelterid int,
foreign key(shelterid) references shelters(shelterid));

create table adoptionevents
(eventid int primary key, 
eventname  varchar(50),
eventdate datetime,
location  varchar(50)),
foreign key(shelterid) references shelters(shelterid));

create table participants 
(participantid int primary key,
participantname  varchar(50),
participantype  varchar(50),
eventid int,
foreign key(eventid) references adoptionevents(eventid))

--3

insert into pets values(1,'sheru',1,'labra','dog',1)
insert into pets values(2,'rocky',2,'german shephard','dog',1)
insert into pets values(3,'tommy',3,'rotwiller','dog',0)
insert into pets values(4,'dabu',5,'persian','cat',1)
insert into pets values(5,'manu',2,'british shorthair','cat',0)
insert into pets values(6,'cutu',4,'persian','cat',1)
insert into pets values(7,'venky',2,'labra','dog',1)
insert into pets values(8,'mutuu',3,'pomerian','dog',0)
insert into pets values(9,'kalu',2,'indi','dog',1)
insert into pets values(10,'moti',3,'american','dog',1)

insert into shelters values(1,'sevakendra1','pune')
insert into shelters values(2,'sevakendra2','Nagpur')
insert into shelters values(3,'sevakendra3','mumbai')
insert into shelters values(4,'sevakendra4','nashik')
insert into shelters values(5,'sevakendra5','thane')
insert into shelters values(6,'sevakendra6','wardha')
insert into shelters values(7,'sevakendra7','raipur')
insert into shelters values(8,'sevakendra8','delhi')
insert into shelters values(9,'sevakendra9','blr')
insert into shelters values(10,'sevakendra10','pune')
insert into shelters values(11,'sevakendra11','nagpur')

insert into donations values(1,'sahil','cash',10000,'','2025-09-03 11:34:00')
insert into donations values(2,'kunal','item',null,'belt','2025-08-03 09:34:00')
insert into donations values(3,'rajesh','cash',15000,'','2025-07-03 08:34:00')
insert into donations values(4,'om','item',null,'dog food','2025-06-03 12:34:00')
insert into donations values(5,'shiv','item',null,'cat food','2025-05-03 10:34:00')
insert into donations values(6,'rajnish','cash',19000,'','2025-04-03 12:34:00')
insert into donations values(7,'monty','cash',18000,'','2025-03-03 11:34:00')
insert into donations values(8,'ken','item',null,'blanket','2025-02-03 12:34:00')
insert into donations values(9,'john','cash',149000,'','2025-01-03 10:34:00')
insert into donations values(10,'devin','cash',210000,'','2025-09-01 12:34:00')


insert into adoptionevents values(1,'adoptionevent1','2025-09-01 12:34:00','pune')

insert into adoptionevents values(2,'adoptionevent2','2025-08-01 12:34:00','mumbai')

insert into adoptionevents values(3,'adoptionevent3','2025-07-01 12:34:00','nagpur')

insert into adoptionevents values(4,'adoptionevent1','2025-06-01 12:34:00','nashik')

insert into adoptionevents values(5,'adoptionevent1','2025-05-01 12:34:00','thane')

insert into adoptionevents values(6,'adoptionevent2','2025-06-01 12:34:00','wardha')
insert into adoptionevents values(7,'adoptionevent3','2025-09-01 12:34:00','yerwada')
insert into adoptionevents values(8,'adoptionevent3','2025-07-01 12:34:00','blr')
insert into adoptionevents values(9,'adoptionevent2','2025-05-01 12:34:00','chennai')
insert into adoptionevents values(10,'adoptionevent1','2025-06-01 12:34:00','delhi')

insert into participants values(1,'yash','shelter',1)
insert into participants values(2,'nilam','shelter',4)
insert into participants values(3,'sonu','adopter',8)
insert into participants values(4,'ram','shelter',7)
insert into participants values(5,'shyam','adopter',6)
insert into participants values(6,'sahil','shelter',5)
insert into participants values(7,'om','adopter',2)
insert into participants values(8,'kunal','adopter',1)
insert into participants values(9,'salman','shelter',3)
insert into participants values(10,'vedant','adopter',2)

--4
drop database if exists petpals
--5
select name,age,breed,type 
from pets 
where availableforadoption=1;

--6
declare @id int
set @id=3
select p.participantname,p.participantype,e.eventname 
from participants p join adoptionevents e 
on p.eventid=e.eventid 
where p.eventid=@id;
--7
create procedure addinfo
@shelterid int,
@newname varchar(50),
@newlocation varchar(50)
as begin 
if exists (select 1 from shelters where shelterid=@shelterid)
begin
update shelters 
set name=@newname,location=@newlocation 
where shelterid=@shelterid;end else begin raiserror('invalid shelter id',16,1);
end  
end;
exec addinfo @shelterid=11,@newname='ujwal',@newlocation='blr'
select * from shelters
--8
select s.name,sum(d.donationamount) as total_donation_amount 
from shelters s left join donations d 
on s.shelterid=d.shelterid 
where d.donationtype='cash' 
group by s.name
--9
select name,age,breed,type 
from pets 
where ownerid is null
--10
select concat(month(donationdate),'-',year(donationdate))as month_year,sum(donationamount) as total_donation 
from donations 
where donationamount is not null 
group by month(donationdate),year(donationdate)
--11
select name,age,breed,type 
from pets 
where age  between 1 and 3 or age >5 
--12
select p.name,p.age,p.breed,p.type, s.name as sheltername 
from pets p join shelters s 
on p.shelterid=s.shelterid 
where p.availableforadoption=1
--13
select count(p.participantid) as total_participants 
from adoptionevents e 
join participants p 
on e.eventid=p.eventid 
where e.location='pune'and p.participantype='shelter' 
group by p.eventid

--14
select distinct(breed) 
from pets 
where age between 1 and 5

--15
select petid,name,age,breed,type 
from pets 
where ownerid is null

--16
select p.name as pet_name ,pa.participantname as adoptername 
from pets p join participants pa 
on p.ownerid=pa.ownerid 

--17
select s.name,count(p.petid) as no_of_pets 
from shelters s join pets p 
on s.shelterid=p.shelterid 
group by(s.name)

--18
select p1.name,p1.breed,s.name as shelter_name
from pets p1 
join pets p2 
on p1.breed=p2.breed and p1.shelterid=p2.shelterid and p1.petid<p2.petid 
join shelters s on p1.shelterid=s.shelterid

--19
select s.name as shelter_name, a.eventname 
from shelters s cross join adoptionevents a

--20
select top 1s.name as shelter_name,count(p.petid) as no_of_pets 
from shelters s join pets p 
on s.shelterid=p.shelterid 
group by s.name 
order by no_of_pets desc