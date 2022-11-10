{{
    config(
        materialized='view'
    )
}}

{% set payment_methods = ["card", "cash", "qrcord"] %}

select
  id
  ,sum(amount) as total_amount
  {% for payment_method in payment_methods %}
  ,coalesce(sum(case when payment_method = '{{payment_method}}' then amount end), 0) as {{payment_method}}_amount
  {% endfor %}
from
  {{ source('develop', 'sample_jinja') }}
group by
  id