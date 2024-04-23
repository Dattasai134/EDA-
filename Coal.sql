create database Ore_db;
use ore_db;

select * from coal_ore;

alter table coal_ore
drop column code;

UPDATE coal_ore
SET Coal_prices = round(coal_prices);

SET SQL_SAFE_UPDATES = 0;

select
min(coal_prices) as min_prices,
max(coal_prices) as max_prices,
avg(coal_prices) as avg_prices,
stddev(coal_prices) as std_dev_prices from coal_ore;

select * from coal_ore;

-- Data Distribution: Understand the distribution of coal prices over different years. --

select year,
count(*) as num_of_records,
min(coal_prices) as min_prices,
max(coal_prices) as max_prices,
avg(coal_prices) as avg_prices,
stddev(coal_prices) as std_dev_prices
from coal_ore
group by year;

-- Trend Analysis: Analyze the trend of coal prices over the years. --

select year,
avg(coal_prices) as avg_prices
from coal_ore
group by year order by year;

-- Seasonality Analysis: Determine if there are any seasonal patterns in coal prices. --

select
month(year) as month,
avg(coal_prices) as avg_prices
from coal_ore
group by month(year)
order by month;

-- correlation analysis --

select
entity,
CORR(year, coal_prices) as correlation
from coal_ore
group by entity;

-- Outlier detection --

select entity, year, coal_prices
from coal_ore
where coal_prices < (select avg(coal_prices) - 3 * stddev(coal_prices)
from coal_ore);

