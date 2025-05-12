drop database info;
create database info;
use info;
create table students(
unit tinyint unsigned not null auto_increment,
studentid int not null,
studentname text not null,
gender text not null,
dob datetime not null,
major text not null,
primary key (unit))engine=InnoDB default charset=utf8mb4;
insert into students
values 
(1, '00001', 'abc','f','1997-10-19','data science'),
(2, '00023', 'hej','m','1989-07-03','computer science'),
(3, '00034', 'hbeme','m','2000-01-30','biology'),
(4, '00076', 'owjdg','f','1994-12-28','chemisty'),
(5, '02001', 'iknebev','f','2006-03-01','biology'),
(6, '00301', 'osjeng','f','1999-11-09','engineer');
select * from students;
