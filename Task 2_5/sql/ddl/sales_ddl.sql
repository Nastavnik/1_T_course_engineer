

--                                      Plan

CREATE TABLE  IF NOT EXISTS  public.plan (
 product_id INTEGER -- id продукта
,shop_name VARCHAR(30) --название магазина
,plan_cnt  INTEGER--планируемое кол-во продаж
,plan_date date --конец месяца
,PRIMARY KEY (shop_name,plan_cnt, plan_date) --составной ключ
,FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE SET NULL);

--                                     shop_dns

CREATE TABLE  IF NOT EXISTS  public.shop_dns(
date date
,product_id INTEGER
,sales_cnt INTEGER
,PRIMARY KEY (date, product_id)
,FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE SET NULL
);

--                                  shop_mvideo

CREATE TABLE   IF NOT EXISTS public.shop_mvideo(
date date                                       --12 mon 
,product_id INTEGER
,sales_cnt INTEGER                                   --количество продаж на конец месяца
,PRIMARY KEY (date, product_id)
,FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE SET NULL
);

--                                  shop_sitilink

CREATE TABLE   IF NOT EXISTS public.shop_sitilink(
 date date
,product_id INTEGER
,sales_cnt INTEGER
,PRIMARY KEY (date, product_id)
,FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE SET NULL
);

-- !                                  product

CREATE TABLE    IF NOT EXISTS public.product(
product_id INTEGER PRIMARY KEY
,product_name VARCHAR(50)
,price INTEGER
);
