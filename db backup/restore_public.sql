CREATE TYPE public.deal_status AS ENUM (
    'private',
    'closed',
    'active',
    'completed',
    'pending'
);
CREATE TYPE public.order_status AS ENUM (
    'pending',
    'processing',
    'inChina',
    'inTransit',
    'inSaudi',
    'withShipmentCompany',
    'completed',
    'canceled'
);
CREATE TYPE public.payment_status AS ENUM (
    'paid',
    'failed',
    'refund'
);
CREATE TYPE public.user_role AS ENUM (
    'admin',
    'user'
);
CREATE TYPE public.user_status AS ENUM (
    'active',
    'blocked'
);
CREATE FUNCTION public.complete_deal() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.deal_status IS DISTINCT FROM 'completed' THEN
    UPDATE deals 
    SET deal_status = 'completed' 
    WHERE number_of_order = deals.quantity AND deals.deal_status ='active';
  END IF;
  RETURN NULL;
END;
$$;
CREATE TABLE public.address (
    user_id uuid NOT NULL,
    city text DEFAULT ''::text NOT NULL,
    zip_code text DEFAULT ''::text NOT NULL,
    street_name text DEFAULT ''::text NOT NULL,
    building_number text DEFAULT ''::text NOT NULL,
    address_id bigint NOT NULL
);
CREATE TABLE public.categories (
    category_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    category_id bigint NOT NULL
);
CREATE TABLE public.deal_images (
    id bigint NOT NULL,
    deal_id bigint NOT NULL,
    image_url text NOT NULL,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL
);
CREATE TABLE public.deals (
    deal_title text DEFAULT ''::text NOT NULL,
    deal_description text DEFAULT ''::text NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    cost_price real NOT NULL,
    delivery_price real NOT NULL,
    sale_price real NOT NULL,
    total_price real NOT NULL,
    deal_status public.deal_status NOT NULL,
    max_orders_per_user bigint NOT NULL,
    quantity bigint NOT NULL,
    deal_url text DEFAULT ''::text,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    created_by uuid,
    updated_by uuid,
    updated_at time with time zone,
    deal_id bigint NOT NULL,
    number_of_order integer DEFAULT 0 NOT NULL,
    product_id bigint NOT NULL,
    category_id bigint NOT NULL,
    estimate_delivery_date_from text DEFAULT '10'::text NOT NULL,
    estimate_delivery_time_to text DEFAULT '15'::text NOT NULL,
    tracking_number text DEFAULT ''::text NOT NULL
);
CREATE TABLE public.factories (
    factory_name text DEFAULT ''::text NOT NULL,
    region text DEFAULT ''::text,
    department text DEFAULT ''::text NOT NULL,
    factory_representative text DEFAULT ''::text NOT NULL,
    contact_phone text DEFAULT ''::text NOT NULL,
    is_black_list boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated_at timestamp with time zone,
    created_by uuid,
    updated_by uuid,
    factory_id bigint NOT NULL
);
CREATE TABLE public.order_track (
    id bigint NOT NULL,
    order_id integer,
    status public.order_status,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.orders (
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id uuid NOT NULL,
    order_date timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    order_status public.order_status DEFAULT 'pending'::public.order_status NOT NULL,
    tracking_number text DEFAULT ''::text,
    tracking_company text DEFAULT ''::text,
    amount double precision NOT NULL,
    deal_id bigint NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    order_id bigint NOT NULL,
    address text,
    payment_id bigint,
    payment_status public.payment_status DEFAULT 'paid'::public.payment_status NOT NULL
);
CREATE TABLE public.payments (
    payment_status public.payment_status NOT NULL,
    transaction_id text NOT NULL,
    payment_amount real NOT NULL,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    payment_id bigint NOT NULL,
    user_id uuid DEFAULT gen_random_uuid()
);
CREATE TABLE public.product_images (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    image_url text NOT NULL
);
CREATE TABLE public.products (
    product_name text DEFAULT ''::text NOT NULL,
    product_description text DEFAULT ''::text NOT NULL,
    default_price real,
    length real NOT NULL,
    width real NOT NULL,
    height real NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone,
    created_by uuid,
    updated_by uuid,
    product_id bigint NOT NULL,
    factory_id bigint NOT NULL,
    model_number text DEFAULT ''::text NOT NULL,
    weight integer DEFAULT 0 NOT NULL
);
CREATE TABLE public.transactions (
    transactions_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid DEFAULT gen_random_uuid() NOT NULL,
    transactions_amount real NOT NULL,
    transaction_type text DEFAULT ''::text NOT NULL,
    image_id uuid NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text) NOT NULL,
    updated_by uuid
);
CREATE TABLE public.users (
    user_id uuid NOT NULL,
    full_name text NOT NULL,
    email text NOT NULL,
    phone text NOT NULL,
    profile_url text DEFAULT ''::text,
    balance numeric DEFAULT 0.0,
    user_status public.user_status DEFAULT 'active'::public.user_status NOT NULL,
    role public.user_role DEFAULT 'user'::public.user_role NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone
);
INSERT INTO public.address (user_id, city, zip_code, street_name, building_number, address_id) VALUES ('83efec21-2fc7-416e-9825-a86a8af3a63a', 'الدمام', '', '', '', 3);
INSERT INTO public.address (user_id, city, zip_code, street_name, building_number, address_id) VALUES ('83efec21-2fc7-416e-9825-a86a8af3a63a', 'الرياض', '', '', '', 1);
INSERT INTO public.address (user_id, city, zip_code, street_name, building_number, address_id) VALUES ('83efec21-2fc7-416e-9825-a86a8af3a63a', 'الأحساء', '', '', '', 2);
INSERT INTO public.categories (category_name, created_at, category_id) VALUES ('إلكترونيات', '2024-10-27 09:23:23.207557+00', 1);
INSERT INTO public.categories (category_name, created_at, category_id) VALUES ('أثاث', '2024-11-04 07:12:21.478138+00', 2);
INSERT INTO public.deal_images (id, deal_id, image_url, created_at) VALUES (1, 39, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/2024_11_01T20_35_42_139084', '2024-11-01 17:35:42.122515+00');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('canon', '', '2024-11-06', '2024-11-12', 60, 0, 900, 900, 'private', 100, 100, '', '2024-11-05 08:40:33.58055+00', NULL, NULL, NULL, 42, 60, 1, 1, 20, 50, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES (' اذن لاسلكي برو', 'سماعة من صين', '2024-11-07', '2024-11-28', 30, 25, 50, 75, 'active', 1, 20, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/41K4KvjnSjL-removebg-preview.png', '2024-11-07 08:14:45.996455+00', NULL, NULL, NULL, 44, 0, 26, 1, 20, 30, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('kan kan t shirt', '', '2024-11-08', '2024-11-10', 2, 10, 8, 18, 'active', 1, 30, '', '2024-11-08 00:51:24.677728+00', NULL, NULL, NULL, 48, 0, 28, 2, 10, 20, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('شاشة tcl', '', '2024-11-01', '2024-11-30', 20, 20, 20, 40, 'private', 2, 20, '', '2024-11-01 19:36:56.574803+00', NULL, NULL, NULL, 40, 20, 24, 1, 3, 4, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('كامرا', '', '2024-10-29', '2024-11-30', 80, 30, 20, 50, 'active', 2, 50, '', '2024-10-27 09:28:36.336579+00', NULL, NULL, NULL, 1, 2, 1, 1, 10, 20, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('طاولة', 'طاولة منزل', '2024-11-06', '2024-11-15', 100, 90, 190, 190, 'active', 1, 20, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/table.png', '2024-11-07 08:53:03.706727+00', NULL, NULL, NULL, 47, 2, 27, 2, 30, 40, 125855669);
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('سماعة لا سلكية', '', '2024-11-05', '2024-11-10', 100, 50, 150, 200, 'private', 1, 10, '', '2024-11-05 08:06:17.280919+00', NULL, NULL, NULL, 41, 10, 1, 1, 20, 50, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('طابعة', '', '2024-10-28', '2024-10-31', 35, 35, 35, 70, 'active', 5, 35, '', '2024-10-28 16:10:32.752765+00', NULL, NULL, NULL, 2, 1, 2, 1, 10, 10, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('كوب شاي', '', '2024-11-01', '2024-11-08', 200, 100, 300, 400, 'active', 2, 100, '', '2024-10-31 22:36:15.295374+00', NULL, NULL, NULL, 4, 1, 2, 2, 20, 50, 14580);
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('حافظات الحماية  ايفون', '', '2024-11-01', '2024-11-08', 58, 50, 25, 75, 'closed', 2, 30, '', '2024-11-01 10:16:17.705745+00', NULL, NULL, NULL, 5, 30, 1, 1, 10, 30, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('حافظات الحماية سمسنج', '', '2024-11-01', '2024-11-08', 20, 20, 20, 40, 'pending', 2, 20, '', '2024-11-01 10:24:50.753462+00', NULL, NULL, NULL, 6, 0, 1, 1, 10, 10, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('بور بانك', '', '2024-11-01', '2024-11-08', 12, 12, 12, 24, 'pending', 1, 12, '', '2024-11-01 17:35:40.336317+00', NULL, NULL, NULL, 39, -3, 1, 1, 12, 12, 32143214324);
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('عددس كامرة كانون', '', '2024-11-01', '2024-11-15', 12, 12, 12, 24, 'active', 1, 12, '', '2024-11-01 17:34:21.120313+00', NULL, NULL, NULL, 38, 0, 3, 1, 12, 13, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('طاولة', '', '2025-02-25', '2025-02-28', 300, 100, 500, 600, 'active', 1, 10, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/table.png', '2025-01-14 10:13:41.881516+00', NULL, NULL, NULL, 51, 0, 27, 2, 30, 50, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('سماعه', '', '2025-03-12', '2025-03-26', 200, 50, 250, 300, 'active', 1, 200, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/41K4KvjnSjL-removebg-preview.png', '2025-02-25 14:48:18.464486+00', NULL, NULL, NULL, 53, 0, 26, 1, 25, 30, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('ساعة', '', '2025-02-25', '2025-03-07', 50, 20, 100, 120, 'active', 1, 50, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/a6cb2a6cd4e241cf586979cb56867167ad4fc605_622722_1-removebg-preview.png', '2025-01-26 08:31:17.225151+00', NULL, NULL, NULL, 52, 0, 29, 1, 10, 15, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('new smart watch', '', '2025-03-12', '2025-03-14', 30, 10, 50, 60, 'private', 1, 50, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/a6cb2a6cd4e241cf586979cb56867167ad4fc605_622722_1-removebg-preview.png', '2024-11-08 00:57:33.670853+00', NULL, NULL, NULL, 49, 0, 25, 1, 10, 30, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('ساعة ذكية', '', '2025-01-13', '2025-01-20', 1000, 200, 1500, 1700, 'active', 1, 100, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/a6cb2a6cd4e241cf586979cb56867167ad4fc605_622722_1-removebg-preview.png', '2025-01-13 20:43:43.644257+00', NULL, NULL, NULL, 50, 0, 25, 1, 30, 50, '');
INSERT INTO public.deals (deal_title, deal_description, start_date, end_date, cost_price, delivery_price, sale_price, total_price, deal_status, max_orders_per_user, quantity, deal_url, created_at, created_by, updated_by, updated_at, deal_id, number_of_order, product_id, category_id, estimate_delivery_date_from, estimate_delivery_time_to, tracking_number) VALUES ('ساعة سمارت باند', 'ساعة ذكية من الصين', '2025-03-12', '2025-03-26', 25, 25, 50, 75, 'active', 1, 20, 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/a6cb2a6cd4e241cf586979cb56867167ad4fc605_622722_1-removebg-preview.png', '2024-11-07 08:07:00.84988+00', NULL, NULL, NULL, 43, 0, 25, 1, 20, 30, '');
INSERT INTO public.factories (factory_name, region, department, factory_representative, contact_phone, is_black_list, created_at, updated_at, created_by, updated_by, factory_id) VALUES ('Shenzhen Huali Electronics Co., Ltd.', 'honkong', 'اثاث', 'مهدي', 0500000000, true, '2024-10-27 09:19:58.149176+00', NULL, NULL, NULL, 1);
INSERT INTO public.factories (factory_name, region, department, factory_representative, contact_phone, is_black_list, created_at, updated_at, created_by, updated_by, factory_id) VALUES ('Beijing Global Precision Industries', 'honkong', 'bb', 'علي', 0500000000, true, '2024-10-28 07:11:42.791755+00', NULL, NULL, NULL, 3);
INSERT INTO public.factories (factory_name, region, department, factory_representative, contact_phone, is_black_list, created_at, updated_at, created_by, updated_by, factory_id) VALUES ('Kan Kan', 'Honking', 'Electronic', 'ali', 0500000000, false, '2024-11-07 07:57:49.918421+00', NULL, NULL, NULL, 4);
INSERT INTO public.factories (factory_name, region, department, factory_representative, contact_phone, is_black_list, created_at, updated_at, created_by, updated_by, factory_id) VALUES ('Guangzhou GreenTech Manufacturing', 'honkong', 'الإكترونيات', 'مهدي', 0500000000, true, '2024-10-27 18:27:14.873045+00', NULL, NULL, NULL, 2);
INSERT INTO public.factories (factory_name, region, department, factory_representative, contact_phone, is_black_list, created_at, updated_at, created_by, updated_by, factory_id) VALUES ('kan kan fo cloth', 'honkong', 'cloth', 'mahdi', 055000000, false, '2024-11-08 00:49:36.613447+00', NULL, NULL, NULL, 6);
INSERT INTO public.factories (factory_name, region, department, factory_representative, contact_phone, is_black_list, created_at, updated_at, created_by, updated_by, factory_id) VALUES ('kan kan fortunat', 'honkong', 'اثاث', 'mahdi', 050000000, false, '2024-11-08 00:37:30.889849+00', NULL, NULL, NULL, 5);
INSERT INTO public.factories (factory_name, region, department, factory_representative, contact_phone, is_black_list, created_at, updated_at, created_by, updated_by, factory_id) VALUES ('ت', 'ت', 'ت', 'الو', 0547296146, false, '2025-01-26 09:09:03.276014+00', NULL, NULL, NULL, 7);
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (3, 7, 'inTransit', '2024-11-01 14:04:42.976479+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (4, 7, 'inSaudi', '2024-11-01 14:22:42.84703+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (40, 26, 'inTransit', '2024-11-03 12:38:39.74722+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (5, 7, 'inSaudi', '2024-11-01 14:23:50.0146+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (1, 1, 'pending', '2024-11-01 14:04:20.972362+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (2, 7, 'processing', '2024-11-01 14:04:31.927884+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (22, 17, 'pending', '2024-11-02 10:22:47.269013+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (23, 18, 'pending', '2024-11-02 10:27:35.414393+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (24, 19, 'pending', '2024-11-02 10:40:46.685866+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (25, 20, 'pending', '2024-11-02 10:43:02.080198+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (26, 22, 'pending', '2024-11-02 11:21:43.19496+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (27, 23, 'pending', '2024-11-02 17:21:08.40467+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (28, 23, 'processing', '2024-11-02 17:21:55.539753+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (29, 23, 'inChina', '2024-11-02 17:22:06.708418+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (30, 23, 'inTransit', '2024-11-02 17:22:31.343726+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (31, 24, 'pending', '2024-11-03 12:23:24.951851+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (32, 24, 'processing', '2024-11-03 12:23:45.904839+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (33, 24, 'inChina', '2024-11-03 12:23:57.850286+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (34, 25, 'pending', '2024-11-03 12:29:51.881626+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (35, 26, 'pending', '2024-11-03 12:34:22.509402+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (36, 26, 'inTransit', '2024-11-03 12:38:23.677398+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (37, 26, 'inSaudi', '2024-11-03 12:38:28.684721+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (38, 26, 'withShipmentCompany', '2024-11-03 12:38:31.794648+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (39, 26, 'completed', '2024-11-03 12:38:35.380805+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (41, 26, 'withShipmentCompany', '2024-11-03 12:53:32.333031+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (42, 25, 'withShipmentCompany', '2024-11-03 12:53:32.414812+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (43, 24, 'withShipmentCompany', '2024-11-03 12:53:32.416194+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (44, 23, 'withShipmentCompany', '2024-11-03 12:53:32.426829+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (45, 21, 'withShipmentCompany', '2024-11-03 12:53:32.445008+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (46, 7, 'withShipmentCompany', '2024-11-03 12:53:32.603278+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (47, 26, 'processing', '2024-11-03 13:15:47.679406+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (48, 27, 'pending', '2024-11-03 13:27:58.42088+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (49, 27, 'processing', '2024-11-03 13:28:46.738684+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (50, 27, 'completed', '2024-11-03 14:48:17.30616+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (51, 26, 'completed', '2024-11-03 14:48:17.53037+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (52, 23, 'completed', '2024-11-03 14:48:17.529968+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (53, 25, 'completed', '2024-11-03 14:48:17.530098+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (54, 24, 'completed', '2024-11-03 14:48:17.535265+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (55, 21, 'completed', '2024-11-03 14:48:17.557527+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (56, 7, 'completed', '2024-11-03 14:48:17.720028+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (57, 5, 'pending', '2024-11-03 15:43:48.827509+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (58, 4, 'pending', '2024-11-03 15:43:49.100975+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (59, 3, 'pending', '2024-11-03 15:43:49.262926+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (60, 1, 'pending', '2024-11-03 15:43:49.272233+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (61, 2, 'pending', '2024-11-03 15:43:49.273719+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (62, 3, 'withShipmentCompany', '2024-11-03 15:43:56.675489+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (63, 5, 'withShipmentCompany', '2024-11-03 15:43:56.680974+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (64, 4, 'withShipmentCompany', '2024-11-03 15:43:56.68124+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (65, 1, 'withShipmentCompany', '2024-11-03 15:43:56.682743+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (66, 2, 'withShipmentCompany', '2024-11-03 15:43:56.895691+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (67, 1, 'processing', '2024-11-03 16:35:34.253964+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (68, 5, 'processing', '2024-11-03 16:35:34.376493+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (69, 4, 'processing', '2024-11-03 16:35:34.422317+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (70, 2, 'processing', '2024-11-03 16:35:34.43565+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (71, 3, 'processing', '2024-11-03 16:35:34.465278+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (72, 5, 'processing', '2024-11-03 16:36:23.137319+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (73, 3, 'processing', '2024-11-03 16:36:23.227196+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (74, 2, 'processing', '2024-11-03 16:36:23.23687+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (75, 1, 'processing', '2024-11-03 16:36:23.252288+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (76, 4, 'processing', '2024-11-03 16:36:23.439273+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (77, 5, 'processing', '2024-11-03 16:37:37.308437+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (78, 4, 'processing', '2024-11-03 16:37:37.491385+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (79, 1, 'processing', '2024-11-03 16:37:37.494947+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (80, 3, 'processing', '2024-11-03 16:37:37.506766+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (81, 2, 'processing', '2024-11-03 16:37:37.674407+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (82, 21, 'processing', '2024-11-03 16:42:09.12252+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (83, 24, 'processing', '2024-11-03 16:42:09.230584+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (84, 7, 'processing', '2024-11-03 16:42:09.292995+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (85, 23, 'processing', '2024-11-03 16:42:09.299241+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (86, 26, 'processing', '2024-11-03 16:42:09.318964+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (87, 25, 'processing', '2024-11-03 16:42:09.319451+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (88, 27, 'processing', '2024-11-03 16:42:09.321199+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (89, 21, 'processing', '2024-11-03 16:42:33.409187+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (90, 24, 'processing', '2024-11-03 16:42:33.600975+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (91, 7, 'processing', '2024-11-03 16:42:33.609463+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (92, 23, 'processing', '2024-11-03 16:42:33.612065+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (93, 25, 'processing', '2024-11-03 16:42:33.616192+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (94, 26, 'processing', '2024-11-03 16:42:33.605227+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (95, 27, 'processing', '2024-11-03 16:42:33.647744+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (96, 21, 'processing', '2024-11-03 16:43:15.737958+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (97, 23, 'processing', '2024-11-03 16:43:15.925464+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (98, 7, 'processing', '2024-11-03 16:43:15.925957+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (99, 27, 'processing', '2024-11-03 16:43:15.929635+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (100, 24, 'processing', '2024-11-03 16:43:15.937488+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (101, 26, 'processing', '2024-11-03 16:43:15.948557+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (102, 25, 'processing', '2024-11-03 16:43:16.10471+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (103, 21, 'processing', '2024-11-03 16:45:09.761693+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (104, 7, 'processing', '2024-11-03 16:45:09.87711+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (105, 24, 'processing', '2024-11-03 16:45:09.885696+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (106, 26, 'processing', '2024-11-03 16:45:09.95514+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (107, 27, 'processing', '2024-11-03 16:45:09.961966+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (108, 25, 'processing', '2024-11-03 16:45:09.971239+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (109, 23, 'processing', '2024-11-03 16:45:09.980569+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (110, 27, 'processing', '2024-11-03 16:47:29.057793+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (111, 25, 'processing', '2024-11-03 16:47:29.062954+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (112, 24, 'processing', '2024-11-03 16:47:29.064363+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (113, 7, 'processing', '2024-11-03 16:47:29.071872+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (114, 26, 'processing', '2024-11-03 16:47:29.074912+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (115, 21, 'processing', '2024-11-03 16:47:29.086624+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (116, 23, 'processing', '2024-11-03 16:47:29.190291+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (117, 21, 'processing', '2024-11-03 16:48:13.05142+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (118, 24, 'processing', '2024-11-03 16:48:13.126092+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (119, 27, 'processing', '2024-11-03 16:48:13.146195+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (120, 7, 'processing', '2024-11-03 16:48:13.148598+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (121, 25, 'processing', '2024-11-03 16:48:13.153641+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (122, 26, 'processing', '2024-11-03 16:48:13.15521+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (123, 23, 'processing', '2024-11-03 16:48:13.168112+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (124, 21, 'pending', '2024-11-03 16:48:16.782819+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (125, 23, 'pending', '2024-11-03 16:48:16.783642+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (126, 7, 'pending', '2024-11-03 16:48:16.786224+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (127, 26, 'pending', '2024-11-03 16:48:16.788907+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (128, 27, 'pending', '2024-11-03 16:48:16.789168+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (129, 24, 'pending', '2024-11-03 16:48:16.790797+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (130, 25, 'pending', '2024-11-03 16:48:16.794838+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (131, 24, 'inChina', '2024-11-03 16:48:19.662774+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (132, 25, 'inChina', '2024-11-03 16:48:19.665078+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (133, 7, 'inChina', '2024-11-03 16:48:19.668023+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (134, 21, 'inChina', '2024-11-03 16:48:19.668107+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (135, 27, 'inChina', '2024-11-03 16:48:19.672116+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (136, 26, 'inChina', '2024-11-03 16:48:19.676091+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (137, 23, 'inChina', '2024-11-03 16:48:19.688173+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (138, 21, 'withShipmentCompany', '2024-11-03 16:48:24.243198+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (139, 26, 'withShipmentCompany', '2024-11-03 16:48:24.245061+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (140, 23, 'withShipmentCompany', '2024-11-03 16:48:24.24574+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (141, 27, 'withShipmentCompany', '2024-11-03 16:48:24.247199+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (142, 25, 'withShipmentCompany', '2024-11-03 16:48:24.246759+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (143, 24, 'withShipmentCompany', '2024-11-03 16:48:24.248971+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (144, 7, 'withShipmentCompany', '2024-11-03 16:48:24.436665+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (145, 21, 'processing', '2024-11-03 16:50:03.561515+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (146, 7, 'processing', '2024-11-03 16:50:03.643571+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (147, 26, 'processing', '2024-11-03 16:50:03.645829+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (148, 24, 'processing', '2024-11-03 16:50:03.643141+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (149, 25, 'processing', '2024-11-03 16:50:03.665926+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (150, 27, 'processing', '2024-11-03 16:50:03.674915+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (151, 23, 'processing', '2024-11-03 16:50:03.678846+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (152, 26, 'withShipmentCompany', '2024-11-03 16:50:11.658101+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (154, 7, 'withShipmentCompany', '2024-11-03 16:50:11.660757+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (155, 21, 'withShipmentCompany', '2024-11-03 16:50:11.662505+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (156, 23, 'withShipmentCompany', '2024-11-03 16:50:11.664531+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (157, 27, 'withShipmentCompany', '2024-11-03 16:50:11.667973+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (153, 25, 'withShipmentCompany', '2024-11-03 16:50:11.659301+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (158, 24, 'withShipmentCompany', '2024-11-03 16:50:11.668509+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (159, 21, 'processing', '2024-11-03 16:52:04.867184+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (160, 7, 'processing', '2024-11-03 16:52:04.928533+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (161, 24, 'processing', '2024-11-03 16:52:04.936122+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (162, 25, 'processing', '2024-11-03 16:52:04.947535+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (163, 23, 'processing', '2024-11-03 16:52:04.948197+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (164, 27, 'processing', '2024-11-03 16:52:04.973555+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (165, 26, 'processing', '2024-11-03 16:52:05.140609+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (166, 7, 'withShipmentCompany', '2024-11-03 16:52:12.707731+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (167, 24, 'withShipmentCompany', '2024-11-03 16:52:12.709536+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (168, 25, 'withShipmentCompany', '2024-11-03 16:52:12.711042+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (169, 21, 'withShipmentCompany', '2024-11-03 16:52:12.719037+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (170, 26, 'withShipmentCompany', '2024-11-03 16:52:12.723015+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (171, 23, 'withShipmentCompany', '2024-11-03 16:52:12.725229+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (172, 27, 'withShipmentCompany', '2024-11-03 16:52:12.727752+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (173, 27, 'processing', '2024-11-03 16:52:43.277868+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (174, 25, 'processing', '2024-11-03 16:52:43.366495+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (175, 26, 'processing', '2024-11-03 16:52:43.375861+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (176, 21, 'processing', '2024-11-03 16:52:43.376957+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (177, 7, 'processing', '2024-11-03 16:52:43.382138+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (178, 24, 'processing', '2024-11-03 16:52:43.389776+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (179, 23, 'processing', '2024-11-03 16:52:43.442377+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (180, 7, 'withShipmentCompany', '2024-11-03 16:52:50.442678+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (181, 24, 'withShipmentCompany', '2024-11-03 16:52:50.445574+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (182, 27, 'withShipmentCompany', '2024-11-03 16:52:50.447338+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (183, 25, 'withShipmentCompany', '2024-11-03 16:52:50.450166+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (184, 21, 'withShipmentCompany', '2024-11-03 16:52:50.456091+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (185, 23, 'withShipmentCompany', '2024-11-03 16:52:50.457794+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (186, 26, 'withShipmentCompany', '2024-11-03 16:52:50.465886+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (187, 27, 'withShipmentCompany', '2024-11-03 16:55:12.824519+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (188, 26, 'withShipmentCompany', '2024-11-03 16:55:12.928834+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (190, 25, 'withShipmentCompany', '2024-11-03 16:55:12.941308+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (189, 24, 'withShipmentCompany', '2024-11-03 16:55:12.937798+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (191, 23, 'withShipmentCompany', '2024-11-03 16:55:12.945052+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (192, 7, 'withShipmentCompany', '2024-11-03 16:55:12.945996+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (193, 21, 'withShipmentCompany', '2024-11-03 16:55:13.135403+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (194, 27, 'withShipmentCompany', '2024-11-03 16:57:25.323114+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (195, 26, 'withShipmentCompany', '2024-11-03 16:57:25.407798+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (196, 24, 'withShipmentCompany', '2024-11-03 16:57:25.416496+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (197, 7, 'withShipmentCompany', '2024-11-03 16:57:25.4175+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (198, 21, 'withShipmentCompany', '2024-11-03 16:57:25.415801+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (199, 23, 'withShipmentCompany', '2024-11-03 16:57:25.423581+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (200, 25, 'withShipmentCompany', '2024-11-03 16:57:25.431261+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (201, 27, 'withShipmentCompany', '2024-11-03 16:58:49.391566+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (202, 24, 'withShipmentCompany', '2024-11-03 16:58:49.464807+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (203, 7, 'withShipmentCompany', '2024-11-03 16:58:49.48646+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (204, 26, 'withShipmentCompany', '2024-11-03 16:58:49.482203+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (205, 25, 'withShipmentCompany', '2024-11-03 16:58:49.48723+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (206, 21, 'withShipmentCompany', '2024-11-03 16:58:49.488699+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (207, 23, 'withShipmentCompany', '2024-11-03 16:58:49.490227+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (208, 27, 'withShipmentCompany', '2024-11-03 16:59:58.933771+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (209, 24, 'withShipmentCompany', '2024-11-03 16:59:58.994349+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (210, 25, 'withShipmentCompany', '2024-11-03 16:59:59.01283+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (211, 7, 'withShipmentCompany', '2024-11-03 16:59:59.025553+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (212, 23, 'withShipmentCompany', '2024-11-03 16:59:59.030115+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (213, 26, 'withShipmentCompany', '2024-11-03 16:59:59.033393+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (214, 21, 'withShipmentCompany', '2024-11-03 16:59:59.039358+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (215, 27, 'withShipmentCompany', '2024-11-03 17:00:15.97748+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (216, 24, 'withShipmentCompany', '2024-11-03 17:00:16.083687+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (217, 26, 'withShipmentCompany', '2024-11-03 17:00:16.083962+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (218, 25, 'withShipmentCompany', '2024-11-03 17:00:16.087838+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (219, 23, 'withShipmentCompany', '2024-11-03 17:00:16.089292+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (220, 21, 'withShipmentCompany', '2024-11-03 17:00:16.10106+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (221, 7, 'withShipmentCompany', '2024-11-03 17:00:16.102728+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (222, 27, 'withShipmentCompany', '2024-11-03 17:00:23.354958+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (223, 26, 'withShipmentCompany', '2024-11-03 17:00:23.355561+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (224, 23, 'withShipmentCompany', '2024-11-03 17:00:23.360211+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (225, 24, 'withShipmentCompany', '2024-11-03 17:00:23.360479+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (226, 21, 'withShipmentCompany', '2024-11-03 17:00:23.363954+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (227, 25, 'withShipmentCompany', '2024-11-03 17:00:23.367359+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (228, 7, 'withShipmentCompany', '2024-11-03 17:00:23.371039+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (229, 26, 'withShipmentCompany', '2024-11-03 17:00:32.623017+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (230, 21, 'withShipmentCompany', '2024-11-03 17:00:32.62506+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (231, 25, 'withShipmentCompany', '2024-11-03 17:00:32.625967+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (232, 23, 'withShipmentCompany', '2024-11-03 17:00:32.627186+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (233, 27, 'withShipmentCompany', '2024-11-03 17:00:32.626588+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (234, 24, 'withShipmentCompany', '2024-11-03 17:00:32.629434+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (235, 7, 'withShipmentCompany', '2024-11-03 17:00:32.630055+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (236, 27, 'withShipmentCompany', '2024-11-03 17:00:50.745976+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (237, 26, 'withShipmentCompany', '2024-11-03 17:00:50.865106+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (238, 25, 'withShipmentCompany', '2024-11-03 17:00:50.867835+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (239, 7, 'withShipmentCompany', '2024-11-03 17:00:50.871737+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (240, 23, 'withShipmentCompany', '2024-11-03 17:00:50.871632+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (241, 21, 'withShipmentCompany', '2024-11-03 17:00:50.873492+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (242, 24, 'withShipmentCompany', '2024-11-03 17:00:50.874527+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (243, 27, 'withShipmentCompany', '2024-11-03 17:01:18.55446+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (244, 23, 'withShipmentCompany', '2024-11-03 17:01:18.669583+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (245, 26, 'withShipmentCompany', '2024-11-03 17:01:18.669144+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (246, 7, 'withShipmentCompany', '2024-11-03 17:01:18.67239+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (247, 21, 'withShipmentCompany', '2024-11-03 17:01:18.673561+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (248, 25, 'withShipmentCompany', '2024-11-03 17:01:18.676582+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (249, 24, 'withShipmentCompany', '2024-11-03 17:01:18.687618+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (250, 27, 'withShipmentCompany', '2024-11-03 17:02:32.460328+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (251, 26, 'withShipmentCompany', '2024-11-03 17:02:32.514029+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (252, 25, 'withShipmentCompany', '2024-11-03 17:02:32.532968+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (253, 24, 'withShipmentCompany', '2024-11-03 17:02:32.53682+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (254, 7, 'withShipmentCompany', '2024-11-03 17:02:32.538195+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (255, 21, 'withShipmentCompany', '2024-11-03 17:02:32.537495+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (256, 23, 'withShipmentCompany', '2024-11-03 17:02:32.550364+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (257, 27, 'withShipmentCompany', '2024-11-03 17:05:57.104103+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (258, 26, 'withShipmentCompany', '2024-11-03 17:05:57.188473+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (259, 25, 'withShipmentCompany', '2024-11-03 17:05:57.200643+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (260, 21, 'withShipmentCompany', '2024-11-03 17:05:57.205019+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (261, 24, 'withShipmentCompany', '2024-11-03 17:05:57.195303+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (262, 23, 'withShipmentCompany', '2024-11-03 17:05:57.208488+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (263, 7, 'withShipmentCompany', '2024-11-03 17:05:57.206379+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (264, 27, 'processing', '2024-11-03 17:08:59.142697+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (265, 26, 'processing', '2024-11-03 17:08:59.212482+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (266, 24, 'processing', '2024-11-03 17:08:59.229943+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (267, 7, 'processing', '2024-11-03 17:08:59.241052+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (268, 21, 'processing', '2024-11-03 17:08:59.248796+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (269, 23, 'processing', '2024-11-03 17:08:59.250304+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (270, 25, 'processing', '2024-11-03 17:08:59.267102+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (271, 24, 'processing', '2024-11-03 17:09:09.64059+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (272, 25, 'processing', '2024-11-03 17:09:09.640349+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (273, 21, 'processing', '2024-11-03 17:09:09.642247+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (274, 27, 'processing', '2024-11-03 17:09:09.643089+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (275, 7, 'processing', '2024-11-03 17:09:09.642761+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (276, 26, 'processing', '2024-11-03 17:09:09.645281+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (277, 23, 'processing', '2024-11-03 17:09:09.653678+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (278, 27, 'withShipmentCompany', '2024-11-03 17:09:20.639953+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (279, 23, 'withShipmentCompany', '2024-11-03 17:09:20.640448+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (280, 26, 'withShipmentCompany', '2024-11-03 17:09:20.642571+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (281, 24, 'withShipmentCompany', '2024-11-03 17:09:20.642857+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (282, 7, 'withShipmentCompany', '2024-11-03 17:09:20.647682+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (283, 25, 'withShipmentCompany', '2024-11-03 17:09:20.653928+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (284, 21, 'withShipmentCompany', '2024-11-03 17:09:20.664392+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (285, 28, 'pending', '2024-11-04 08:16:10.785307+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (286, 28, 'inChina', '2024-11-04 08:22:14.283534+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (287, 28, 'inTransit', '2024-11-04 08:22:26.871106+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (288, 28, 'pending', '2024-11-04 08:24:27.989254+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (289, 28, 'pending', '2024-11-04 08:24:34.276024+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (290, 21, 'pending', '2024-11-04 08:24:34.426729+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (291, 27, 'pending', '2024-11-04 08:24:34.433202+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (292, 23, 'pending', '2024-11-04 08:24:34.586663+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (293, 26, 'pending', '2024-11-04 08:24:34.604694+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (294, 7, 'pending', '2024-11-04 08:24:34.609625+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (295, 25, 'pending', '2024-11-04 08:24:34.611568+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (296, 24, 'pending', '2024-11-04 08:24:34.630603+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (297, 28, 'completed', '2024-11-04 08:27:33.464479+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (298, 23, 'completed', '2024-11-04 08:27:33.547599+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (299, 27, 'completed', '2024-11-04 08:27:33.621478+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (300, 21, 'completed', '2024-11-04 08:27:33.63028+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (301, 26, 'completed', '2024-11-04 08:27:33.630186+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (302, 24, 'completed', '2024-11-04 08:27:33.627924+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (303, 25, 'completed', '2024-11-04 08:27:33.636367+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (304, 7, 'completed', '2024-11-04 08:27:33.810138+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (305, 22, 'processing', '2024-11-04 08:34:47.803625+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (306, 22, 'pending', '2024-11-04 08:36:16.326245+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (307, 28, 'canceled', '2024-11-04 10:29:18.389002+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (308, 5, 'completed', '2024-11-04 11:11:31.300371+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (309, 3, 'completed', '2024-11-04 11:11:31.378676+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (310, 1, 'completed', '2024-11-04 11:11:31.387527+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (311, 2, 'completed', '2024-11-04 11:11:31.393534+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (312, 4, 'completed', '2024-11-04 11:11:31.395892+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (313, 27, 'inChina', '2024-11-04 13:04:41.633452+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (314, 26, 'inTransit', '2024-11-04 13:04:55.335585+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (315, 25, 'inSaudi', '2024-11-04 13:06:00.759014+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (316, 27, 'canceled', '2024-11-04 14:11:58.679898+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (317, 28, 'processing', '2024-11-04 14:14:10.014575+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (318, 28, 'canceled', '2024-11-04 14:14:14.454561+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (319, 29, 'pending', '2024-11-04 14:57:45.263619+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (320, 30, 'pending', '2024-11-04 15:40:03.408671+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (321, 30, 'processing', '2024-11-04 19:27:28.792888+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (322, 31, 'pending', '2024-11-05 08:18:46.093989+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (323, 32, 'pending', '2024-11-05 08:24:08.55219+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (324, 33, 'pending', '2024-11-05 08:24:26.596956+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (325, 33, 'processing', '2024-11-05 08:25:48.112262+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (326, 32, 'processing', '2024-11-05 08:25:48.18496+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (327, 29, 'processing', '2024-11-05 08:25:48.193002+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (328, 31, 'processing', '2024-11-05 08:25:48.199913+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (329, 33, 'inChina', '2024-11-05 08:25:54.90378+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (330, 32, 'inChina', '2024-11-05 08:25:54.902751+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (331, 31, 'inChina', '2024-11-05 08:25:54.910775+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (332, 29, 'inChina', '2024-11-05 08:25:54.917358+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (333, 32, 'inTransit', '2024-11-05 08:25:58.145919+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (334, 31, 'inTransit', '2024-11-05 08:25:58.151421+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (335, 33, 'inTransit', '2024-11-05 08:25:58.153789+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (336, 29, 'inTransit', '2024-11-05 08:25:58.154564+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (337, 33, 'inSaudi', '2024-11-05 08:26:00.349674+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (338, 29, 'inSaudi', '2024-11-05 08:26:00.351721+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (339, 31, 'inSaudi', '2024-11-05 08:26:00.352661+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (340, 32, 'inSaudi', '2024-11-05 08:26:00.355816+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (341, 33, 'withShipmentCompany', '2024-11-05 08:26:51.591813+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (342, 33, 'inSaudi', '2024-11-05 08:27:39.308949+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (343, 29, 'inSaudi', '2024-11-05 08:27:39.416618+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (344, 32, 'inSaudi', '2024-11-05 08:27:39.43158+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (345, 31, 'inSaudi', '2024-11-05 08:27:39.442564+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (346, 33, 'processing', '2024-11-05 08:28:35.131721+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (347, 29, 'processing', '2024-11-05 08:28:35.402759+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (348, 31, 'processing', '2024-11-05 08:28:35.411974+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (349, 32, 'processing', '2024-11-05 08:28:35.412981+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (350, 33, 'withShipmentCompany', '2024-11-05 08:31:44.453582+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (351, 34, 'pending', '2024-11-05 08:44:19.57544+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (352, 34, 'processing', '2024-11-05 08:44:47.569248+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (353, 34, 'inChina', '2024-11-05 08:44:55.999555+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (354, 34, 'withShipmentCompany', '2024-11-05 08:45:00.800384+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (355, 35, 'pending', '2024-11-05 09:08:37.092906+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (356, 34, 'processing', '2024-11-05 09:19:18.436216+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (357, 36, 'pending', '2024-11-05 09:22:38.184547+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (358, 37, 'pending', '2024-11-05 09:28:46.735886+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (359, 38, 'pending', '2024-11-05 09:32:00.785927+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (360, 38, 'canceled', '2024-11-05 11:39:51.022471+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (361, 38, 'canceled', '2024-11-05 11:44:07.626629+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (362, 30, 'canceled', '2024-11-05 11:45:19.596205+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (363, 30, 'pending', '2024-11-05 11:45:34.159984+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (364, 30, 'canceled', '2024-11-05 11:45:39.550357+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (365, 38, 'canceled', '2024-11-05 11:45:40.146026+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (366, 5, 'canceled', '2024-11-05 11:46:04.153326+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (367, 5, 'canceled', '2024-11-05 11:48:24.779848+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (368, 4, 'canceled', '2024-11-05 11:48:24.88599+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (369, 3, 'canceled', '2024-11-05 11:48:24.900372+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (370, 1, 'canceled', '2024-11-05 11:48:24.90616+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (371, 2, 'canceled', '2024-11-05 11:48:25.10493+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (372, 38, 'canceled', '2024-11-05 11:48:39.007471+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (373, 5, 'pending', '2024-11-05 11:50:36.346115+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (374, 1, 'pending', '2024-11-05 11:50:36.424973+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (375, 2, 'pending', '2024-11-05 11:50:36.44445+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (376, 3, 'pending', '2024-11-05 11:50:36.465044+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (377, 4, 'pending', '2024-11-05 11:50:36.48491+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (378, 5, 'canceled', '2024-11-05 11:52:39.312127+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (379, 3, 'canceled', '2024-11-05 11:52:39.312838+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (380, 4, 'canceled', '2024-11-05 11:52:39.314112+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (381, 2, 'canceled', '2024-11-05 11:52:39.331503+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (382, 1, 'canceled', '2024-11-05 11:52:39.333131+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (383, 4, 'canceled', '2024-11-05 11:54:15.771342+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (384, 3, 'canceled', '2024-11-05 11:54:15.773914+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (385, 1, 'canceled', '2024-11-05 11:54:15.772142+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (386, 2, 'canceled', '2024-11-05 11:54:15.780429+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (387, 5, 'canceled', '2024-11-05 11:54:15.789702+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (388, 5, 'pending', '2024-11-05 11:54:37.537183+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (389, 3, 'pending', '2024-11-05 11:54:37.570626+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (390, 1, 'pending', '2024-11-05 11:54:37.575506+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (391, 4, 'pending', '2024-11-05 11:54:37.582482+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (392, 2, 'pending', '2024-11-05 11:54:37.584145+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (393, 5, 'canceled', '2024-11-05 11:54:44.747238+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (394, 5, 'pending', '2024-11-05 11:59:00.24337+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (395, 5, 'pending', '2024-11-05 11:59:03.47913+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (396, 5, 'processing', '2024-11-05 11:59:06.864919+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (397, 4, 'processing', '2024-11-05 11:59:52.199875+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (398, 5, 'processing', '2024-11-05 11:59:52.219905+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (399, 2, 'processing', '2024-11-05 11:59:52.228792+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (400, 3, 'processing', '2024-11-05 11:59:52.366227+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (401, 1, 'processing', '2024-11-05 11:59:52.404839+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (402, 1, 'processing', '2024-11-05 12:00:03.855252+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (403, 2, 'processing', '2024-11-05 12:00:03.858602+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (404, 5, 'processing', '2024-11-05 12:00:03.86887+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (405, 3, 'processing', '2024-11-05 12:00:03.870371+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (406, 4, 'processing', '2024-11-05 12:00:03.886088+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (407, 2, 'processing', '2024-11-05 12:00:08.926717+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (408, 5, 'processing', '2024-11-05 12:00:08.930823+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (409, 4, 'processing', '2024-11-05 12:00:08.946281+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (410, 1, 'processing', '2024-11-05 12:00:08.948651+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (411, 3, 'processing', '2024-11-05 12:00:08.950792+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (412, 5, 'inChina', '2024-11-05 12:00:13.125791+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (413, 1, 'inChina', '2024-11-05 12:00:13.146681+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (414, 3, 'inChina', '2024-11-05 12:00:13.147002+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (415, 2, 'inChina', '2024-11-05 12:00:13.151526+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (416, 4, 'inChina', '2024-11-05 12:00:13.151526+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (417, 3, 'inChina', '2024-11-05 12:00:17.111031+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (418, 4, 'inChina', '2024-11-05 12:00:17.123575+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (419, 2, 'inChina', '2024-11-05 12:00:17.125151+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (420, 5, 'inChina', '2024-11-05 12:00:17.131178+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (421, 1, 'inChina', '2024-11-05 12:00:17.136536+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (422, 1, 'inSaudi', '2024-11-05 12:00:59.302837+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (423, 4, 'inSaudi', '2024-11-05 12:00:59.329162+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (424, 5, 'inSaudi', '2024-11-05 12:00:59.331474+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (425, 2, 'inSaudi', '2024-11-05 12:00:59.331473+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (426, 3, 'inSaudi', '2024-11-05 12:00:59.352979+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (427, 5, 'canceled', '2024-11-05 12:03:20.664451+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (428, 5, 'canceled', '2024-11-05 12:03:41.652455+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (429, 5, 'canceled', '2024-11-05 12:03:45.01048+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (430, 5, 'canceled', '2024-11-05 12:04:13.417224+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (431, 5, 'canceled', '2024-11-05 12:04:14.350058+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (432, 5, 'canceled', '2024-11-05 12:04:15.214583+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (433, 5, 'canceled', '2024-11-05 12:04:15.248681+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (434, 5, 'canceled', '2024-11-05 12:04:15.429523+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (435, 5, 'canceled', '2024-11-05 12:04:15.639024+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (436, 5, 'canceled', '2024-11-05 12:04:15.823067+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (437, 5, 'canceled', '2024-11-05 12:04:16.041189+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (438, 5, 'canceled', '2024-11-05 12:04:16.063484+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (439, 5, 'canceled', '2024-11-05 12:04:16.178383+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (440, 5, 'canceled', '2024-11-05 12:05:05.593566+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (441, 4, 'canceled', '2024-11-05 12:05:05.5972+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (442, 1, 'canceled', '2024-11-05 12:05:05.601327+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (443, 2, 'canceled', '2024-11-05 12:05:05.602978+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (444, 3, 'canceled', '2024-11-05 12:05:05.608541+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (445, 5, 'pending', '2024-11-05 12:06:05.132597+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (446, 34, 'canceled', '2024-11-05 12:06:15.214151+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (447, 34, 'canceled', '2024-11-05 12:06:26.872937+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (448, 34, 'canceled', '2024-11-05 12:06:28.402689+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (449, 34, 'canceled', '2024-11-05 12:06:28.812417+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (450, 34, 'canceled', '2024-11-05 12:06:28.941417+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (451, 34, 'canceled', '2024-11-05 12:06:29.238496+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (452, 34, 'canceled', '2024-11-05 12:06:29.45873+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (453, 34, 'withShipmentCompany', '2024-11-05 12:06:31.166664+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (454, 34, 'pending', '2024-11-05 12:06:34.745192+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (455, 34, 'pending', '2024-11-05 12:06:37.011528+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (456, 34, 'pending', '2024-11-05 12:06:37.147765+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (457, 34, 'pending', '2024-11-05 12:06:37.399203+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (458, 34, 'pending', '2024-11-05 12:06:37.55625+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (459, 34, 'pending', '2024-11-05 12:06:37.701758+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (460, 34, 'pending', '2024-11-05 12:06:37.880106+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (461, 34, 'pending', '2024-11-05 12:06:38.029266+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (462, 34, 'pending', '2024-11-05 12:06:38.269686+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (463, 34, 'pending', '2024-11-05 12:06:38.506802+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (464, 34, 'pending', '2024-11-05 12:06:38.678868+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (465, 34, 'pending', '2024-11-05 12:06:38.843739+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (466, 34, 'pending', '2024-11-05 12:06:39.13155+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (467, 34, 'pending', '2024-11-05 12:06:39.2993+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (468, 34, 'pending', '2024-11-05 12:06:39.492872+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (469, 34, 'pending', '2024-11-05 12:06:39.645161+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (470, 34, 'pending', '2024-11-05 12:06:39.793967+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (471, 34, 'pending', '2024-11-05 12:06:40.022426+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (477, 34, 'pending', '2024-11-05 12:06:41.282276+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (481, 34, 'pending', '2024-11-05 12:06:42.017649+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (483, 34, 'pending', '2024-11-05 12:06:42.384906+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (489, 34, 'pending', '2024-11-05 12:06:43.533351+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (472, 34, 'pending', '2024-11-05 12:06:40.201706+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (476, 34, 'pending', '2024-11-05 12:06:41.034751+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (478, 34, 'pending', '2024-11-05 12:06:41.345482+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (480, 34, 'pending', '2024-11-05 12:06:41.774256+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (482, 34, 'pending', '2024-11-05 12:06:42.180339+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (490, 34, 'pending', '2024-11-05 12:06:43.691+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (473, 34, 'pending', '2024-11-05 12:06:40.3819+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (475, 34, 'pending', '2024-11-05 12:06:40.784945+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (479, 34, 'pending', '2024-11-05 12:06:41.535908+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (485, 34, 'pending', '2024-11-05 12:06:42.674255+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (487, 34, 'pending', '2024-11-05 12:06:43.128565+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (491, 34, 'completed', '2024-11-05 12:06:47.969503+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (474, 34, 'pending', '2024-11-05 12:06:40.627195+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (484, 34, 'pending', '2024-11-05 12:06:42.510385+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (486, 34, 'pending', '2024-11-05 12:06:42.959089+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (488, 34, 'pending', '2024-11-05 12:06:43.363141+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (492, 34, 'pending', '2024-11-05 12:07:17.191728+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (493, 38, 'pending', '2024-11-05 12:07:21.956784+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (494, 38, 'processing', '2024-11-05 12:07:25.246167+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (495, 38, 'inTransit', '2024-11-05 12:07:27.765802+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (496, 38, 'canceled', '2024-11-05 12:07:30.076438+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (497, 34, 'canceled', '2024-11-05 12:07:42.78253+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (498, 34, 'completed', '2024-11-05 12:07:57.129195+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (499, 34, 'canceled', '2024-11-05 12:10:37.982129+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (500, 36, 'completed', '2024-11-05 12:21:52.948468+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (501, 5, 'pending', '2024-11-05 12:22:01.697394+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (502, 5, 'inChina', '2024-11-05 12:22:12.031755+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (503, 1, 'pending', '2024-11-05 12:22:31.649155+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (504, 1, 'processing', '2024-11-05 12:22:42.183497+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (505, 1, 'pending', '2024-11-05 12:22:51.203856+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (506, 38, 'pending', '2024-11-05 12:23:06.818485+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (507, 38, 'canceled', '2024-11-05 12:28:21.130565+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (508, 38, 'canceled', '2024-11-05 12:28:23.247811+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (509, 38, 'pending', '2024-11-05 12:30:06.856507+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (510, 38, 'canceled', '2024-11-05 12:30:18.451819+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (511, 38, 'pending', '2024-11-05 12:31:01.016553+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (512, 38, 'canceled', '2024-11-05 12:31:05.841265+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (513, 38, 'pending', '2024-11-05 12:31:51.450392+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (514, 38, 'canceled', '2024-11-05 12:31:55.742631+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (515, 38, 'pending', '2024-11-05 12:33:32.490965+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (516, 38, 'pending', '2024-11-05 12:33:39.644395+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (517, 38, 'canceled', '2024-11-05 12:33:47.507249+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (518, 38, 'pending', '2024-11-05 12:34:46.996585+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (519, 38, 'canceled', '2024-11-05 12:34:59.640341+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (520, 38, 'pending', '2024-11-05 12:36:19.624214+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (521, 38, 'canceled', '2024-11-05 12:36:24.675812+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (522, 38, 'pending', '2024-11-05 12:37:04.303813+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (523, 38, 'canceled', '2024-11-05 12:37:09.254245+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (524, 38, 'pending', '2024-11-05 12:38:31.633977+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (525, 38, 'canceled', '2024-11-05 12:38:40.666143+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (526, 38, 'pending', '2024-11-05 12:40:52.430131+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (527, 38, 'canceled', '2024-11-05 12:41:01.862842+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (528, 4, 'pending', '2024-11-05 12:41:38.522391+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (529, 4, 'canceled', '2024-11-05 12:41:52.228428+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (530, 4, 'pending', '2024-11-05 12:42:14.924788+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (531, 4, 'canceled', '2024-11-05 12:42:19.49317+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (532, 4, 'pending', '2024-11-05 12:43:12.533183+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (533, 4, 'canceled', '2024-11-05 12:43:16.851999+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (534, 1, 'canceled', '2024-11-05 12:44:11.279289+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (535, 4, 'pending', '2024-11-05 12:44:21.532791+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (536, 4, 'canceled', '2024-11-05 12:44:28.720115+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (537, 4, 'pending', '2024-11-05 12:44:34.294371+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (538, 4, 'canceled', '2024-11-05 12:44:39.848662+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (539, 39, 'pending', '2024-11-05 13:02:07.637308+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (540, 39, 'canceled', '2024-11-05 13:09:14.269008+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (541, 39, 'canceled', '2024-11-05 13:10:27.81043+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (542, 39, 'canceled', '2024-11-05 13:10:43.041307+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (543, 38, 'canceled', '2024-11-05 13:32:55.483617+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (544, 38, 'canceled', '2024-11-05 13:36:26.099832+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (545, 4, 'canceled', '2024-11-05 13:49:39.441047+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (546, 4, 'canceled', '2024-11-05 14:42:03.64858+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (547, 4, 'canceled', '2024-11-05 14:43:59.602448+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (548, 4, 'canceled', '2024-11-05 14:45:05.094887+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (549, 40, 'pending', '2024-11-05 15:32:54.204331+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (550, 4, 'canceled', '2024-11-05 15:48:13.565399+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (551, 4, 'canceled', '2024-11-05 15:54:30.041661+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (552, 35, 'canceled', '2024-11-05 15:54:30.440218+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (553, 4, 'canceled', '2024-11-05 15:56:58.383039+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (554, 35, 'canceled', '2024-11-05 15:56:58.761469+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (555, 40, 'processing', '2024-11-05 15:57:29.622442+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (556, 4, 'canceled', '2024-11-05 15:58:20.724781+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (558, 39, 'inChina', '2024-11-06 10:22:56.834022+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (559, 39, 'processing', '2024-11-06 10:24:06.082804+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (560, 37, 'processing', '2024-11-06 10:24:06.093053+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (561, 38, 'processing', '2024-11-06 10:24:06.097953+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (562, 6, 'processing', '2024-11-06 10:24:06.104183+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (563, 35, 'processing', '2024-11-06 10:24:06.111448+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (565, 17, 'processing', '2024-11-06 10:24:06.124135+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (566, 36, 'processing', '2024-11-06 10:24:06.248217+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (567, 19, 'processing', '2024-11-06 10:24:06.297635+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (568, 18, 'processing', '2024-11-06 10:24:06.301823+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (569, 20, 'processing', '2024-11-06 10:24:06.317897+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (570, 22, 'processing', '2024-11-06 10:24:06.332881+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (571, 38, 'withShipmentCompany', '2024-11-06 10:25:02.981159+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (572, 37, 'withShipmentCompany', '2024-11-06 10:25:02.989634+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (574, 36, 'withShipmentCompany', '2024-11-06 10:25:03.012867+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (575, 17, 'withShipmentCompany', '2024-11-06 10:25:03.017356+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (576, 18, 'withShipmentCompany', '2024-11-06 10:25:03.02409+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (577, 22, 'withShipmentCompany', '2024-11-06 10:25:03.025085+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (578, 39, 'withShipmentCompany', '2024-11-06 10:25:03.038488+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (579, 35, 'withShipmentCompany', '2024-11-06 10:25:03.160967+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (580, 19, 'withShipmentCompany', '2024-11-06 10:25:03.169801+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (581, 20, 'withShipmentCompany', '2024-11-06 10:25:03.178288+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (582, 6, 'withShipmentCompany', '2024-11-06 10:25:03.179575+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (584, 39, 'processing', '2024-11-06 10:48:18.59395+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (557, 40, 'inChina', '2024-11-05 15:58:21.217437+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (564, 40, 'inTransit', '2024-11-06 10:24:06.121659+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (573, 40, 'inSaudi', '2024-11-06 10:25:03.009801+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (583, 40, 'withShipmentCompany', '2024-11-06 10:29:09.334574+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (585, 41, 'pending', '2024-11-07 09:10:01.087356+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (586, 41, 'processing', '2024-11-07 09:10:56.583713+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (587, 41, 'inChina', '2024-11-07 09:11:04.07787+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (588, 41, 'inSaudi', '2024-11-07 09:11:08.82881+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (589, 41, 'withShipmentCompany', '2024-11-07 09:11:13.249614+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (590, 42, 'pending', '2024-11-07 09:12:56.192002+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (591, 41, 'withShipmentCompany', '2024-11-07 09:23:11.175905+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (592, 42, 'processing', '2024-11-07 12:20:05.227334+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (593, 43, 'pending', '2024-11-08 00:27:51.24595+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (595, 44, 'pending', '2024-11-08 00:29:18.372835+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (596, 44, 'processing', '2024-11-08 00:52:45.641122+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (597, 44, 'inChina', '2024-11-08 00:52:52.366378+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (598, 44, 'inSaudi', '2024-11-08 00:52:55.935632+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (599, 44, 'completed', '2024-11-08 00:53:00.568882+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (600, 45, 'pending', '2024-11-08 08:26:47.436752+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (601, 45, 'processing', '2024-11-08 08:27:24.72817+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (603, 45, 'canceled', '2024-11-08 08:31:33.106287+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (604, 45, 'inChina', '2024-11-08 08:32:12.043896+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (605, 46, 'pending', '2024-11-13 11:11:24.704934+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (606, 46, 'processing', '2024-11-13 11:12:41.327406+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (607, 46, 'inChina', '2024-11-13 11:12:51.285379+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (608, 46, 'inTransit', '2024-11-13 11:13:00.66847+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (609, 46, 'inSaudi', '2024-11-13 11:13:43.092783+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (610, 46, 'withShipmentCompany', '2024-11-13 11:14:16.18022+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (611, 46, 'completed', '2024-11-13 11:14:22.349736+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (612, 47, 'pending', '2024-11-13 11:19:29.436626+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (613, 48, 'pending', '2024-11-13 11:27:40.339498+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (614, 48, 'processing', '2024-11-13 11:28:54.072869+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (615, 48, 'inChina', '2024-11-13 11:29:16.097997+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (616, 48, 'inChina', '2024-11-13 11:29:19.417812+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (617, 48, 'inChina', '2024-11-13 11:29:19.424883+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (618, 48, 'inChina', '2024-11-13 11:29:26.505032+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (619, 48, 'inChina', '2024-11-13 11:29:26.558208+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (620, 48, 'inChina', '2024-11-13 11:29:27.16383+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (621, 48, 'inChina', '2024-11-13 11:29:27.39525+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (622, 48, 'inChina', '2024-11-13 11:29:27.601723+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (623, 48, 'inChina', '2024-11-13 11:29:27.753308+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (624, 48, 'inChina', '2024-11-13 11:29:27.952834+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (625, 48, 'inChina', '2024-11-13 11:29:28.025623+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (626, 48, 'inChina', '2024-11-13 11:29:28.203756+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (627, 48, 'inChina', '2024-11-13 11:29:28.334936+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (628, 48, 'inChina', '2024-11-13 11:29:28.537882+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (629, 48, 'inChina', '2024-11-13 11:29:28.711583+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (630, 48, 'inChina', '2024-11-13 11:29:28.781991+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (631, 48, 'inChina', '2024-11-13 11:29:28.967739+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (632, 48, 'inChina', '2024-11-13 11:29:29.142322+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (633, 48, 'inChina', '2024-11-13 11:29:29.395178+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (634, 48, 'inChina', '2024-11-13 11:29:37.345539+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (635, 48, 'inChina', '2024-11-13 11:29:37.3503+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (636, 48, 'inChina', '2024-11-13 11:29:37.494512+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (637, 48, 'inChina', '2024-11-13 11:29:37.8092+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (638, 48, 'inChina', '2024-11-13 11:29:37.813704+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (641, 48, 'inChina', '2024-11-13 11:29:38.28053+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (644, 48, 'inTransit', '2024-11-13 11:29:47.40825+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (647, 48, 'completed', '2024-11-13 11:30:06.928538+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (639, 48, 'inChina', '2024-11-13 11:29:38.144195+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (643, 48, 'inChina', '2024-11-13 11:29:38.728788+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (646, 48, 'withShipmentCompany', '2024-11-13 11:30:02.733407+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (640, 48, 'inChina', '2024-11-13 11:29:38.222801+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (642, 48, 'inChina', '2024-11-13 11:29:38.55427+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (645, 48, 'inSaudi', '2024-11-13 11:29:52.780269+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (648, 49, 'pending', '2024-11-21 13:27:57.708952+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (649, 49, 'inChina', '2024-11-21 13:39:48.428369+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (650, 49, 'inTransit', '2024-11-21 13:39:55.104932+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (651, 50, 'pending', '2025-01-13 20:44:52.778256+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (652, 50, 'processing', '2025-01-13 20:45:29.765458+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (653, 50, 'inChina', '2025-01-13 20:45:42.778539+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (654, 50, 'inTransit', '2025-01-13 20:51:23.167073+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (655, 50, 'inSaudi', '2025-01-13 20:51:26.137308+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (656, 50, 'inSaudi', '2025-01-13 20:57:13.790951+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (657, 50, 'withShipmentCompany', '2025-01-13 20:57:18.602034+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (658, 50, 'withShipmentCompany', '2025-01-13 20:59:58.628106+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (659, 50, 'inSaudi', '2025-01-13 21:00:15.156402+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (660, 50, 'withShipmentCompany', '2025-01-13 21:00:19.584603+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (661, 50, 'withShipmentCompany', '2025-01-13 21:00:47.444711+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (662, 50, 'withShipmentCompany', '2025-01-13 21:04:31.943573+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (663, 50, 'withShipmentCompany', '2025-01-13 21:09:23.673365+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (664, 50, 'canceled', '2025-01-13 21:14:23.960352+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (665, 51, 'pending', '2025-01-13 21:24:42.793555+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (666, 51, 'processing', '2025-01-13 21:25:23.399878+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (667, 50, 'processing', '2025-01-13 21:25:23.403907+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (668, 50, 'inChina', '2025-01-13 21:25:26.526822+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (669, 51, 'inChina', '2025-01-13 21:25:26.528801+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (670, 51, 'inTransit', '2025-01-13 21:25:29.757196+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (671, 50, 'inTransit', '2025-01-13 21:25:29.765456+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (672, 50, 'inSaudi', '2025-01-13 21:25:33.252171+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (673, 51, 'inSaudi', '2025-01-13 21:25:33.252216+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (674, 51, 'withShipmentCompany', '2025-01-13 21:25:39.121147+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (675, 50, 'withShipmentCompany', '2025-01-13 21:25:39.145991+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (676, 50, 'completed', '2025-01-13 21:26:31.768056+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (677, 51, 'completed', '2025-01-13 21:26:31.802361+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (678, 49, 'inChina', '2025-01-26 08:39:22.050478+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (679, 48, 'canceled', '2025-01-26 08:39:29.681264+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (680, 46, 'pending', '2025-01-26 08:39:34.023653+00');
INSERT INTO public.order_track (id, order_id, status, created_at) VALUES (681, 44, 'withShipmentCompany', '2025-01-26 08:39:38.673379+00');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 09:32:00.37074+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 09:32:00.37074+00', 'withShipmentCompany', '', '', 400, 4, 1, 38, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-02 11:21:42.782716+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-02 11:21:42.782716+00', 'withShipmentCompany', '', '', 800, 4, 2, 22, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-04 15:40:03.05046+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-04 15:40:03.05046+00', 'canceled', '', '', 70, 2, 1, 30, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-01 11:09:38.134586+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-01 11:09:38.134586+00', 'withShipmentCompany', '', '', 800, 4, 2, 6, 'تجربة', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-10-28 10:30:15.956385+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-10-28 10:30:15.956385+00', 'canceled', '', '', 2000, 1, 2, 1, 'tttt', NULL, 'failed');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 09:28:46.304007+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 09:28:46.304007+00', 'withShipmentCompany', '', '', 400, 4, 1, 37, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-02 10:40:46.273296+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-02 10:40:46.273296+00', 'withShipmentCompany', '', '', 800, 4, 2, 19, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-02 10:52:45.057331+00', 'e85e813c-af2c-4b82-b8b9-342bb3df7931', '2024-11-02 10:52:45.057331+00', 'completed', '', '', 800, 5, 2, 21, 'SSSS', 20, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-03 12:23:24.59598+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-03 12:23:24.59598+00', 'completed', '', '', 150, 5, 2, 24, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-02 10:43:01.718154+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-02 10:43:01.718154+00', 'withShipmentCompany', '', '', 800, 4, 2, 20, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 09:08:36.743776+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 09:08:36.743776+00', 'withShipmentCompany', '', '', 400, 4, 1, 35, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 08:18:45.598041+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 08:18:45.598041+00', 'withShipmentCompany', '', '', 40, 40, 1, 31, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 08:24:08.168846+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 08:24:08.168846+00', 'withShipmentCompany', '', '', 40, 40, 1, 32, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-02 17:21:07.833551+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-02 17:21:07.833551+00', 'completed', '', '', 150, 5, 2, 23, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-04 14:57:44.804082+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-04 14:57:44.804082+00', 'withShipmentCompany', '', '', 40, 40, 1, 29, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-02 10:22:44.420444+00', 'c0f27e29-2a1c-49e9-929f-551853264669', '2024-11-02 10:22:44.420444+00', 'withShipmentCompany', '', '', 800, 4, 2, 17, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-10-31 10:57:53.900607+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-10-31 10:57:53.900607+00', 'canceled', '', '', 100, 1, 2, 4, 'تجربة', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 08:24:26.172202+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 08:24:26.172202+00', 'withShipmentCompany', '', '', 40, 40, 1, 33, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-02 10:27:34.978015+00', 'c0f27e29-2a1c-49e9-929f-551853264669', '2024-11-02 10:27:34.978015+00', 'withShipmentCompany', '', '', 800, 4, 2, 18, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 09:22:37.788375+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 09:22:37.788375+00', 'withShipmentCompany', '', '', 400, 4, 1, 36, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 15:32:53.797563+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 15:32:53.797563+00', 'pending', '', '', 400, 4, 1, 40, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 13:02:07.179218+00', 'c0f27e29-2a1c-49e9-929f-551853264669', '2024-11-05 13:02:07.179218+00', 'processing', '', '', 400, 4, 1, 39, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-01 11:20:59.029317+00', 'c0f27e29-2a1c-49e9-929f-551853264669', '2024-11-01 11:20:59.029317+00', 'completed', '', '', 150, 5, 2, 7, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-08 08:26:47.022583+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-08 08:26:47.022583+00', 'inChina', '', '', 18, 48, 1, 45, 'الرياض', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-07 09:10:00.697436+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-07 09:10:00.697436+00', 'withShipmentCompany', '', '', 24, 38, 1, 41, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-07 09:12:55.852899+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-07 09:12:55.852899+00', 'processing', '', '', 190, 47, 1, 42, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-04 08:16:10.158845+00', 'c0f27e29-2a1c-49e9-929f-551853264669', '2024-11-04 08:16:10.158845+00', 'canceled', '', '', 150, 5, 2, 28, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-03 12:34:22.097362+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-03 12:34:22.097362+00', 'inTransit', '', '', 150, 5, 2, 26, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-03 12:29:51.283849+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-03 12:29:51.283849+00', 'inSaudi', '', '', 150, 5, 2, 25, 'تاروت', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-03 13:27:58.016387+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-03 13:27:58.016387+00', 'canceled', '', '', 150, 5, 2, 27, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-10-31 10:41:30.707903+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-10-31 10:41:30.707903+00', 'canceled', '', '', 50, 1, 1, 2, 'تجربة', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-10-31 10:48:32.091609+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-10-31 10:48:32.091609+00', 'canceled', '', '', 50, 1, 2, 3, 'تجربة', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-05 08:44:19.21631+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-05 08:44:19.21631+00', 'canceled', '', '', 90000, 42, 100, 34, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-08 00:27:50.852844+00', 'c1c97c12-c067-48a2-a0cd-eb05e375157e', '2024-11-08 00:27:50.852844+00', 'canceled', '', '', 190, 47, 1, 43, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-13 11:19:29.094326+00', 'b4103210-0cbc-41b4-9c6d-4a42e439db37', '2024-11-13 11:19:29.094326+00', 'pending', '', '', 190, 47, 1, 47, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-10-31 11:54:45.007654+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-10-31 11:54:45.007654+00', 'inChina', '', '', 100, 1, 2, 5, 'تجربة', NULL, 'failed');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2025-01-13 21:24:42.466303+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2025-01-13 21:24:42.466303+00', 'completed', '', '', 1700, 50, 1, 51, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2025-01-13 20:44:52.413534+00', '02131ef3-4e53-4df0-8319-a2e07c3db940', '2025-01-13 20:44:52.413534+00', 'completed', '', '', 1700, 50, 1, 50, 'الدمام', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-21 13:27:57.053523+00', '83efec21-2fc7-416e-9825-a86a8af3a63a', '2024-11-21 13:27:57.053523+00', 'inChina', '', '', 75, 44, 1, 49, 'الأحساء', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-13 11:27:40.023085+00', 'b4103210-0cbc-41b4-9c6d-4a42e439db37', '2024-11-13 11:27:40.023085+00', 'canceled', '', '', 24, 38, 1, 48, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-13 11:11:24.417443+00', 'b4103210-0cbc-41b4-9c6d-4a42e439db37', '2024-11-13 11:11:24.417443+00', 'pending', '', '', 100, 1, 2, 46, 'Dammam', NULL, 'paid');
INSERT INTO public.orders (created_at, user_id, order_date, order_status, tracking_number, tracking_company, amount, deal_id, quantity, order_id, address, payment_id, payment_status) VALUES ('2024-11-08 00:29:18.041847+00', 'c1c97c12-c067-48a2-a0cd-eb05e375157e', '2024-11-08 00:29:18.041847+00', 'withShipmentCompany', '', '', 75, 43, 1, 44, 'Dammam', NULL, 'paid');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '4a001953-14ba-45a9-a0b2-c2c54c5f6d84', 50, '2024-10-31 10:20:27.139893+00', 1, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '15d9f103-f073-412d-a6e8-5de4213063d9', 50, '2024-10-31 10:41:30.404344+00', 2, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '0a66ee88-5666-4564-af80-8f96388325a1', 50, '2024-10-31 10:48:31.882996+00', 3, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '2496020b-026e-4c3b-bcd1-a5f6675e4b30', 100, '2024-10-31 10:57:53.707363+00', 4, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'd5dfcfd8-f779-4b04-891b-a011132e7ed5', 100, '2024-10-31 11:54:44.725305+00', 5, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'b21c46e3-9092-4b09-a1c7-2d82d9453ad8', 800, '2024-11-01 11:09:37.910727+00', 6, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '86f45949-e70b-45a9-9e37-25a552ee4f5d', 150, '2024-11-01 11:20:58.688214+00', 7, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'cb889af5-ad1a-4cdc-9260-5ff270bdb17e', 150, '2024-11-01 15:51:24.347894+00', 8, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'f0bf23f4-fe2e-4099-b18d-bbc0593e397c', 800, '2024-11-01 16:51:34.816497+00', 9, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '4ae0b92d-878f-4dc3-9669-a9955be2a087', 800, '2024-11-01 17:15:31.639615+00', 10, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '8282f601-02e9-4fef-b9de-b6c114533c5f', 800, '2024-11-01 17:17:02.565583+00', 11, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '2ef3e001-f662-47b5-9c57-9ff1f1e9b58b', 800, '2024-11-01 17:30:13.110991+00', 12, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '5077cfaf-09ec-45aa-9753-fbf5dd30a6c5', 800, '2024-11-01 17:32:23.858945+00', 13, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '89abd009-5beb-418e-819c-e3db09f7499c', 150, '2024-11-01 18:04:25.694875+00', 14, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'd1212903-aa7a-402d-9cac-860ad13effa7', 150, '2024-11-01 19:46:16.436037+00', 15, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '56eeb5d6-b946-429f-ae3d-b4eaec46aaf3', 800, '2024-11-01 19:51:07.882601+00', 16, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'd0d42637-d9a8-433f-a59c-5818bbb42dcc', 800, '2024-11-02 10:22:43.761356+00', 17, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '66339cd5-dbc1-4ff7-9ff7-365a27d6510e', 800, '2024-11-02 10:27:34.724514+00', 18, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '27cd4e8c-d1fa-4f0e-a386-b5797f7ec5df', 800, '2024-11-02 10:40:45.455313+00', 19, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '45febb39-9e79-4e76-9fb1-c9378bf4519c', 800, '2024-11-02 10:43:01.496432+00', 20, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '9ea6a673-a033-4f5c-b3f3-61e492bda964', 800, '2024-11-02 11:21:42.233604+00', 21, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'bb9ad8d0-b444-4a0b-b408-5e6852b4b67d', 150, '2024-11-02 17:21:07.419472+00', 22, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '95a41aed-fb49-4b4e-a1c0-aeabf3de6d61', 150, '2024-11-03 12:23:24.400818+00', 23, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '8d439c90-5443-4d20-bf4f-b4ef2880b922', 150, '2024-11-03 12:29:51.016628+00', 24, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'f59b3157-2b50-41cd-828a-d6e18d64e35d', 150, '2024-11-03 12:34:21.870541+00', 25, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'e9cd1dfa-61e5-41ac-be51-52d26ed633fc', 150, '2024-11-03 13:27:57.766724+00', 26, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'd7998565-59c7-4f56-95b4-76da33eaf1ba', 150, '2024-11-04 08:16:09.844757+00', 27, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'fb734493-8a1c-405d-b92e-e5ae53d5d4ea', 40, '2024-11-04 14:57:44.5755+00', 28, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '6f54e3fb-7a7c-4652-af94-cd81517f27f0', 70, '2024-11-04 15:40:02.802637+00', 29, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'fc94e3ef-6679-4aa6-92e7-234d21a06ecc', 40, '2024-11-05 08:18:45.428015+00', 30, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'a93f220d-7cb2-43ea-a713-ab3ebdebe9be', 40, '2024-11-05 08:24:07.999478+00', 31, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'c74c7d3e-ae2c-4f94-9ca5-4b18ee1a3b52', 40, '2024-11-05 08:24:25.947335+00', 32, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'dc31adc2-8702-4005-a383-5cafb41c7299', 90000, '2024-11-05 08:44:19.063531+00', 33, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'f3e129dd-db47-4f05-bc57-b3383d4af3ac', 400, '2024-11-05 09:08:36.575054+00', 34, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'c4bc849a-388c-4000-a6c9-eb4f345266f4', 400, '2024-11-05 09:22:37.55992+00', 35, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '17436162-61f6-455c-a424-22009c4d187e', 400, '2024-11-05 09:28:46.098403+00', 36, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '1aad71cb-218f-4bf0-9321-54d370e393db', 400, '2024-11-05 09:32:00.16651+00', 37, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '43b004d9-2eb9-408b-b8ad-ea6da9bd22b0', 400, '2024-11-05 13:02:06.953277+00', 38, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'cf087963-5f3c-456d-ba74-1a369956790a', 400, '2024-11-05 15:32:53.61364+00', 39, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '1cd191bd-edcd-419a-8f2e-0cb86abc7904', 24, '2024-11-07 09:10:00.446004+00', 40, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '28c21773-89aa-4b1f-883d-517a625c4ef7', 190, '2024-11-07 09:12:55.679841+00', 41, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'b86dc569-036e-4ea7-a619-205a799df212', 190, '2024-11-08 00:27:50.676128+00', 42, 'c1c97c12-c067-48a2-a0cd-eb05e375157e');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'b6dc3cf9-33e7-42d5-8a21-ed27434496da', 75, '2024-11-08 00:29:17.873432+00', 43, 'c1c97c12-c067-48a2-a0cd-eb05e375157e');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'ea8d985b-e2f1-4de3-b9c2-c086626555f1', 18, '2024-11-08 08:26:46.827871+00', 44, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'b3ee90a1-d244-4345-865c-9beb66193c0c', 100, '2024-11-13 11:11:24.248124+00', 45, 'b4103210-0cbc-41b4-9c6d-4a42e439db37');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '40cec9bc-7897-4a10-be54-9d4d444b5fc9', 190, '2024-11-13 11:19:28.944367+00', 46, 'b4103210-0cbc-41b4-9c6d-4a42e439db37');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '0d9f868d-7d60-4537-b4cc-8743c92a5370', 24, '2024-11-13 11:27:39.864236+00', 47, 'b4103210-0cbc-41b4-9c6d-4a42e439db37');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', 'a78fe238-ad0a-4ff0-9adf-d73f45872d7c', 75, '2024-11-21 13:27:56.797945+00', 48, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '9db201d9-2a18-4f44-8147-b86bca84361e', 1700, '2025-01-13 20:44:52.203592+00', 49, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.payments (payment_status, transaction_id, payment_amount, created_at, payment_id, user_id) VALUES ('paid', '7c5b6837-02a4-4dbc-90cc-8c017634c9ea', 1700, '2025-01-13 21:24:42.296026+00', 50, '83efec21-2fc7-416e-9825-a86a8af3a63a');
INSERT INTO public.product_images (id, product_id, created_at, image_url) VALUES (4, 25, '2024-11-07 08:02:59.358789+00', 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/a6cb2a6cd4e241cf586979cb56867167ad4fc605_622722_1-removebg-preview.png');
INSERT INTO public.product_images (id, product_id, created_at, image_url) VALUES (5, 25, '2024-11-07 08:03:16.394253+00', 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/Xiaomi-Smart-Band-8_-Gold-removebg-preview.png');
INSERT INTO public.product_images (id, product_id, created_at, image_url) VALUES (6, 25, '2024-11-07 08:03:34.047581+00', 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/0c282502c64cabc354419501c18afaac81049fd2_622722_3-removebg-preview.png');
INSERT INTO public.product_images (id, product_id, created_at, image_url) VALUES (7, 26, '2024-11-07 08:12:45.150856+00', 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/41K4KvjnSjL-removebg-preview.png');
INSERT INTO public.product_images (id, product_id, created_at, image_url) VALUES (8, 27, '2024-11-07 08:51:18.596435+00', 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/table.png');
INSERT INTO public.product_images (id, product_id, created_at, image_url) VALUES (9, 29, '2024-11-08 01:00:59.721233+00', 'https://wlyfdviatwriuwfzjukr.supabase.co/storage/v1/object/public/images/2024_11_08T04_00_57_774987');
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('keyboard', 'hi', 0, 30, 30, 30, '2024-10-28 08:44:02.731867+00', NULL, NULL, NULL, 2, 2, 'xlM', 0);
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('cloth', 'hi', 0, 20, 20, 20, '2024-11-01 16:16:29.905652+00', NULL, NULL, NULL, 3, 1, 'gcvhvhv', 20);
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('camera', 'جهاز مبتكر يجمع بين الأداء العالي والتصميم الأنيق، مزود بشاشة عالية الدقة وتقنيات متطورة لتلبية جميع احتياجاتك اليومية. يتميز ببطارية تدوم طويلاً، مما يمنحك تجربة استخدام سلسة طوال اليوم. خيار مثالي لعشاق التقنية الذين يبحثون عن الجودة والفعالية.', 0, 12, 12, 12, '2024-10-27 09:21:23.886045+00', NULL, NULL, NULL, 1, 1, 'a3xreg', 0);
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('سمارت باند', 'الشاشة - 1.62 بوصة أموليد، 490 × 192 بيكسل، 326 نقطة في البوصة، 60 هرتز', 20, 490, 192, 10, '2024-11-07 07:59:26.633492+00', NULL, NULL, NULL, 25, 4, ' BHR7165GL', 250);
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('سماعة لاسلكية', 'سماعات اذن لاسلكية LP40 برو من لينوفو', 20, 20, 10, 10, '2024-11-07 08:11:16.259011+00', NULL, NULL, NULL, 26, 4, 'LP40 ', 20);
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('طاولة', 'طاولة منزل', 90, 50, 30, 30, '2024-11-07 08:50:59.006004+00', NULL, NULL, NULL, 27, 4, 'AD0LX56', 500);
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('t shirts', 'hi', 0, 20, 20, 20, '2024-11-01 16:44:18.267146+00', NULL, NULL, NULL, 24, 1, 'gcvhvhv', 5);
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('white t shirt', 'white t shirt', 0, 10, 10, 50, '2024-11-08 00:50:32.066434+00', NULL, NULL, NULL, 28, 6, 'fv128', 10);
INSERT INTO public.products (product_name, product_description, default_price, length, width, height, created_at, updated_at, created_by, updated_by, product_id, factory_id, model_number, weight) VALUES ('smart watch', 'smart watch', 0, 25, 25, 2, '2024-11-08 01:00:57.628248+00', NULL, NULL, NULL, 29, 4, 'dfg14Ax', 10);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('9be7e878-bb7d-4c0e-b5b2-a3b61371b2e3', 'mahdi alhelal', 'mmahdi630+3@gmail.com', 0541067293, '', 0.0, 'active', 'user', '2024-11-04 18:26:46.139883+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('ccd00084-e977-471b-8331-9e68ca8a43f9', 'mahdi alhelal', 'mmahdi630+5@gmail.com', 0500000000, '', 0.0, 'blocked', 'user', '2024-11-06 09:25:07.378726+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('c0f27e29-2a1c-49e9-929f-551853264669', 'mahdi', 'mmahdi630@gmail.com', 0500000000, '', 0.0, 'active', 'user', '2024-11-02 13:57:34.168198+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('83efec21-2fc7-416e-9825-a86a8af3a63a', 'ali', 'tarooti14@gmail.com', 0500000000, '', 3150.0, 'active', 'user', '2024-10-25 21:42:20.528746+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('223aa659-a50c-46fc-b03b-438a3fbf3311', 'ali ttt', 'tarooti14+3@gmail.com', 0500000000, '', 0.0, 'active', 'user', '2024-11-02 14:18:25.783384+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('1516f848-582b-4794-92e8-98ba928b8066', 'ali nnnmn', 'tarooti14+1@gmail.com', 0500000000, '', 0.0, 'active', 'user', '2024-11-02 14:11:51.482484+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('c1c97c12-c067-48a2-a0cd-eb05e375157e', 'mahdi', 'mahdithelal@gmail.com', 0500000001, '', 0.0, 'active', 'user', '2024-11-07 11:28:58.846935+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('54514bc8-3722-4d87-b20e-5b9c4f9a5659', 'aziz', 'azooz.n40@hotmail.com', 0500000000, '', 0.0, 'blocked', 'user', '2024-11-05 10:36:05.307213+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('e85e813c-af2c-4b82-b8b9-342bb3df7931', 'ali trt', 'tarooti14dev@gmail.com', 0500000000, '', 0.0, 'blocked', 'user', '2024-11-02 13:33:24.981067+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('b4103210-0cbc-41b4-9c6d-4a42e439db37', 'hatem', 'alsalmanhatem@gmail.com', 0507003759, '', 0.0, 'active', 'user', '2024-11-13 10:21:18.36778+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('4b4c28e6-c69b-4bcf-ab35-3ecaf81353cb', 'alit rr', 'xsw99.tar@gmail.com', 0597555447, '', 0.0, 'active', 'user', '2024-11-02 12:32:41.932326+00', NULL);
INSERT INTO public.users (user_id, full_name, email, phone, profile_url, balance, user_status, role, created_at, updated_at) VALUES ('02131ef3-4e53-4df0-8319-a2e07c3db940', 'nnnaba', 'tarooti14+2@gmail.com', 0500000000, '', 0.0, 'blocked', 'user', '2024-11-02 14:14:34.241696+00', NULL);
CREATE TRIGGER trigger_complete_deal AFTER UPDATE OF number_of_order ON public.deals FOR EACH ROW WHEN (((new.number_of_order = new.quantity) AND (new.deal_status = 'active'::public.deal_status))) EXECUTE FUNCTION public.complete_deal();
