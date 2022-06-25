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
PhoneNumber int,
email varchar(255)

)

