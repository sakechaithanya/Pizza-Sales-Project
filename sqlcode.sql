create database pizzahut
use pizzahut
create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id));

create table order_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id)
)
select * from orders;
select * from order_details;
select * from pizzas;
select count(*) from order_details;

-- Retrieve the total number of orders placed.
select count(order_id) from orders;

-- Calculate the  revenue generated from  each pizza sales.
select  p.pizza_id as id,
p.price as price,
od.quantity as quantity, 
(p.price * od.quantity) as totalRevenue
from pizzas p, order_details od
where p.pizza_id=od.pizza_id
;


-- Calculate the total revenue generated from pizza sales.
select 
round(sum(p.price * od.quantity),2) as totalRevenue
from pizzas p, order_details od
where p.pizza_id=od.pizza_id;


-- Identify the highest-priced pizza.
select * from pizza_types;
select * from pizzas;

select 
pt.name,ps.price
from pizzas ps, pizza_types pt
where ps.pizza_type_id=pt.pizza_type_id
order by ps.price desc limit 1;

-- Identify the most common pizza size ordered.
select * from pizza_types;
select * from pizzas;
select * from order_details;
select * from orders;

SELECT 
    p.size, COUNT(size) counts
FROM
    pizzas p,
    order_details od
WHERE
    p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY counts DESC
LIMIT 1;

SELECT 
    p.size, COUNT(order_details_id) counts
FROM
    pizzas p,
    order_details od
WHERE
    p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY counts DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
select * from pizzas;
select * from order_details;
select * from pizza_types;


select pizza_types.name,
sum(order_details.quantity) qt
from pizzas  join pizza_types 
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details 
on order_details.pizza_id= pizzas.pizza_id
group by pizza_types.name
order by  sum(order_details.quantity) desc
limit 5;



-- Join the necessary tables to find the total quantity of each pizza category ordered.
select * from pizzas;
select * from order_details;
select *from pizza_types;

SELECT 
    pizza_types.category, SUM(order_details.quantity) AS qt
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY SUM(order_details.quantity) DESC;


-- Determine the distribution of orders by hour of the day.

select hour(order_time) as hr,
count(order_id) ct 
from orders
group by hour(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas

select  category ,
count(category) countt
from  pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select * from order_details;
select * from orders;


select order_date, avg(qt) average
from(
select order_date, sum(quantity) as qt
from orders join order_details
on orders.order_id=order_details.order_id
group by order_date) t
group by  order_date;


-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name,
sum(price*quantity) rev
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
join pizza_types on
pizza_types.pizza_type_id=pizzas.pizza_type_id
group by pizza_types.name
order by rev desc limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category,
round((sum(price*quantity) / (select sum(p.price * od.quantity) as totalRevenue
from pizzas p, order_details od
where p.pizza_id=od.pizza_id))*100,2 ) as percentage
from pizzas join order_details
on pizzas.pizza_id=order_details.pizza_id
join pizza_types on
pizza_types.pizza_type_id=pizzas.pizza_type_id
group by pizza_types.category
order by percentage desc;


-- Analyze the cumulative revenue generated over time.

select order_date,
sum(revenue) over(order by order_date) as cum_revenue
from
(select orders.order_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select * from pizza_types;
select * from pizzas;
select * from order_details;


select category,
name,
totalrev,rk
from(
select *,
dense_rank() over(partition by category order by totalrev desc ) as rk
from
(select category, pizza_types.name,
sum(order_details.quantity*pizzas.price) as totalrev
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details on
pizzas.pizza_id=order_details.pizza_id
group by category,pizza_types.name) as t) b
where rk <=3;


------ 

WITH revenue_ranked AS (
    SELECT  category,
            pizza_types.name,
            SUM(order_details.quantity * pizzas.price) AS totalrev,
            DENSE_RANK() OVER (PARTITION BY category
                               ORDER BY SUM(order_details.quantity * pizzas.price) DESC) AS rk
    FROM            pizza_types
    JOIN            pizzas        ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    JOIN            order_details ON pizzas.pizza_id        = order_details.pizza_id
    GROUP BY        category, pizza_types.name
)

SELECT  *
FROM    revenue_ranked
WHERE   rk <= 3
ORDER BY category, rk;
