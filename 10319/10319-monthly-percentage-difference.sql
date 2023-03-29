-- Monthly Percentage Difference ( 10319 ) ( Hard )
--- https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?code_type=1
-- Resources
--- https://www.postgresqltutorial.com/postgresql-window-function/postgresql-lag-function/
with
  ordered as (
    select
      to_char (created_at, 'YYYY-MM') as year_month,
      sum(value) as value
    from
      sf_transactions
    group by
      1
    order by
      1
  ),
  ordered_and_lagged_transactions as (
    select
      year_month,
      value,
      lag (value, 1) over (
        order by
          1
      ) as last_month_value
    from
      ordered
  )
select
  year_month,
  round(
    ((value - last_month_value) / last_month_value) * 100,
    2
  ) as revenue_diff_pct
from
  ordered_and_lagged_transactions;

/*
year_month	revenue_diff_pct
2019-01	
2019-02	-28.56
2019-03	23.35
2019-04	-13.84
 */
