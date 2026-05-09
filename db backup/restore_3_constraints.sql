-- 3. Constraints and Triggers Restore Script
-- Adds Primary Keys, Unique Constraints, Foreign Keys, and Triggers

-- Primary Keys and Unique Constraints
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);

ALTER TABLE ONLY public.deal_images
    ADD CONSTRAINT deal_images_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (deal_id);

ALTER TABLE ONLY public.factories
    ADD CONSTRAINT factories_pkey PRIMARY KEY (factory_id);

ALTER TABLE ONLY public.order_track
    ADD CONSTRAINT order_track_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_name_key UNIQUE (product_name);

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transactions_id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id, email);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_id_key UNIQUE (user_id);

-- Foreign Keys
ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);

ALTER TABLE ONLY public.deal_images
    ADD CONSTRAINT deal_images_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id);

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);

ALTER TABLE ONLY public.order_track
    ADD CONSTRAINT order_track_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id);

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payments(payment_id);

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);

ALTER TABLE ONLY public.product_images
    ADD CONSTRAINT product_images_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_factory_id_fkey FOREIGN KEY (factory_id) REFERENCES public.factories(factory_id);

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);

-- Triggers
CREATE TRIGGER trigger_complete_deal AFTER UPDATE OF number_of_order ON public.deals FOR EACH ROW WHEN (((new.number_of_order = new.quantity) AND (new.deal_status = 'active'::public.deal_status))) EXECUTE FUNCTION public.complete_deal();
