create table if not exists supplier (supp_id int primary key, supp_name varchar(50) not null, 
supp_city varchar(50) not null, supp_phone varchar(50) not null);

create table if not exists customer (cus_id int primary key, cus_name varchar(50) not null, 
cus_phone varchar(50) not null, cus_city varchar(50) not null, cus_gender char);

create table if not exists category (cat_id int primary key, cat_name varchar(20) not null);

create table if not exists product (pro_id int primary key, 
pro_name varchar(20) default "Dummy",
pro_desc varchar(60), cat_id int,
constraint fk_cat_id foreign key(cat_id) references category(cat_id));

create table if not exists supplier_pricing (pricing_id int primary key,
pro_id int, supp_id int, supp_price int,
constraint fk_pro_id foreign key(pro_id) references product(pro_id),
constraint fk_supp_id foreign key(supp_id) references supplier(supp_id));

create table if not exists orders (ord_id int primary key, ord_amount int not null,
ord_date date not null, cus_id int, pricing_id int,
constraint fk_cus_id foreign key(cus_id) references customer(cus_id),
constraint fk_pricing_id foreign key(pricing_id) references supplier_pricing(pricing_id));

create table if not exists rating (rat_id int primary key, ord_id int, rat_ratstars int not null,
constraint fk_ord_id foreign key(ord_id) references orders(ord_id));

INSERT INTO SUPPLIER VALUES(1,"Rajesh Retails","Delhi",'1234567890');
INSERT INTO SUPPLIER VALUES(2,"Appario Ltd.","Mumbai",'2589631470');
INSERT INTO SUPPLIER VALUES(3,"Knome products","Banglore",'9785462315');
INSERT INTO SUPPLIER VALUES(4,"Bansal Retails","Kochi",'8975463285');
INSERT INTO SUPPLIER VALUES(5,"Mittal Ltd.","Lucknow",'7898456532');

INSERT INTO CUSTOMER VALUES(1,"AAKASH",'9999999999',"DELHI",'M');
INSERT INTO CUSTOMER VALUES(2,"AMAN",'9785463215',"NOIDA",'M');
INSERT INTO CUSTOMER VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO CUSTOMER VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO CUSTOMER VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');

INSERT INTO CATEGORY VALUES( 1,"BOOKS");
INSERT INTO CATEGORY VALUES(2,"GAMES");
INSERT INTO CATEGORY VALUES(3,"GROCERIES");
INSERT INTO CATEGORY VALUES (4,"ELECTRONICS");
INSERT INTO CATEGORY VALUES(5,"CLOTHES");

