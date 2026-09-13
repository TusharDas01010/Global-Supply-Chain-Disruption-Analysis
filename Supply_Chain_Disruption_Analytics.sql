# 1. What is the total trade volume handled each year?
SELECT
    YEAR(`date`) AS Year,
    round(SUM(trade_volume_tonnes),2) AS total_trade_volume
FROM weekly_route_operations
GROUP BY YEAR(`date`)
ORDER BY YEAR(`date`);

# 2.Find the average freight cost for each shipping method.
select
	tr.shipping_method,
    round(avg(wro.freight_cost_usd),2) as average_freight_cost 
from trade_routes tr
join weekly_route_operations wro
on tr.route_id = wro.route_id
group by tr.shipping_method;

# 3. Which trade routes handled the highest trade volume?
select
	tr.trade_route_type,
    round(sum(wro.trade_volume_tonnes),2) as total_trade_volume 
from trade_routes tr
join weekly_route_operations wro
on tr.route_id = wro.route_id
group by tr.trade_route_type
order by sum(wro.trade_volume_tonnes) desc;

# 4. Which countries have the highest Logistics Performance Index?
select
	country,
    sum(logistics_performance_index) as logistics_performance_index 
from country_metadata
group by country
order by logistics_performance_index desc;

# 5. Find the average shipping delay for each route.
select
	tr.trade_route_type,
    round(avg(wro.shipping_delay_days),0) as average_shipping_delay_days
from trade_routes tr 
join weekly_route_operations wro
on tr.route_id = wro.route_id
where wro.route_status = "Delayed"
group by tr.trade_route_type;

# 6. How many geopolitical events occurred each year?
select 
	YEAR(date) as Year,
    count(event_type) as total_geopolitical_events
from geopolitical_events
group by YEAR(date)
order by YEAR(date);

# 7. Find the average commodity prices by year.
select 
	YEAR(date) as Year,
    round(avg(oil_price),2) as avg_oil_price,
    round(avg(natural_gas_price),2) as avg_natural_gas_price,
    round(avg(steel_price),2) as avg_steel_price,
    round(avg(wheat_price),2) as avg_wheat_price,
    round(avg(copper_price),2) as avg_copper_price
from commodity_market
group by YEAR(date)
order by YEAR(date);

# 8. Which regions experienced the highest number of geopolitical events?
select
	affected_region as Region,
    count(event_type) as No_of_geopolitical_events
from geopolitical_events
group by affected_region
order by count(event_type) desc;

# 9. Calculate the average port congestion index each year.
select 
	YEAR(date) as Year,
    round(avg(port_congestion_index),2) as avg_port_congestion_index
from weekly_route_operations
group by YEAR(date)
order by YEAR(date) asc;

# 10. Which routes have been inactive (Closed)?
select distinct
    tr.route_id,
    tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type
from trade_routes tr
join weekly_route_operations wro
    on tr.route_id = wro.route_id
where wro.route_status = 'disrupted';

# 11.Which routes generated the highest freight cost?
select
	tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type,
    wro.freight_cost_usd
from trade_routes tr 
join weekly_route_operations wro
on tr.route_id = wro.route_id
order by wro.freight_cost_usd desc
limit 1;

# 12. Find the top 10 routes with the highest shipping delays.
select
    tr.route_id,
    tr.origin_country,
    tr.destination_country,
    round(sum(wro.shipping_delay_days), 0) as total_shipping_delay_days
from trade_routes tr
join weekly_route_operations wro
    on tr.route_id = wro.route_id
group by
    tr.route_id,
    tr.origin_country,
    tr.destination_country
order by total_shipping_delay_days desc
limit 10;

# 13. Calculate yearly growth in trade volume
with cte1 as (
select 
	year(date) as Year,
    round(sum(trade_volume_tonnes),2) as total_trade_volume
from weekly_route_operations
group by year(date)
),
cte2 as (
select
	Year,
    total_trade_volume,
    lag(total_trade_volume) over(order by Year) as Previous_year_trade_volume
from cte1
)
select
	Year,
    total_trade_volume,
    Previous_year_trade_volume,
	round((total_trade_volume -  Previous_year_trade_volume)*100/ Previous_year_trade_volume,2) as Growth_pct
