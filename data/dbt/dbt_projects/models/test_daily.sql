{{ config(materialized='table') }}
select
  id
  ,opstime::date as opsdate
  ,sum(value) as value
from
	test_add
group by
	id, opsdate