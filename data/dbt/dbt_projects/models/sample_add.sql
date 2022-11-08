{{
    config(
        materialized='incremental'
    )
}}

select
  id
  ,opstime
  ,value
from
  sample_base

{% if is_incremental() %}

  --idが存在しない場合のみinsert
  where "id" not in (select "id" from {{ this }})

{% endif %}