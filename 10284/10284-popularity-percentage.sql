-- Popularity Percentage ( 10284 ) ( HARD )
-- https://platform.stratascratch.com/coding/10284-popularity-percentage?code_type=1
-- FIRST APPROACH
with
  cte1 as (
    select
      user1 as uid,
      count(*)
    from
      facebook_friends
    group by
      user1
  ),
  cte2 as (
    select
      user2 as uid,
      count(*)
    from
      facebook_friends
    group by
      user2
  ),
  cte3 as (
    select
      *
    from
      cte1
    union
    select
      *
    from
      cte2
  ),
  cte4 as (
    select
      uid,
      sum(count) as total_friends
    from
      cte3
    group by
      uid
  )
select
  uid,
  total_friends / (
    select
      count(*)
    from
      cte4
  ) * 100 as popularity_percent
from
  cte4
order by
  uid;

/*
uid	popularity_percent
1	55.556
2	33.333
3	33.333
4	11.111
5	11.111
6	22.222
7	11.111
 */
