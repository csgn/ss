-- Number Of Units Per Nationality ( 10156 ) ( Medium )
-- https://platform.stratascratch.com/coding/10156-number-of-units-per-nationality?code_type=1
-- FIRST APPROACH
with
  cte as (
    select distinct
      *
    from
      airbnb_hosts ah
      join airbnb_units au on ah.nationality = au.country
      and ah.host_id = au.host_id
    where
      au.unit_type = 'Apartment'
      and ah.age < 30
  )
select
  nationality,
  count(*) as apartment_count
from
  cte
group by
  1;

-- SECOND APPROACH
select
  nationality,
  count(distinct unit_id) as apartment_count
from
  airbnb_hosts ah
  join airbnb_units au on ah.host_id = au.host_id
where
  au.unit_type = 'Apartment'
  and ah.age < 30
group by
  1
order by
  2 desc;

-- THIRD APPROACH
with
  cte_apartments_filtered as (
    select
      host_id,
      country,
      unit_id
    from
      airbnb_units
    where
      unit_type = 'Apartment'
  ),
  cte_age_under_30_filtered as (
    select
      host_id,
      nationality
    from
      airbnb_hosts
    where
      age < 30
  )
select
  c1.nationality,
  count(distinct c2.unit_id) as apartment_count
from
  cte_age_under_30_filtered c1
  join cte_apartments_filtered c2 on c1.host_id = c2.host_id
group by
  1
order by
  2 desc
