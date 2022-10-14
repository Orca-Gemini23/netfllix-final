/*
  Name: Yash Patel (E224) 
         Pradhumn Bhardwaj (E219)
  Class: B.TECH CS DIV A 
*/ 

create database netflix_dscrub
use netflix_dscrub

/* creating tables */ 

create table city(
cityid		numeric(10)	not null,
cityname	varchar(32)	not null,
constraint city_cityid_pk primary key (cityid));

create table state(
stateid		numeric(2)	not null,
statename	varchar(20)	not null,
constraint state_stateid_pk primary key (stateid));

create table zipcode(
zipcodeid	numeric(10)	not null,
zipcode		varchar(5)	not null,
stateid		numeric(2),
cityid		numeric(10),
constraint zipcode_zipcodeid_pk primary key (zipcodeid),
constraint zipcode_stateid_fk foreign key (stateid) references state(stateid),
constraint zipcode_cityid_fk foreign key (cityid) references city(cityid));


create table membership(
membershipid		numeric(10)	not null,
membershiptype		varchar(128)	not null,
membershiplimitpermonth	numeric(2)	not null,
membershipmonthlyprice	numeric(5,2)	not null,
membershipmonthlytax	numeric(5,2)	not null,
membershipdvdlostprice	numeric(5,2)	not null,
constraint membership_membershipid_pk primary key (membershipid));

create table member(
memberid		numeric(12)	not null,
memberfirstname		varchar(32)	not null,
memberlastname		varchar(32)	not null,
memberinitial		varchar(32),
memberaddress		varchar(100)	not null,
memberaddressid		numeric(10)	not null,
memberphone		varchar(14),
memberemail		varchar(32)	not null,
memberpassword		varchar(32)	not null,
membershipid		numeric(10)	not null,
membersincedate		datetime		not null,
constraint member_memberid_pk primary key (memberid),
constraint member_memberaddid_fk 
	foreign key (memberaddressid) references zipcode(zipcodeid),
constraint member_membershipid_fk
	foreign key (membershipid) references membership);

create table payment(
paymentid		numeric(16)	not null,
memberid		numeric(12)	not null,
amountpaid		numeric(8,2)	not null,
amountpaiddate		datetime		not null,
amountpaiduntildate	datetime		not null,
constraint payment_paymentid_pk primary key (paymentid),
constraint payment_memberid_fk foreign key (memberid) references member(memberid));

create table genre(
genreid			numeric(2)	not null,
genrename		varchar(20)	not null,
constraint genre_genreid_pk primary key (genreid));


create table rating(
ratingid		numeric(2)	not null,
ratingname		varchar(10)	not null,
ratingdescription	varchar(255)	not null,
constraint rating_ratingid_pk primary key (ratingid));


create table role(
roleid			numeric(2)	not null,
rolename		varchar(20)	not null,
constraint role_roleid_pk primary key (roleid));


create table movieperson(
personid		numeric(12)	not null,
personfirstname		varchar(32)	not null,
personlastname		varchar(32)	not null,
personinitial		varchar(32),		
persondateofbirth	datetime,
constraint movieperson_personid_pk primary key (personid));

create table dvd(
dvdid			numeric(16)	not null,
dvdtitle		varchar(32)	not null,
genreid			numeric(2)	not null,
ratingid		numeric(2)	not null,
dvdreleasedate		datetime		not null,
theaterreleasedate	datetime,
dvdquantityonhand	numeric(8)	not null,
dvdquantityonrent	numeric(8)	not null,
dvdlostquantity		numeric(8)	not null,
constraint dvd_dvdid_pk primary key (dvdid),
constraint dvd_genreid_fk foreign key (genreid) references genre(genreid),
constraint dvd_ratingid foreign key (ratingid) references rating(ratingid));

create table rentalqueue(
memberid		numeric(12)	not null,
dvdid			numeric(16)	not null,
dateaddedinqueue	datetime		not null,
constraint rentalqueue_memberid_dvdid_pk primary key (memberid,dvdid),
constraint rentalqueue_memberid_fk foreign key (memberid) references member(memberid),
constraint rentalqueue_dvdid_fk foreign key (dvdid) references dvd(dvdid));

create table moviepersonrole(
personid		numeric(12)	not null,
roleid			numeric(2)	not null,
dvdid			numeric(16)	not null,
constraint moviepersonrole_pk primary key (personid,dvdid,roleid),
constraint moviepersonrole_personid_fk foreign key (personid) references movieperson(personid),
constraint moviepersonrole_dvdid_fk foreign key (dvdid) references dvd(dvdid),
constraint moviepersorole_roleind_fk foreign key (roleid) references role(roleid))

