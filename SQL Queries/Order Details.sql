SELECT 
[order_id] as 'Order ID'
      ,[user_id] as 'User ID'
      ,CAST(order_date as date) as 'Order Date'
      ,Upper(left([order_status],1)) + lower(substring([order_status],2,30)) as 'Order Status'
      ,datediff(month,min(order_date) over(partition by user_id),order_date) as 'Index' 
      ,[total_amount] as 'Total Amount'
FROM [dbo].[Orderdetails]