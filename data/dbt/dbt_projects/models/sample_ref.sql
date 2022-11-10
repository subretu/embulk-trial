{{
    config(
        materialized='view'
    )
}}

with daily as(
	select
		*
	from
		{{ ref('sample_daily') }}
)
select
	*
from
	daily