create table rental(
rentalid		numeric(16)	not null,
memberid		numeric(12)	not null,
dvdid			numeric(16)	not null,
rentalrequestdate	datetime		not null,
rentalshippeddate	datetime,
rentalreturneddate	datetime,
constraint rental_rentalid_pk primary key (rentalid),
constraint rental_memberid_fk foreign key (memberid) references member(memberid),
constraint rental_dvdid_fk foreign key (dvdid) references dvd(dvdid))

/* queries for the insertion */ 

declare @addyears int = datepart(year, getdate()) - 2005;

insert into membership(membershipid,membershiptype,membershiplimitpermonth,
		membershipmonthlyprice,membershipmonthlytax,membershipdvdlostprice) 
	values(1,'3 dvds at-a-time',99,17.99,1.79,25.00);
insert into membership(membershipid,membershiptype,membershiplimitpermonth,
		membershipmonthlyprice,membershipmonthlytax,membershipdvdlostprice) 
	values(2,'2 dvds at-a-time',4,11.99,1.19,25.00);
insert into state(stateid,statename) values (1,'california');
insert into state(stateid,statename) values (2,'delaware');
insert into state(stateid,statename) values (3,'florida');
insert into state(stateid,statename) values (4,'georgia');
insert into state(stateid,statename) values (5,'iowa');
insert into state(stateid,statename) values (6,'new jersey');
insert into state(stateid,statename) values (7,'new york');

insert into city(cityid,cityname) values (1,'sacramento');
insert into city(cityid,cityname) values (2,'ewing');
insert into city(cityid,cityname) values (3,'new york');
insert into city(cityid,cityname) values (4,'palm coast');
insert into city(cityid,cityname) values (5,'harrisburg');
insert into city(cityid,cityname) values (6,'york');
insert into city(cityid,cityname) values (7,'jacksonville');

insert into zipcode(zipcodeid,zipcode,cityid,stateid) values (1,'94203',1,1);
insert into zipcode(zipcodeid,zipcode,cityid,stateid) values (2,'08628',2,6);
insert into zipcode(zipcodeid,zipcode,cityid,stateid) values (3,'10001',3,7);
insert into zipcode(zipcodeid,zipcode,cityid,stateid) values (4,'32035',4,3);
insert into zipcode(zipcodeid,zipcode,cityid,stateid) values (5,'17100',5,9);
insert into zipcode(zipcodeid,zipcode,cityid,stateid) values (6,'17400',6,9);
insert into zipcode(zipcodeid,zipcode,cityid,stateid) values (7,'32099',7,3);
delete from member

insert into member(memberid,memberfirstname,memberlastname,memberaddress,
	memberaddressid,memberemail,memberpassword,membershipid,membersincedate)
	values (1,'will','smith','101 will street',1,'will.smith@mib.com','w1ll1m!',1,dateadd(year, @addyears, '02/01/2004'));
insert into member(memberid,memberfirstname,memberlastname,memberaddress,
	memberaddressid,memberemail,memberpassword,membershipid,membersincedate)
	values (2,'john','gore','45 5th ave',2,'john45@yahoo.com','j0hngore',2,dateadd(year, @addyears, '02/02/2004'));
insert into member(memberid,memberfirstname,memberlastname,memberaddress,
	memberaddressid,memberemail,memberpassword,membershipid,membersincedate)
	values (3,'mike','sawicki','10 penn blvd',3,'mikesawicki@aol.com','saw13ki',2,dateadd(year, @addyears, '02/09/2004'));
insert into member(memberid,memberfirstname,memberlastname,memberaddress,
	memberaddressid,memberemail,memberpassword,membershipid,membersincedate)
	values (4,'ramesh','mandadi','9 avelon apt',4,'ramesh1@yahoo.com','ram3sh',1,dateadd(year, @addyears, '02/11/2004'));
insert into member(memberid,memberfirstname,memberlastname,memberaddress,
	memberaddressid,memberemail,memberpassword,membershipid,membersincedate)
	values (5,'frank','cruthers','1129 jackson rd',5,'franky@aol.com','qw1est',2,dateadd(year, @addyears, '02/12/2004'));
insert into member(memberid,memberfirstname,memberlastname,memberaddress,
	memberaddressid,memberemail,memberpassword,membershipid,membersincedate)
	values (6,'rich','sentveld','1001 plainsboro rd',6,'richard@aol.com','r1chard',1,dateadd(year, @addyears, '02/12/2004'));

insert into payment(paymentid,memberid,amountpaid,amountpaiddate,amountpaiduntildate)
	values (1,1,19.78,dateadd(year, @addyears, '02/01/2004'),dateadd(year, @addyears, '03/01/2004'));
