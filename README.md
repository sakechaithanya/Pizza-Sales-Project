
🍕 Pizza Sales SQL Analysis Project

A complete **end‑to‑end SQL portfolio project** that builds a small “Pizza Hut” data mart, explores the data with window functions & CTEs, and answers 15+ business questions about revenue, order patterns, and menu performance.
🗄️  Schema overview

Table

Purpose

Key columns

orders

Order header

order_id (PK), order_date, order_time

order_details

Line items

order_details_id (PK), order_id, pizza_id, quantity

pizzas

Menu items & prices

pizza_id (PK), pizza_type_id, size, price

pizza_types

Flavour/category metadata

pizza_type_id (PK), name, category

A convenience fact table pizza_sales (built in 00_setup_fact_table.sql) joins the four bases.

📈  Business questions answered

Total orders placed

Total revenue generated

Highest‑priced pizza

Most common pizza size

Top 5 pizzas by quantity

Quantity by category

Orders by hour of day

Avg pizzas per day

Top 3 pizzas by revenue

% revenue by type

Cumulative revenue timeline

Top 3 pizzas within each category (dense_rank)

KPI suite: total revenue, AOV, pizzas sold, etc.

See all SQL in analysis/.
