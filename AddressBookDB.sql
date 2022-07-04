/*UC1 - Creating AddressBookService DataBase*/

create database AddressBookService

/*UC2 - Creating table */

create table AddressBook(
firstName varchar(255) not null,
lastname varchar(255) not null,
Address varchar(255) not null,
City varchar(255) not null,
State varchar(255) not null,
Zip int not null,
PhoneNumber bigint,
email varchar(255)
)

/*UC3 - Inserting data into AddressBook table*/
insert into AddressBook (firstName,lastname,Address,City,State,Zip,PhoneNumber,email) values('Tushar','Vidwans','Malkapur','Akola','Maharashtra',444002,9096486283,'tusharvidwans99@gmail.com')
insert into AddressBook values
('Saran','Yellanki','Kurmannapalem','Vizag','Andhra Pradesh',530046,9618058892,'saran.yellanki12@gmail.com'),
('Shubham','Verma','Gachibowli','Hyderabad','Telangana',520017,9775638892,'shubham.verma@yahoo.co.in'),
('Madhukar','Tatiraju','Gurudwar','Vizag','Andhra Pradesh',530032,9347665123,'mad.t@gmail.com'),
('Basila','Noushad','Mattancherry','Kochi','Kerala',510033,9688920910,'basila.noushad@yahoo.com'),
('Manasa','Pochiraju','Steel Plant','Vizag','Andhra Pradesh',530032,9848553322,'manasa.p@yahoo.com'),
('Sai','Chandu','Chanda Nagar','Hyderabad','Telangana',540081,9909339211,'saichandu998@gmail.com')

/*UC4 - Editing contact by their name*/
update AddressBook
set firstName='Sumit'
where firstName='Shubham'

select * from AddressBook

/*UC5 - Deleting contact person by their name*/

delete AddressBook
where firstName='Basila' and lastname='Noushad'

/*UC6 - Retrieving person contact base on City or State*/
select * from AddressBook
where City='Vizag'

select * from AddressBook
where State='Telangana'


/*UC7 - Getting size of the AddressBook by city or state*/

select City, count(City) from AddressBook
Group BY City

select State, count(State) from AddressBook
Group by State

/*UC8 - Retrieving Person contact in alphabetical order by name for given city*/
select * from AddressBook 
where City='Vizag'
order by firstName asc

-- UC9 - identifying addressbook by name and it's type

alter table AddressBook add addressName varchar(50), type varchar(50)

alter table AddressBook drop column type  --to delete the coloumn

exec sp_rename 'AddressBook.addressName', 'addressBookName', 'column'  --use to change the name of the column

update AddressBook
set addressBookName='A', type='Family'
where firstName in ('Madhukar','Sumit');

select * from AddressBook

update addressBook
set addressBookName='B' ,type='Friends'
where firstName not in ('Madhukar','Sumit');


--UC10- getting count by type
select type, count(*) from AddressBook
group BY type

--UC11 - adding same contact with different type in table UC11
select * from AddressBook

insert into AddressBook
values ('Saran','Yellanki','Kurmannapalem','Vizag','Andhra Pradesh',530046,9618058892,'saran.yellanki12@gmail.com','B','Family')

select * from addressBook;
select type,count(*)
from AddressBook
group by type

--UC12
--Creating different entities in the table and doing normalization UC12
--creating table typeofcontacts
create table TypesOfContacts
(
typeid int primary key ,
typename varchar(50) not null)

--inserting data into type of contacts

insert into TypesOfContacts 
values (1,'Family'),(2,'Friends'),(3,'Business')

select * from TypesOfContacts

--altering address book to add contact id
alter table AddressBook
add contactid int primary key identity(1,1)

select * from AddressBook

--creating table address bok names which will contain the names of address book
create table AddressBookNames
(
addressBookId int primary key identity(1,1),
addressBookName varchar(50) not null
)

--inserting data into address book names
insert into AddressBookNames
values ('A'),('B'),('C')

select * from AddressBookNames

--creating table addressbookmapper which will contain contact id and address book names id
create table addressBookMapper
(
contactid int not null,
addressbookid int not null
)

--inserting data into address book mapper id
insert into addressBookMapper
values (1,1),(2,1),(3,2)

select * from addressBookMapper
--deleting redundant row from address book
select * from AddressBook

delete from AddressBook
where firstName='Saran' and contactid=5

select * from AddressBook

select a.firstname,a.phoneNumber,a.city,a.state,a.eMail,b.addressbookname
from AddressBook a
join addressbookMapper d
on a.contactid= d.contactId
join AddressBookNames b
on b.addressBookId= d.addressbookId

--creating typemapper table to map types names to contacts
create table typeMapper
(
contactid int not null,
typeid int not null
)

--inserting data into typeMapper

insert into typeMapper
values (1,1),(2,2),(3,2),(2,3)

select a.firstname,tc.typename
from addressbook a
join typeMapper t
on t.contactid= a.contactid
join TypesOfContacts tc
on tc.typeid= t.typeid


--UC13
--Retrieving data using new table structure
	--UC6
	select firstname,lastname,city from AddressBook
	where city='Vizag'

	--UC7
	select city,count(*)
	from addressbook
	where city='Vizag'
	group by city

	--UC8
	select * from 
	addressbook
	where city='Vizag'
	order by firstname,lastname

	--UC10
	select * from addressbook;

	select typename,count(*) numberOfContactPersons from addressbook a
	join typeMapper tm
	on tm.contactid= a.contactid
	join TypesOfContacts t
	on t.typeid= tm.typeid
	group by t.typename


	alter table addressbook
	drop column type

	alter table addressBookMapper
	add constraint foreignkey1 Foreign key(addressbookid) references addressbooknames(addressbookid)

	alter table addressBookMapper
	add constraint foreignkey2 Foreign key(contactid) references addressbook(contactid)

	alter table typeMapper
	add constraint foreignkey3 Foreign key(contactid) references addressbook(contactid)

	alter table typeMapper
	add constraint foreignkey5 foreign key(typeid) references typesofcontacts(typeid)