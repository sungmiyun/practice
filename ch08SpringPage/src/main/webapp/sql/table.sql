/*회원관리*/
create table sprmember(
	mem_num number not null,
	id varchar2(12) unique not null,
	auth number(1) default 2 not null, /*0탈퇴회원, 1정지회원, 2일반회원, 3관리자*/
	constraint sprmember_pk primary key (mem_num)
);

create table sprmember_detail(
	mem_num number not null,
	name varchar2(30) not null,
	passwd varchar2(12) not null,
	phone varchar2(15) not null,
	email varchar2(50) not null,
	zipcode varchar2(5) not null,
	address1 varchar2(90) not null,
	address2 varchar2(90) not null,
	reg_date date default sysdate not null,
	modify_date date default sysdate not null,
	constraint sprmember_detail_pk primary key (mem_num),
	constraint sprmember_detail_fk foreign key (mem_num) references sprmember (mem_num)
);

create sequence sprmember_seq;


/* 게시판 */
create table sprboard(
	board_num number not null,
	title varchar2(100) not null,
	content clob not null,
	hit number(5) default 0 not null,
	reg_date date default sysdate not null,
	modify_date date default sysdate not null,
	uploadfile blob,
	filename varchar2(100),
	ip varchar2(40) not null,
	mem_num number not null,
	constraint sprboard_pk primary key(board_num), 
	constraint sprboard_fk foreign key (mem_num) references sprmember (mem_num)
);

create sequence sprboard_seq;


