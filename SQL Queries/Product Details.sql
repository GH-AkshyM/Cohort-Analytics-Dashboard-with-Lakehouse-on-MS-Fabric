SELECT [product_id] as 'Product ID'
      ,[product_name] as 'Product Name'
      ,[category] as 'Category'
      ,[brand] as 'Brand'
      ,[price] as 'Price'
      ,[rating] as 'Rating'
      , CASE
        when price > 1000 then 'Luxury'
        when price > 500 then 'Premium'
        when price > 250 then 'Upper Mid-Range'
        when price > 100 then 'Mid-Range'
        when price > 50 then 'Value'
        when price > 25 then 'Budget'
        else 'Ultra-Budget' 
        end as 'Price Category'
        ,Case
        when rating > 4.5 then 'Top Rated'
        when rating > 4 then 'Good'
        when rating > 3.5 then 'Average'
        when rating > 3 then 'Below Average'
        else 'Poor'
        end as 'Rating Category'


  FROM [dbo].[Productdetails]