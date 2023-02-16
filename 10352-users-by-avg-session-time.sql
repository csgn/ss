-- Users By Average Session Time ( 10352 ) ( Medium )
-- https://platform.stratascratch.com/coding/10352-users-by-avg-session-time?tabname=question 

/* FIRST APPROACH */

with 
cte as (
    select 
        *
    from facebook_web_log
    where action in ('page_load', 'page_exit')
    order by user_id, timestamp
), 
cte2 as (
    select 
        c1.user_id,
        c1.timestamp::date,
        min(c2.timestamp) - max(c1.timestamp) as st
    from cte c1
    join cte c2
        on c1.user_id = c2.user_id
    where c1.action = 'page_load'
      and c2.action = 'page_exit'
      and c2.timestamp > c1.timestamp
    group by 1, 2
)

select 
    user_id,
    avg(st)
from cte2
group by 1

/* OUTPUT
user_id	avg
-------  -------
0	      1883.5
1	      35
*/
