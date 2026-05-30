create user booksdb identified by booksdb;
grant all privileges to booksdb;

create table books(
  book_id number(30) primary key,
  title varchar2(50) unique,
  author_id number(30) ,
  price number(15,2),
  publication_date date not null,
  genre_id number(30) ,
  constraint aut_id_fk foreign key (author_id) references authors(author_id),
  constraint gen_id_fk foreign key (genre_id) references genres(genre_id)

);
  
create table Authors (
 author_id number(30) primary key, 
 name varchar2(50) not null, 
 bio varchar2(50)
);	
 
create table Customers (
  customer_id number(30) primary key, 
  name varchar2(60) not null,
  email varchar2(50) unique , 
  phone number(30) not null
);

create table Orders (
 order_id number(30) primary key,
 customer_id number(35),
 order_date date not null, 
 total number(20),
   constraint cus_id_fk foreign key (customer_id) references customers(customer_id)
);

create table Order_Details (
 order_id number(30), 
 book_id number(30), 
 quantity number(30) not null,
    constraint or_id_fk foreign key (order_id) references orders(order_id),
    constraint book_id_fk foreign key (book_id) references books(book_id)
);

create table Genres (
 genre_id number(30) primary key,
 name varchar2(40) not null
);

insert into authors(author_id,name,bio)values(101,'malala yousafzai','bravery and determination');
insert into authors(author_id,name,bio)values(102,'aravind adiga','dark side of modern india');
insert into authors(author_id,name,bio)values(103,'vikram seth','indian society after independence');
insert into authors(author_id,name,bio)values(104,'paolo coelho','following your dreams');
insert into authors(author_id,name,bio)values(105,'jane austen','love,marriage and social class');

insert into Genres(Genre_id,name)values(1,'autobiography');
insert into Genres(Genre_id,name)values(2,'fiction');
insert into Genres(Genre_id,name)values(3,'family drama');
insert into Genres(Genre_id,name)values(4,'inspiration');
insert into Genres(Genre_id,name)values(5,'social novel');

--sample data of table books are imported from excel---------

insert into Customers (Customer_id,name,email,phone)values(501,'yafni','yafni@gmail.com',98878);
insert into Customers (Customer_id,name,email,phone)values(502,'plasit','plasit@gmail.com',3298878);
insert into Customers (Customer_id,name,email,phone)values(503,'chrysa','chrysa@gmail.com',76698878);
insert into Customers (Customer_id,name,email,phone)values(504,'diana','diana@gmail.com',87598878);
insert into Customers (Customer_id,name,email,phone)values(505,'daran','daran@gmail.com',123498878);

insert into Orders(Order_id,Customer_id,order_date,total )values(1,501,sysdate,2);
insert into Orders(Order_id,Customer_id,order_date,total )values(2,503,sysdate,8);
insert into Orders(Order_id,Customer_id,order_date,total )values(3,505,sysdate,9);
insert into Orders(Order_id,Customer_id,order_date,total )values(4,502,sysdate,20);
insert into Orders(Order_id,Customer_id,order_date,total )values(5,504,sysdate,32);

update orders set total=2000 where order_id=1;
update orders set total=8000 where order_id=2;
update orders set total=9000 where order_id=3;
update orders set total=5000 where order_id=4;
update orders set total=3000 where order_id=5;

insert into Order_Details(Order_id,book_id,quantity)values(5,1,3);
insert into Order_Details(Order_id,book_id,quantity)values(4,2,71);
insert into Order_Details(Order_id,book_id,quantity)values(3,3,2);
insert into Order_Details(Order_id,book_id,quantity)values(2,4,44);
insert into Order_Details(Order_id,book_id,quantity)values(1,5,30);

CREATE OR REPLACE VIEW author_book AS 
select a.title,b.name,a.price,b.author_id from books a join  Authors b on a.author_id=b.author_id;


select * from author_book;
select * from author_book where name='vikram seth';	
select * from author_book where name='malala yousafzai';

CREATE OR REPLACE  VIEW tot_sales  AS 
select a.title,a.book_id,a.price,b.total,c.quantity from books a join order_details c  on a.book_id=c.book_id
join  orders b on b.order_id =c.order_id;

select * from tot_sales;	
select * from tot_sales where title='a suitable boy';


CREATE OR REPLACE VIEW total_sales  AS 
select a.title,a.price,b.quantity from books a join Order_Details b on a.book_id=b.book_id
;

select * from total_sales;	

CREATE OR REPLACE VIEW total_sale  AS 
select a.title,a.price,sum(b.quantity) total_quantity ,sum(b.quantity*a.price) total_sales 
from books a join Order_Details b on a.book_id=b.book_id
group by a.title,a.price;

select * from total_sale;	

CREATE OR REPLACE VIEW customer_or_his  AS 
select a.customer_id,a.name,b.Order_id,b.order_date,b.total,c.book_id,c.quantity from
customers a  left join orders b on a.customer_id=b.customer_id join Order_Details c
on b.Order_id=c.Order_id;

select * from customer_or_his;	
select * from customer_or_his order by customer_id asc;

set serveroutput on;
create or replace procedure add_nbook (
  n_book_id in number,
  n_title  in varchar2,
  n_author_id in number,
  n_price in number,
  n_publication_date in date ,
  n_genre_id in number)
  as

begin
   insert into books(book_id,title,author_id,price,publication_date,genre_id) values
   (n_book_id,n_title,n_author_id,n_price,n_publication_date,n_genre_id);
dbms_output.put_line('new book '|| n_title || n_book_id || n_price || n_publication_date ||' is added ');
commit;
end;
/

exec add_nbook(6,'till the last breath',105,800,sysdate,1);
exec add_nbook(7,' y&y ',104,8900,sysdate,5);
exec add_nbook(8,' a second chance ',102,8900,sysdate,2);

set serveroutput on;
create or replace procedure update_price (
  
  n_price in number,
  n_book_id in number)
  as

begin
   update books set price=n_price where book_id=n_book_id;
dbms_output.put_line('updated price of the book is '||n_price);

end;
/

exec update_price(1800,1);
exec update_price(2000,2);

create or replace procedure delete_or_ord (
d_order_id in number)
as

begin
delete  from order_details where order_id=d_order_id;

delete  from orders where order_id=d_order_id;
end;
/

exec delete_or_ord(1);
rollback;

select a.title book_name,a.book_id,b.author_id,b.name author_name,c.genre_id,c.name genre_name from books a join
authors b  on  a.author_id=b.author_id join genres c on a.genre_id=c.genre_id ;

select  a.title book_name,a.book_id,sum(b.quantity) total_sold  from books a join Order_Details b
on a.book_id=b.book_id group by  a.title, a.book_id order by total_sold desc ;

select * from orders a  join order_details b on a.order_id=b.order_id join customers c on a.customer_id=c.customer_id;

create index books_index on books(book_id,genre_id,title,author_id);
create index authors_index on authors(name);
create index orders_index on orders(order_id,customer_id);
create index customers_index on customers(name);

