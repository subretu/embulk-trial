{{ config(materialized='table') }}
select
  id
  ,opstime::date as opsdate
  ,sum(value) as value
from
	test
group by
	id, opsdate