from cte2;

# 14. Which countries depend the most on international trade?
select
	country,
    sum(trade_dependency_score) as Trade_dependency_score
from country_metadata
group by country
order by Trade_dependency_score desc;

# 15. Find countries where logistics performance is below the global average.
select 
	country,
    avg(logistics_performance_index) as logistics_performance_index
from country_metadata
group by country
having  avg(logistics_performance_index) <(select
	avg(logistics_performance_index)
from country_metadata);

# 16. Calculate average freight cost by region
select
	cm.region,
    round(avg(wro.freight_cost_usd),2) as avg_freight_cost
from country_metadata cm
join trade_routes tr 
on cm.country = tr.origin_country
join weekly_route_operations wro
on tr.route_id = wro.route_id
group by cm.region;

# 17. Identify months with the highest commodity stress index.
select
	monthname(date) as Months,
    round(avg(commodity_stress_index),2) as avg_commodity_stress_index
from commodity_market
group by Months
order by avg_commodity_stress_index desc;

# 18. Compare freight costs before and after major geopolitical events.
with daily_freight as (
    select
        date,
        avg(freight_cost_usd) as avg_freight
    from weekly_route_operations
    group by date
),

major_events as (
    select
        event_id,
        date as event_date,
        event_type,
        severity
    from geopolitical_events
    where severity >= 4
),

freight_comparison as (
    select
        ge.event_id,
        ge.event_date,
        ge.event_type,
        ge.severity,

        avg(
            case
                when df.date >= date_sub(ge.event_date, interval 28 day)
                 and df.date < ge.event_date
                then df.avg_freight
            end
        ) as avg_freight_before,

        avg(
            case
                when df.date > ge.event_date
                 and df.date <= date_add(ge.event_date, interval 28 day)
                then df.avg_freight
            end
        ) as avg_freight_after

    from major_events ge
    join daily_freight df
        on df.date between date_sub(ge.event_date, interval 28 day)
                       and date_add(ge.event_date, interval 28 day)

    group by
        ge.event_id,
        ge.event_date,
        ge.event_type,
        ge.severity
)

select
    event_id,
    event_date,
    event_type,
    severity,
    round(avg_freight_before, 2) as avg_freight_before,
    round(avg_freight_after, 2) as avg_freight_after,
    round(
        avg_freight_after - avg_freight_before,
        2
    ) as freight_cost_change,
    round(
        (avg_freight_after - avg_freight_before)
        / nullif(avg_freight_before, 0) * 100,
        2
    ) as percentage_change
from freight_comparison
order by event_date;

# 19 Which shipping method experiences the lowest delay?
select 
	shipping_method,
    sum(estimated_transit_days) as lowest_delay
from trade_routes
group by shipping_method
order by lowest_delay asc
limit 1;

# 20. Find the relationship between port congestion and shipping delays.
select
	case
		when port_congestion_index < 40 then "Low"
        when port_congestion_index < 60 then "Medium"
        else "High"
        end as congestion_level,
    round(avg(shipping_delay_days),0) as  avg_shipping_delays
from weekly_route_operations
group by  congestion_level;

# 21. Which trade routes have the highest carbon emissions?
select
	tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type,
    round(sum(wro.carbon_emissions_tonnes),2) as carbon_emissions
from trade_routes tr
join weekly_route_operations wro
on tr.route_id = wro.route_id
group by tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type
order by carbon_emissions desc limit 5;

# 22. Calculate average freight cost per tonne
SELECT
    ROUND(
        SUM(freight_cost_usd) / NULLIF(SUM(trade_volume_tonnes), 0),
        2
    ) AS freight_cost_per_tonne
FROM weekly_route_operations;

# 23. Find routes where freight costs increased despite decreasing trade volume.
select
	rc.date,
	tr.route_id,
    tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    rc.previous_volume,
    rc.trade_volume_tonnes,
    rc.previous_freight_cost,
    rc.freight_cost_usd
from trade_routes tr
join route_changes rc
on tr.route_id = rc.route_id
where rc.freight_cost_usd > rc.previous_freight_cost
and rc.trade_volume_tonnes < rc.previous_volume
order by rc.route_id, rc.date;