insert into payment(paymentid,memberid,amountpaid,amountpaiddate,amountpaiduntildate)
	values (2,2,19.78,dateadd(year, @addyears, '02/02/2004'),dateadd(year, @addyears, '03/02/2004'));
insert into payment(paymentid,memberid,amountpaid,amountpaiddate,amountpaiduntildate)
	values (3,3,13.18,dateadd(year, @addyears, '02/09/2004'),dateadd(year, @addyears, '03/09/2004'));
insert into payment(paymentid,memberid,amountpaid,amountpaiddate,amountpaiduntildate)
	values (4,4,19.98,dateadd(year, @addyears, '02/11/2004'),dateadd(year, @addyears, '03/11/2004'));
insert into payment(paymentid,memberid,amountpaid,amountpaiddate,amountpaiduntildate)
	values (5,5,13.18,dateadd(year, @addyears, '02/12/2004'),dateadd(year, @addyears, '03/12/2004'));
insert into payment(paymentid,memberid,amountpaid,amountpaiddate,amountpaiduntildate)
	values (6,6,19.78,dateadd(year, @addyears, '02/12/2004'),dateadd(year, @addyears, '03/12/2004'));
insert into payment(paymentid,memberid,amountpaid,amountpaiddate,amountpaiduntildate)
	values (7,7,13.18,dateadd(year, @addyears, '02/14/2004'),dateadd(year, @addyears, '03/14/2004'));


insert into genre(genreid,genrename) values (1,'action');
insert into genre(genreid,genrename) values (2,'adventure');
insert into genre(genreid,genrename) values (3,'comedy');
insert into genre(genreid,genrename) values (4,'crime');
insert into genre(genreid,genrename) values (5,'drama');
insert into genre(genreid,genrename) values (6,'epics');
insert into genre(genreid,genrename) values (7,'musicals');

