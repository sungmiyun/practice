create table test1(
    id varchar2(10),
    age number(3)
);

create table test2(
	num number not null primary key,
	title varchar2(30) not null,
	name varchar2(30) not null,
	memo varchar2(4000) not null,
	email varchar2(30),
	reg_date date not null
);

create sequence test2_seq;