INSERT INTO PRODUCT VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
INSERT INTO PRODUCT VALUES(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
INSERT INTO PRODUCT VALUES(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4);
INSERT INTO PRODUCT VALUES(4,"OATS","Highly Nutritious from Nestle",3);
INSERT INTO PRODUCT VALUES(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
INSERT INTO PRODUCT VALUES(6,"MILK","1L Toned MIlk",3);
INSERT INTO PRODUCT VALUES(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4);
INSERT INTO PRODUCT VALUES(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
INSERT INTO PRODUCT VALUES(9,"Project IGI","compatible with windows 7 and above",2);
INSERT INTO PRODUCT VALUES(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
INSERT INTO PRODUCT VALUES(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
INSERT INTO PRODUCT VALUES(12,"Train Your Brain","By Shireen Stephen",1);

INSERT INTO SUPPLIER_PRICING VALUES(1,1,2,1500);
INSERT INTO SUPPLIER_PRICING VALUES(2,3,5,30000);
INSERT INTO SUPPLIER_PRICING VALUES(3,5,1,3000);
INSERT INTO SUPPLIER_PRICING VALUES(4,2,3,2500);
INSERT INTO SUPPLIER_PRICING VALUES(5,4,1,1000);
INSERT INTO SUPPLIER_PRICING VALUES(6,12,2,780);
INSERT INTO SUPPLIER_PRICING VALUES(7,12,4,789);
INSERT INTO SUPPLIER_PRICING VALUES(8,3,1,31000);
INSERT INTO SUPPLIER_PRICING VALUES(9,1,5,1450);
INSERT INTO SUPPLIER_PRICING VALUES(10,4,2,999);
INSERT INTO SUPPLIER_PRICING VALUES(11,7,3,549);
INSERT INTO SUPPLIER_PRICING VALUES(12,7,4,529);
INSERT INTO SUPPLIER_PRICING VALUES(13,6,2,105);
INSERT INTO SUPPLIER_PRICING VALUES(14,6,1,99);
INSERT INTO SUPPLIER_PRICING VALUES(15,2,5,2999);
INSERT INTO SUPPLIER_PRICING VALUES(16,5,2,2999);

INSERT INTO ORDERS VALUES (101,1500,"2021-10-06",2,1);
INSERT INTO ORDERS VALUES(102,1000,"2021-10-12",3,5);
INSERT INTO ORDERS VALUES(103,30000,"2021-09-16",5,2);
INSERT INTO ORDERS VALUES(104,1500,"2021-10-05",1,1);
INSERT INTO ORDERS VALUES(105,3000,"2021-08-16",4,3);
INSERT INTO ORDERS VALUES(106,1450,"2021-08-18",1,9);
INSERT INTO ORDERS VALUES(107,789,"2021-09-01",3,7);
INSERT INTO ORDERS VALUES(108,780,"2021-09-07",5,6);
INSERT INTO ORDERS VALUES(109,3000,"2021-09-10",5,3);
INSERT INTO ORDERS VALUES(110,2500,"2021-09-10",2,4);
INSERT INTO ORDERS VALUES(111,1000,"2021-09-15",4,5);
INSERT INTO ORDERS VALUES(112,789,"2021-09-16",4,7);
INSERT INTO ORDERS VALUES(113,31000,"2021-09-16",1,8);
INSERT INTO ORDERS VALUES(114,1000,"2021-09-16",3,5);
INSERT INTO ORDERS VALUES(115,3000,"2021-09-16",5,3);
INSERT INTO ORDERS VALUES(116,99,"2021-09-17",2,14);

INSERT INTO RATING VALUES(1,101,4);
INSERT INTO RATING VALUES(2,102,3);
INSERT INTO RATING VALUES(3,103,1);
INSERT INTO RATING VALUES(4,104,2);
INSERT INTO RATING VALUES(5,105,4);
INSERT INTO RATING VALUES(6,106,3);
INSERT INTO RATING VALUES(7,107,4);
INSERT INTO RATING VALUES(8,108,4);
INSERT INTO RATING VALUES(9,109,3);
INSERT INTO RATING VALUES(10,110,5);
INSERT INTO RATING VALUES(11,111,3);
INSERT INTO RATING VALUES(12,112,4);
INSERT INTO RATING VALUES(13,113,2);
INSERT INTO RATING VALUES(14,114,1);
INSERT INTO RATING VALUES(15,115,1);
INSERT INTO RATING VALUES(16,116,0);

-- Display the total number of customers based on gender who have 
-- placed orders of worth at least Rs.3000.

select cus_gender customer_gender, count(distinct customer.cus_id) count from customer 
customer join orders on customer.cus_id = orders.cus_id 
where orders.ord_amount >= 3000
group by cus_gender;

-- Display all the orders along with product name ordered by a customer having Customer_Id=2

select t2.ord_id order_id, t2.pro_id product_id, pro_name product_name from product join (
	select t1.ord_id, supplier_pricing.pro_id  from supplier_pricing join (
		select orders.* from orders where orders.cus_id = 2 ) t1 
	on supplier_pricing.pricing_id = t1.pricing_id ) t2 
on product.pro_id = t2.pro_id;

-- Display the Supplier details who can supply more than one product.

select supplier.* from supplier join (
	select supp_id, count(supp_id) count from supplier_pricing 
		group by supp_id 
		having count > 1) as t1 
on supplier.supp_id = t1.supp_id;


-- Find the least expensive product from each category and print the table with 
-- category id, name, product name and price of the product

select t2.cat_id category_id, t2.cat_name category_name, 
t2.pro_name product_name, min(t2.supp_price) product_min_price from (
	select t1.*, supplier_pricing.supp_price from supplier_pricing join (
		select category.cat_id, category.cat_name, product.pro_name, product.pro_id from product join category
			on product.cat_id = category.cat_id
			order by category.cat_id) as t1 
	on supplier_pricing.pro_id = t1.pro_id) as t2
group by cat_id;

-- Display the Id and Name of the Product ordered after “2021-10-05”

select product.pro_id Id, product.pro_name name from product join (
	select pro_id from supplier_pricing join (
		select orders.pricing_id from orders where ord_date > '2021-10-5') t1 
	on t1.pricing_id = supplier_pricing.pricing_id ) t2 
on t2.pro_id = product.pro_id;

-- Display customer name and gender whose names start or end with character 'A'.

select cus_name, cus_gender from customer where cus_name like 'A%' or cus_name like '%A';

-- Create a stored procedure to display supplier id, name, rating and Type_of_Service. 
-- For Type_of_Service, 
-- 		If rating =5, print “Excellent Service”,
-- 		If rating >4 print “Good Service”, 
-- 		If rating >2 print “Average Service” 
-- 		else print “Poor Service”.

DROP procedure IF EXISTS `service_rating`;
DELIMITER $$
USE `e_commerce`$$
CREATE PROCEDURE service_rating ()
BEGIN
select t2.supp_id as Id, t2.supp_name as name, rating.rat_ratstars as rating, 
case 
	when rating.rat_ratstars = 5 then 'Excellent Service'
    when rating.rat_ratstars > 4 then 'Good Service'
    when rating.rat_ratstars > 2 then 'Average Service'
    else 'Poor Service'
end as Type_of_Service
from rating join (
	select t1.supp_id, t1.supp_name, orders.ord_id from orders join (
		select supplier.supp_id, supplier.supp_name, supplier_pricing.pricing_id from supplier join supplier_pricing
			on supplier.supp_id = supplier_pricing.supp_id) t1
	on t1.pricing_id = orders.pricing_id) as t2 
on rating.ord_id = t2.ord_id;
END$$
DELIMITER ;

call `service_rating`();











