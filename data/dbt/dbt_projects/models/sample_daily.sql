{{
    config(
        materialized='view'
    )
}}

select
	opstime::date as opsdate
	,sum(value)
from
	sample_base
group by
	opsdate