insert into rating(ratingid,ratingname,ratingdescription) values (1,'g','general audiences. all ages admitted.');
insert into rating(ratingid,ratingname,ratingdescription) values (2,'pg','parental guidance suggested. some material
 may not be suitable for children.');
insert into rating(ratingid,ratingname,ratingdescription) values (3,'pg-13','parent strongly cautioned.
some material may be inappropriate for children under 13.');
insert into rating(ratingid,ratingname,ratingdescription) values (4,'r','restricted. under 17 requires accompanying 
parent or adult guardian.');
insert into rating(ratingid,ratingname,ratingdescription) values (5,'nc-17','no one 17 and under admitted.');
insert into role(roleid,rolename) values (1,'actor');
insert into role(roleid,rolename) values (2,'actoress');
insert into role(roleid,rolename) values (3,'director');
insert into role(roleid,rolename) values (4,'producer');
insert into role(roleid,rolename) values (5,'screenwriter');

insert into movieperson(personid,personfirstname,personlastname,persondateofbirth)
	values (1,'bill','murry','09/21/1950');
insert into movieperson(personid,personfirstname,personlastname,persondateofbirth)
	values (2,'steven','spielberg','12/18/1946');
insert into movieperson(personid,personfirstname,personlastname,persondateofbirth)
	values (3,'tom','hanks','07/09/1956');
insert into movieperson(personid,personfirstname,personlastname,persondateofbirth)
	values (4,'leonardo','dicaprio','11/11/1974');
insert into movieperson(personid,personfirstname,personlastname,personinitial,persondateofbirth)
	values (5,'night','shyamalan','m','08/06/1970');
insert into movieperson(personid,personfirstname,personlastname,persondateofbirth)
	values (6,'bruce','willis','03/19/1955');
insert into movieperson(personid,personfirstname,personlastname,persondateofbirth)
	values (7,'catherine','zeta-zones','09/20/1969');


insert into dvd(dvdid,dvdtitle,genreid,ratingid,dvdreleasedate,
		theaterreleasedate,dvdquantityonhand,dvdquantityonrent,dvdlostquantity)
	values (1,'groundhog day',3,2,'01/22/2002','01/22/2001',9,0,1);
insert into dvd(dvdid,dvdtitle,genreid,ratingid,dvdreleasedate,
		theaterreleasedate,dvdquantityonhand,dvdquantityonrent,dvdlostquantity)
	values (2,'the terminal',5,2,'11/23/2003','01/22/2003',9,1,0);
insert into dvd(dvdid,dvdtitle,genreid,ratingid,dvdreleasedate,
		theaterreleasedate,dvdquantityonhand,dvdquantityonrent,dvdlostquantity)
	values (3,'catch me if you can',5,3,'05/06/2003','01/04/2002',10,0,0);
insert into dvd(dvdid,dvdtitle,genreid,ratingid,dvdreleasedate,
		theaterreleasedate,dvdquantityonhand,dvdquantityonrent,dvdlostquantity)
	values (4,'the sixth sense',12,4,'03/28/2000','05/01/1999',9,1,0);
insert into dvd(dvdid,dvdtitle,genreid,ratingid,dvdreleasedate,
		theaterreleasedate,dvdquantityonhand,dvdquantityonrent,dvdlostquantity)
	values (5,'pale rider',10,4,'11/19/1997','11/15/1985',0,1,0);


insert into moviepersonrole(personid,roleid,dvdid) values(1,1,1);
insert into moviepersonrole(personid,roleid,dvdid) values(2,3,2);
insert into moviepersonrole(personid,roleid,dvdid) values(2,3,3);
insert into moviepersonrole(personid,roleid,dvdid) values(3,1,2);
insert into moviepersonrole(personid,roleid,dvdid) values(3,1,3);
insert into moviepersonrole(personid,roleid,dvdid) values(4,1,3);
insert into moviepersonrole(personid,roleid,dvdid) values(5,3,4);
insert into moviepersonrole(personid,roleid,dvdid) values(5,1,4);
insert into moviepersonrole(personid,roleid,dvdid) values(5,4,4);

insert into rental(rentalid,memberid,dvdid,rentalrequestdate,rentalshippeddate,rentalreturneddate)
 values (1,1,4,dateadd(year, @addyears, '02/02/2004'),dateadd(year, @addyears, '02/02/2004'),dateadd(year, @addyears, '02/09/2004'));
insert into rental(rentalid,memberid,dvdid,rentalrequestdate,rentalshippeddate,rentalreturneddate)
 values (2,1,6,dateadd(year, @addyears, '02/02/2004'),dateadd(year, @addyears, '02/02/2004'),dateadd(year, @addyears, '02/09/2004'));
insert into rental(rentalid,memberid,dvdid,rentalrequestdate,rentalshippeddate,rentalreturneddate)
 values (3,1,3,dateadd(year, @addyears, '02/02/2004'),dateadd(year, @addyears, '02/02/2004'),dateadd(year, @addyears, '02/09/2004'));
insert into rental(rentalid,memberid,dvdid,rentalrequestdate,rentalshippeddate)
 values (4,5,4,dateadd(year, @addyears, '02/15/2004'),dateadd(year, @addyears, '02/15/2004'));
insert into rental(rentalid,memberid,dvdid,rentalrequestdate,rentalshippeddate)
 values (5,5,5,dateadd(year, @addyears, '02/15/2004'),dateadd(year, @addyears, '02/15/2004'));
insert into rental(rentalid,memberid,dvdid,rentalrequestdate,rentalshippeddate,rentalreturneddate)
 values (6,15,1,dateadd(year, @addyears, '02/12/2004'),dateadd(year, @addyears, '02/12/2004'),dateadd(year, @addyears, '02/21/2004'));
insert into rental(rentalid,memberid,dvdid,rentalrequestdate,rentalshippeddate)
 values (7,9,2,dateadd(year, @addyears, '02/19/2004'),dateadd(year, @addyears, '02/19/2004'));


SELECT dbo.DVD.DVDId, dbo.Genre.GenreId, dbo.Genre.GenreName
FROM dbo.Genre
INNER JOIN
dbo.DVD 
ON dbo.Genre.GenreId = dbo.DVD.GenreId CROSS JOIN dbo.City

SELECT dbo.City.CityId, dbo.Member.MemberId, dbo.Member.MemberFirstName, dbo.Rating.RatingId, dbo.Rating.RatingDescription
FROM  dbo.City CROSS JOIN
dbo.Member CROSS JOIN dbo.Rating

SELECT Membership.MembershipId, MoviePerson.PersonId, Payment.PaymentId
FROM Genre CROSS JOIN Membership CROSS JOIN
                         MoviePerson CROSS JOIN
                         Payment

SELECT dbo.Genre.GenreId, dbo.DVD.DVDId, dbo.Payment.PaymentId, dbo.Payment.AmountPaid, dbo.Member.MemberFirstName, dbo.Member.MemberLastName
FROM   dbo.Payment INNER JOIN
                         dbo.Member ON dbo.Payment.MemberId = dbo.Member.MemberId CROSS JOIN
                         dbo.DVD INNER JOIN
                         dbo.Genre ON dbo.DVD.GenreId = dbo.Genre.GenreId

SELECT dbo.Rental.RentalId, dbo.City.CityName, dbo.Genre.GenreName, dbo.Role.RoleId
FROM  dbo.City CROSS JOIN
                         dbo.Genre CROSS JOIN
                         dbo.Rental CROSS JOIN
                         dbo.Role CROSS JOIN
