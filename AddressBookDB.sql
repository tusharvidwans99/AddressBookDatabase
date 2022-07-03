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


--getting count by type
select type, count(*) from AddressBook
group BY type