# 24. Which commodity price increased the most over the years?
with cte1 as (
select
	Year,
    Oil,
    lag(oil) over(order by Year) as previous_year_oil,
    Natural_gas,
	lag(Natural_gas) over(order by Year) as previous_year_Natural_gas,
    Steel,
	lag(Steel) over(order by Year) as previous_year_Steel,
    Wheat,
	lag(Wheat) over(order by Year) as previous_year_Wheat,
    Copper,
	lag(Copper) over(order by Year) as previous_year_Copper
from commodity_avg_prices
)
select
	Year,
	round((Oil - previous_year_oil)*100/previous_year_oil,2) as growth_pct_of_oil,
    round((Natural_gas -  previous_year_Natural_gas)*100/ previous_year_Natural_gas,2) as growth_pct_of_natural_gas,
    round((Steel -  previous_year_Steel)*100/ previous_year_Steel,2) as growth_pct_of_steel,
    round((Wheat - previous_year_Wheat)*100/previous_year_Wheat,2) as  growth_pct_of_wheat,
    round((Copper - previous_year_Copper)*100/previous_year_Copper,2) as growth_pct_of_copper
from cte1;

with price_change as (
    select
        min(date) as start_date,
        max(date) as end_date
    from commodity_market
)
select
    cm.date,
    cm.oil_price,
    cm.natural_gas_price,
    cm.steel_price,
    cm.wheat_price,
    cm.copper_price
from commodity_market cm
cross join price_change pc
where cm.date in (pc.start_date, pc.end_date);

# 25. Find countries with both high GDP per capita and poor logistics performance.
select 
	country,
    gdp_per_capita,
    logistics_performance_index
from country_metadata
where gdp_per_capita > (select avg(gdp_per_capita) from country_metadata)
and
logistics_performance_index < (select avg(logistics_performance_index) from country_metadata)
order by gdp_per_capita desc ;

# 26. Which geopolitical event caused the highest increase in freight cost?
select
    event_type,
    event_date,
    ROUND(freight_before, 2) as freight_before,
    ROUND(freight_after, 2) as freight_after,
    ROUND(freight_after - freight_before, 2) as freight_increase,
    ROUND(
        ((freight_after - freight_before) / freight_before) * 100,
        2
    ) as increase_percentage
from event_impact
where freight_before is not null
  and freight_after is not null
order by freight_increase desc
limit 1;

# 27. How many days after a geopolitical event do shipping delays remain elevated?
# 28. Identify top 10 high-risk trade routes based on:
#•	Geopolitical Risk Score 
#•	Port Congestion 
#•	Shipping Delay 
with route_risk as (
    select
        route_id,
        avg(geopolitical_risk_score) as avg_geo_risk,
        avg(port_congestion_index) as avg_port_congestion,
        avg(shipping_delay_days) as avg_shipping_delay
    from weekly_route_operations
    group by route_id
),

risk_score as (
    select
        route_id,
        avg_geo_risk,
        avg_port_congestion,
        avg_shipping_delay,
        (
            avg_geo_risk * 0.40 +
			avg_port_congestion * 0.30 +
            (
                avg_shipping_delay /
                nullif(
                    (select max(avg_shipping_delay)
                     from route_risk), 0
                )
            ) * 100 * 0.30
        ) as high_risk_score
    from route_risk
)
select
    route_id,
    round(avg_geo_risk, 2) as geopolitical_risk_score,
    round(avg_port_congestion, 2) as port_congestion_index,
    round(avg_shipping_delay, 2) as shipping_delay_days,
    round(high_risk_score, 2) as high_risk_score
from risk_score
order by high_risk_score desc
limit 10;

# 29. Rank countries by overall supply chain resilience using:
#•	Logistics Performance Index 
#•	Port Capacity Index 
#•	Trade Dependency Score 
with normalized as (
    select
        country,
        (logistics_performance_index - min(logistics_performance_index) over ())
        /nullif(
            max(logistics_performance_index) over () -
            min(logistics_performance_index) over (), 0
        ) * 100 as lpi_score,
        (port_capacity_index - min(port_capacity_index) over ())
        /nullif(
            max(port_capacity_index) over () -
            min(port_capacity_index) over (), 0
        ) * 100 as port_score,
        (1 - (trade_dependency_score - min(trade_dependency_score) over ())
		/nullif(
                max(trade_dependency_score) over () -
                min(trade_dependency_score) over (), 0
            )
        ) * 100 as dependency_score
	from country_metadata
)
select
    country,
    round(lpi_score, 2) as lpi_score,
    round(port_score, 2) as port_score,
    round(dependency_score, 2) as dependency_score,
    round(
        (lpi_score * 0.40) +
        (port_score * 0.30) +
        (dependency_score * 0.30),
        2
    ) as resilience_score
