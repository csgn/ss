-- Premium vs Freemium ( 10300 ) ( Hard )
--- https://platform.stratascratch.com/coding/10300-premium-vs-freemium?code_type=1
-- FIRST APROACH
with
  cte as (
    select
      c1.user_id,
      c2.paying_customer
    from
      ms_user_dimension c1
      join ms_acc_dimension c2 on c1.acc_id = c2.acc_id
  ),
  cte2 as (
    select
      c1.user_id,
      c1.downloads,
      c1.date,
      c2.paying_customer
    from
      ms_download_facts c1
      join cte c2 on c1.user_id = c2.user_id
    order by
      date
  ),
  res as (
    select
      date,
      sum(
        case
          when paying_customer = 'no' then downloads
          else 0
        end
      ) as non_paying,
      sum(
        case
          when paying_customer = 'yes' then downloads
          else 0
        end
      ) as paying
    from
      cte2
    group by
      date
    order by
      date
  )
select
  *
from
  res
where
  non_paying > paying
  /*
  date	non_paying	paying
  2020-08-16 00:00:00	15	14
  2020-08-17 00:00:00	45	9
  2020-08-18 00:00:00	10	7
  2020-08-21 00:00:00	32	17
   */
