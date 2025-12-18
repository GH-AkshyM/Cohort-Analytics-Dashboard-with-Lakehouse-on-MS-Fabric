
--ALTER VIEW dbo.Usersview
--AS

WITH CTEcount as
   (
   select
   user_id
   ,order_status
   ,COUNT(order_id) as 'Order Count'
   from [dbo].[Orderdetails]
   where order_status = 'completed'
   group by user_id, order_status
    )
,CTEcohort as
    (
    select user_id,
    CAST(min(order_date) as date) as firstpurchase,
    (Year(CAST(min(order_date) as date))*100)+month(CAST(min(order_date) as date)) as 'Monthkey'
    from [dbo].[Orderdetails]
    group by user_id)

select u.[user_id] as 'User ID'
      ,u.[gender] as 'Gender'
      ,u.[city] as 'City'
      ,u.[signup_date] as 'Sign-up Date'
      ,case 
        when c.[Order Count] > 1 then 'Repeat customer'
        when c.[Order Count] = 1 then 'One time customer'
        else 'No Purchase' end as 'Customer type'
      ,Format(co.[firstpurchase],'MMM yyyy') as 'Cohort'
      ,[Monthkey]
      
from [dbo].[Users] as u
    left join CTEcount as c
    on c.user_id = u.user_id

    left join CTEcohort as co
    on co.user_id = u.user_id