from normalized
order by resilience_score desc;


# 30. Which routes are the most profitable if freight cost is treated as revenue?
select
    tr.route_id,
    tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type,
    ROUND(SUM(wro.freight_cost_usd), 2) as total_revenue
from trade_routes tr
join weekly_route_operations wro
    on tr.route_id = wro.route_id
group by
    tr.route_id,
    tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type
order by total_revenue desc;

# 31. Find routes where commodity stress exceeded the yearly average while trade volume declined
with yearly_stress as (
    select
        year(date) as year,
        avg(commodity_stress_index) as yearly_avg_stress_index
    from commodity_market
    group by year(date)
),
route_volume as (
    select 
        date,
        route_id,
        trade_volume_tonnes,
        lag(trade_volume_tonnes) over(
            partition by route_id 
            order by date
        ) as previous_trade_volume
    from weekly_route_operations
),
affected_routes as (
    select
        rv.date,
        tr.route_id,
        tr.origin_country,
        tr.destination_country,
        tr.shipping_method,
        tr.trade_route_type,
        cm.commodity_stress_index,
        ys.yearly_avg_stress_index,
        rv.trade_volume_tonnes,
        rv.previous_trade_volume
    from trade_routes tr
    join route_volume rv
        on tr.route_id = rv.route_id
    join yearly_stress ys
        on year(rv.date) = ys.year
    join commodity_market cm
        on rv.date = cm.date
    where cm.commodity_stress_index > ys.yearly_avg_stress_index
    and rv.trade_volume_tonnes < rv.previous_trade_volume
)
select
    route_id,
    origin_country,
    destination_country,
    shipping_method,
    trade_route_type,
	count(*) as occurrence_count,
	round(
        avg(commodity_stress_index - yearly_avg_stress_index),
        2
    ) as avg_stress_above_yearly_avg,
	round(
        avg(
            (trade_volume_tonnes - previous_trade_volume)
            / nullif(previous_trade_volume, 0) * 100
        ),2) as avg_volume_change_pct
from affected_routes
group by
    route_id,
    origin_country,
    destination_country,
    shipping_method,
    trade_route_type
order by occurrence_count desc limit 10;

# 32. Calculate the moving average of freight cost over the previous 4 weeks.
select
	date,
    route_id,
    freight_cost_usd,
    round(avg(freight_cost_usd) over(
    partition by route_id
    order by date 
    rows between 3 preceding and current row),2) as moving_avg_four_weeks
from weekly_route_operations
order by route_id, date;

# 33. Calculate cumulative trade volume for every route.
select
	date,
    route_id,
    freight_cost_usd,
    sum(trade_volume_tonnes) over(
    partition by route_id
    order by date 
    rows between unbounded preceding and current row) as cumulative_trade_volume
from weekly_route_operations
order by route_id,date;

# 34. Find the longest uninterrupted period where a route remained operational
with operational_routes as (
select
	route_id, date, route_status,
    row_number() over(partition by route_id order by date) as rn
from weekly_route_operations
where route_status in ( "Normal", "Delayed")),
route_groups as (
select
	route_id, date, route_status,
    date_sub(date,interval rn week) as grp
from operational_routes),
continuous_periods AS (
select
	route_id,
	min(date) as start_date,
	max(date) as end_date,
	count(*) as operational_weeks
    from route_groups
    group by route_id, grp)
select
    route_id, start_date, end_date, operational_weeks,
    operational_weeks * 7 as operational_days
from continuous_periods
order by operational_weeks desc limit 1;

# 35. Identify routes with the highest operational volatility.
# Use standard deviation of
# •	Freight Cost 
# •	Delay 
# •	Trade Volume 

