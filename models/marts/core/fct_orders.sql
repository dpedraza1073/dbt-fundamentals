with payments as 
(
    select 
        *   
    from {{ref('stg_payments')}}
),

customer as 
(

    select 
       *
    from {{ref('stg_customers')}}
),

orders as 
(
    select 
       *
    from {{ref('stg_orders')}}
),

order_payments as 

(

select 
    order_id,
    sum(case when status ='success' then amount end) as amount
from payments
group by 1

),

final as 
(
select 
    orders.Order_Id,
    orders.Customer_Id,
    orders.order_date,
    coalesce(order_payments.amount,0) as amount
from orders
left join order_payments using (order_Id)
)

select *
from final 