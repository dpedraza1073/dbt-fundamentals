WITH payments AS 
(
select payment.id as paymentId,
       payment.orderid as order_id,
       payment.paymentmethod as payment_method,
       payment.status,
       payment.amount/100 as amount,
       payment.created as created_at
       
from {{ source('stripe','payment')}}
)

select *
from payments