select 
	route_id,
    round(stddev_pop(freight_cost_usd),2) as freight_cost_volatility,
    round(stddev_pop(shipping_delay_days),2) as delay_volatility,
    round(stddev_pop(trade_volume_tonnes),2) as trade_volume_volatility
from weekly_route_operations
group by route_id
order by
	freight_cost_volatility desc,
    delay_volatility desc,
    trade_volume_volatility desc;
    
# 36. Find the top five countries most exposed to geopolitical risk.
# Combine
# •	Region 
# •	Trade Dependency 
# •	Event Severity 
select
	cm.country,
    cm.region,
    round(cm.trade_dependency_score,2) as trade_dependency_score,
    round(avg(ge.severity),2) as avg_event_severity,
    round(cm.trade_dependency_score * avg(ge.severity),2) as geopolitical_exposure_score
from country_metadata cm
join geopolitical_events ge
on (
	cm.region in ("East Asia & Pacific", "South Asia")
    and ge.affected_region = "Asia")
    or(cm.region = "North America"
		and ge.affected_region = "North America")
	or(cm.region = "Europe & Central Asia"
		and ge.affected_region = "Europe")
	or(cm.region = "Latin America & Caribbean"
		and ge.affected_region = "South America")
group by
	cm.country,
    cm.region,
    cm.trade_dependency_score
order by geopolitical_exposure_score desc limit 5;

# 37. Build a Supply Chain Risk Score, Rank all routes.
with route_matrics as (select
	wro.route_id,
	avg(wro.geopolitical_risk_score) as avg_geopolitical_risk,
    avg(wro.port_congestion_index) as avg_port_congestion,
    avg(wro.shipping_delay_days) as avg_shipping_delay,
    avg(cm.commodity_stress_index) as avg_commodity_stress
from weekly_route_operations wro
join commodity_market cm
on wro.date = cm.date
group by wro.route_id),
min_max as (
select
	*,
    min(avg_geopolitical_risk)over() as min_geo,
    max(avg_geopolitical_risk)over() as max_geo,
    min(avg_port_congestion)over() as min_congestion,
    max(avg_port_congestion)over() as max_congestion,
    min(avg_shipping_delay)over() as min_delay,
    max(avg_shipping_delay)over() as max_delay,
    min(avg_commodity_stress)over() as min_stress,
    max(avg_commodity_stress)over() as max_stress
from route_matrics),
risk_score as(select
	route_id,
	round(
	((avg_geopolitical_risk - min_geo)/nullif(max_geo-min_geo,0))*100*0.35
    +((avg_port_congestion - min_congestion)/nullif(max_congestion-min_congestion,0))*100*0.25
    +((avg_shipping_delay - min_delay)/nullif(max_delay-min_delay,0))*100*0.20
    +coalesce(((avg_commodity_stress - min_stress)/nullif(max_stress-min_stress,0))*100,0)*0.20
    ,2) as supply_chain_risk_score
from min_max)
select
    rs.route_id,
    tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type,
    rs.supply_chain_risk_score,
    dense_rank() over (
        order by rs.supply_chain_risk_score desc
    ) AS risk_rank
from risk_score rs
join trade_routes tr
    on rs.route_id = tr.route_id
order by risk_rank;

# 38. Find the most resilient trade routes.
with route_matrics as (
select
	route_id,
	avg(shipping_delay_days) as avg_delay,
    avg(port_congestion_index) as avg_congestion,
    avg(geopolitical_risk_score) as avg_geo_risk,
    avg(trade_volume_tonnes) as avg_trade_volume
from weekly_route_operations
group by route_id),
min_max as (
select
	*,
    min(avg_delay)over() as min_delay,
    max(avg_delay)over() as max_delay,
    min(avg_congestion)over() as min_congestion,
    max(avg_congestion)over() as max_congestion,
    min(avg_geo_risk)over() as min_geo,
    max(avg_geo_risk)over() as max_geo,
    min(avg_trade_volume)over() as min_volume,
    max(avg_trade_volume)over() as max_volume
from route_matrics),
resilience_score as(
select
	route_id,
    round(
    ((max_delay - avg_delay)/nullif(max_delay-min_delay,0))*100*0.30
    +((max_congestion-avg_congestion)/nullif(max_congestion-min_congestion,0))*100*0.25
    +((max_geo-avg_geo_risk)/nullif(max_geo-min_geo,0))*100*0.25
    +((avg_trade_volume-min_volume)/nullif(max_volume-min_volume,0))*100*0.20
    ,2)as resilience_score
from min_max)
select
    rs.route_id,
    tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type,
    rs.resilience_score,
	dense_rank() over (
        order by rs.resilience_score desc
    ) as resilience_rank
