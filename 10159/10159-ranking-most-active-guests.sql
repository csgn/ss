-- Ranking Most Active Guests ( 10159 ) ( Medium )
-- https://platform.stratascratch.com/coding/10159-ranking-most-active-guests?tabname=question

-- Resources
-- https://dataschool.com/how-to-teach-people-sql/how-window-functions-work/
-- https://www.postgresqltutorial.com/postgresql-window-function/postgresql-dense_rank-function/

/* FIRST APPROACH */

with 
	cte as (
		select
			  id_guest
			, sum(n_messages) as sum_n_messages
		from 
			airbnb_contacts
		group by 
			id_guest
		order by 
			sum_n_messages desc
)

select 
	  id_guest
	, sum_n_messages
	, dense_rank() over (
		order by 
			sum_n_messages desc
	  ) as ranking
from cte;


/* SECOND APPROACH */
select
	  id_guest
	, dense_rank() over (
		order by sum(n_messages) desc
	  ) as ranking
	, sum(n_messages) as sum_n_messages
from 
	airbnb_contacts
group by 
	id_guest
order by 
	sum_n_messages desc;

/* OUTPUT
ranking  id_guest                               sum_n_messages
-------- -------------------------------------  --------------
1			882f3764-05cc-436a-b23b-93fea22ea847	20
1			62d09c95-c3d2-44e6-9081-a3485618227d	20
2			b8831610-31f2-4c58-8ada-63b3601ca476	17
2			91c2a883-04e3-4bbb-a7bb-620531318ab1	17
3			6133fb99-2391-4d4b-a077-bae40581f925	16
...
*/
