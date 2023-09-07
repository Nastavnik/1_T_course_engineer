WITH plan_work as(
     select 
      extract(month FROM pl.plan_date) AS month
     ,pl.shop_name AS shop_name   
     ,pr.product_name AS product_name
     ,(CASE
        WHEN pl.shop_name= 'dns'                                       
        THEN (SELECT cast(count(dns.sales_cnt) as float) FROM public.shop_dns dns join public.plan pl on dns.product_id = pl.product_id)
        WHEN pl.shop_name= 'mvideo'                                      
        THEN (SELECT cast(count(mv.sales_cnt) as float) FROM public.shop_mvideo mv join public.plan pl on mv.product_id = pl.product_id)
        WHEN pl.shop_name= 'sitilink'                                   
        THEN (SELECT cast(count(sit.sales_cnt) as float) FROM public.shop_sitilink sit join public.plan pl on sit.product_id = pl.product_id)          
     end) AS sales_fact                

     ,(CASE
      WHEN pl.product_id = 1
        THEN (SELECT cast(SUM(pl.plan_cnt) as numeric) FROM public.plan pl WHERE pl.product_id = 1)
        WHEN pl.product_id = 2
        THEN (SELECT cast(SUM(pl.plan_cnt) as numeric) FROM public.plan pl WHERE pl.product_id = 2)
        WHEN pl.product_id = 3
        THEN (SELECT cast(SUM(pl.plan_cnt) as numeric)  FROM public.plan pl WHERE pl.product_id = 3)
     end) AS sales_plan
     ,pr.price as price    
     
    FROM public.product pr 
    JOIN public.shop_sitilink sit ON sit.product_id = pr.product_id
    JOIN public.shop_mvideo mv ON mv.product_id = pr.product_id
    JOIN public.shop_dns dns ON dns.product_id = pr.product_id
    JOIN public.plan pl ON pl.product_id = pr.product_id
    ORDER BY pl.shop_name
      ) 
      select
       price,--
       month
      ,pw.shop_name
      ,pw.product_name
      ,pw.sales_fact
      ,pw.sales_plan
      ,round(cast((pw.sales_fact / pw.sales_plan) AS numeric), 2)  AS sales_fact_plan
      ,(pw.price * pw.sales_fact) AS income_fact           
      ,(pw.price * pw.sales_plan) AS income_plan           
      ,cast(((pw.price * pw.sales_fact) - (pw.price * pw.sales_plan)) as numeric )  AS income_fact_plan
      
      from plan_work pw order by month, pw.shop_name;