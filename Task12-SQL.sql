select * from sales

Create table Report_Table(
	product_id varchar primary key,
	sum_of_sales float ,
	sum_of_profit float 
	)

create or replace function update_product_report()
RETURNS trigger as $$
declare 
	sumOfSales float;
	sumOfProfit float;
	count_report int;
BEGIN
	select sum(sales) , sum(profit) into sumOfSales, sumOfProfit from sales 
	where product_id = NEW.product_id;

	select count(*) into count_report from Report_Table where product_id=NEW.product_id;

	if count_report = 0 THEN
	insert into Report_Table values (NEW.product_id, sumOfSales,sumOfProfit);
	else
		update Report_Table set  sum_of_sales = sumOfSales, sum_of_profit = sumOfProfit
		where  product_id=NEW.product_id;
	end if;
	REturn NEw;
END
$$ Language plpgsql

create trigger update_report_trigger
After insert on sales
for each row
execute function update_product_report()

select * from sales

select sum(sales), sum(profit) from sales where product_id = 'FUR-TA-10000577'

-- -532.7613, 7242.768000000001

select * from sales order by order_line DESC
	
insert into sales(order_line,order_id,order_date,ship_date,ship_mode,customer_id,product_id,sales,quantity,discount,profit)
values(9998,'US-2015-108966','2024-08-17','2024-08-24','Standard Class','SO-20335','FUR-TA-10000577',100,10,10,20)

select * from report_table


