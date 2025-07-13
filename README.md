
🍕 Pizza Sales SQL Analysis Project

A complete **end‑to‑end SQL portfolio project** that builds a small “Pizza Hut” data mart, explores the data with window functions & CTEs, and answers 15+ business questions about revenue, order patterns, and menu performance.
| Table           | Purpose                   | Key columns                                                 |
| --------------- | ------------------------- | ----------------------------------------------------------- |
| `orders`        | Order header              | `order_id` (PK), `order_date`, `order_time`                 |
| `order_details` | Line items                | `order_details_id` (PK), `order_id`, `pizza_id`, `quantity` |
| `pizzas`        | Menu items & prices       | `pizza_id` (PK), `pizza_type_id`, `size`, `price`           |
| `pizza_types`   | Flavour/category metadata | `pizza_type_id` (PK), `name`, `category`                    |

📈 Business questions answered

1.Total orders placed

2.Total revenue generated

3.Highest‑priced pizza

4.Most common pizza size

5.Top 5 pizzas by quantity

6.Quantity by category

7.Orders by hour of day

8.Avg pizzas per day

9.Top 3 pizzas by revenue

10.% revenue by type

11.Cumulative revenue timeline

12.Top 3 pizzas within each category (dense_rank)

KPI suite: total revenue, AOV, pizzas sold, etc.

See all SQL in analysis/.
