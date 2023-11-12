-- Creating manufacturers table
CREATE TABLE public.manufacturers (
    manufacturer_id SERIAL PRIMARY KEY,
    manufacturer_name VARCHAR(100) NOT NULL,
    manufacturer_legal_entity VARCHAR(100) NOT NULL --юрлицо
);

-- Creating categories table
CREATE TABLE public.categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Creating products table
CREATE TABLE public.products (
    product_id BIGINT  PRIMARY KEY,
    category_id INTEGER,
    manufacturer_id INTEGER,
    product_name VARCHAR(255) NOT NULL,
    product_picture_url VARCHAR(255) NOT NULL, --ссылка на изображение продукта
    product_description VARCHAR(255) NOT NULL, --описание продукта
    product_age_restriction INTEGER NOT NULL ,--видимо, максимальный срок годности
    FOREIGN KEY (category_id) REFERENCES public.categories(category_id),
    FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturers(manufacturer_id)
);

-- Creating stores table
CREATE TABLE public.stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    store_country VARCHAR(255) NOT NULL, --страна магазина
    store_city VARCHAR(255) NOT NULL, --город магазина
    store_address VARCHAR(255) NOT NULL --адрес магазина
);

-- Creating deliveries table
CREATE TABLE public.deliveries (
    delivery_id BIGINT PRIMARY KEY, -- новая айдишка
    store_id INTEGER,
    product_id INTEGER,
    delivery_date DATE NOT NULL,
    product_count INTEGER  NOT NULL,
    FOREIGN KEY (store_id) REFERENCES public.stores(store_id),
    FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

-- Creating customers table
CREATE TABLE public.customers (
    customer_id SERIAL PRIMARY KEY,
    customer_fname VARCHAR(100) NOT NULL,
    customer_lname VARCHAR(100) NOT NULL,
    customer_gender VARCHAR(100) NOT NULL, --пол покупателя (почему NOT NULL, мы же вполне можем не знать этой инфы)
    customer_phone VARCHAR(100) NOT NULL --телефон покупателя (почему NOT NULL, мы же вполне можем не знать этой инфы)
);

-- Creating purchases table
CREATE TABLE public.purchases (
    purchase_id SERIAL PRIMARY KEY,
    store_id INTEGER,
    customer_id INTEGER,
    purchase_date TIMESTAMP NOT NULL ,
    purchase_payment_type VARCHAR(100) NOT NULL, --тип платежа
    FOREIGN KEY (store_id) REFERENCES public.stores(store_id),
    FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id)
);

-- Creating purchase_items table
CREATE TABLE public.purchase_items (
    product_id INTEGER,
    purchase_id INTEGER,
    product_count BIGINT  NOT NULL,
    product_price NUMERIC(9,2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES public.products(product_id),
    FOREIGN KEY (purchase_id) REFERENCES public.purchases(purchase_id)
);

-- Creating price_change table
CREATE TABLE public.price_change (
    product_id INTEGER,
    price_change_ts TIMESTAMP NOT NULL,
    new_price NUMERIC(9,2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES public.products(product_id)
);

CREATE VIEW public.gmv_view AS
(
    SELECT p.store_id, pr.category_id, SUM(pur_it.product_price * pur_it.product_count) AS GMV
    FROM public.purchase_items pur_it
    INNER JOIN public.purchases p ON pur_it.purchase_id = p.purchase_id
    INNER JOIN public.products pr on pr.product_id = pur_it.product_id
    GROUP BY store_id, category_id
);