from resilience_score rs
join trade_routes tr
    on rs.route_id = tr.route_id
order by resilience_rank;

# 39. Calculate Year-over-Year growth for:
# •	Trade Volume 
# •	Freight Cost 
# •	Carbon Emissions 
with yearly_data as(
select
	year(date) as Year,
    sum(trade_volume_tonnes) as total_trade_volume,
    sum(freight_cost_usd) as total_freight_cost,
    sum(carbon_emissions_tonnes) as total_carbon_emissions
from weekly_route_operations
group by year(date)),
yoy_data as (
select
	*,
    lag(total_trade_volume)over(order by Year) as previous_trade_volume,
    lag(total_freight_cost)over(order by Year) as previous_freight_cost,
    lag(total_carbon_emissions)over(order by Year) as previous_carbon_emissions
from yearly_data)
select
	Year,
    round((total_trade_volume - previous_trade_volume)
    /nullif(previous_trade_volume,0)*100,2) as trade_volume_yoy,
	round((total_freight_cost - previous_freight_cost)
    /nullif(previous_freight_cost,0)*100,2) as freight_cost_yoy,
    round((total_carbon_emissions - previous_carbon_emissions)
    /nullif(previous_carbon_emissions,0)*100,2) as carbon_emissions_yoy
from yoy_data
order by Year ;

# Create a Supply Chain Health Index combining:
# •	Trade Volume 
# •	Delay 
# •	Freight Cost 
# •	Commodity Stress 
# •	Port Congestion 
# Classify:
# •	Healthy 
# •	Stable 
# •	At Risk 
# •	Critical
 
with route_matrics as 
(select
	wro.route_id,
    avg(wro.trade_volume_tonnes) as avg_trade_volume,
    avg(wro.shipping_delay_days) as avg_delay,
    avg(wro.freight_cost_usd) as avg_freight_cost,
    avg(cm.commodity_stress_index) as avg_commodity_stress,
    avg(wro.port_congestion_index) as avg_congestion
from weekly_route_operations wro
join commodity_market cm
on wro.date = cm.date
group by wro.route_id),
min_max as (
select
	*,
    min(avg_trade_volume)over() as min_volume,
    max(avg_trade_volume)over() as max_volume,
    min(avg_delay)over() as min_delay,
    max(avg_delay)over() as max_delay,
    min(avg_freight_cost)over() as min_freight,
    max(avg_freight_cost)over() as max_freight,
    min(avg_commodity_stress)over() as min_stress,
    max(avg_commodity_stress)over() as max_stress,
    min(avg_congestion)over() as min_congestion,
    max(avg_congestion)over() as max_congestion
from route_matrics),
health_score as (
select
	route_id,
    round(
    ((avg_trade_volume-min_volume)/nullif(max_volume-min_volume,0))*100*0.25
    +((max_delay-avg_delay)/nullif(max_delay-min_delay,0))*100*0.20
    +((max_freight-avg_freight_cost)/nullif(max_freight-min_freight,0))*100*0.20
    +coalesce(((max_stress-avg_commodity_stress)/nullif(max_stress-max_stress,0))*100,0)*0.15
    +(( max_congestion-avg_congestion)/nullif( max_congestion-min_congestion,0))*100*0.20
    ,3) as health_index
from min_max )
select
    hs.route_id,
    tr.origin_country,
    tr.destination_country,
    tr.shipping_method,
    tr.trade_route_type,
    hs.health_index,
	case
        when hs.health_index >= 75 then 'Healthy'
        when hs.health_index >= 50 then 'Stable'
        when hs.health_index >= 25 then 'At Risk'
        else 'Critical'
    end as health_status
from health_score hs
join trade_routes tr
    on hs.route_id = tr.route_id
order by hs.health_index desc;








   
    
    
    
    