-- 1. Schema Restore Script
-- Drops all existing public schema objects and recreates them

-- Drop existing objects in reverse dependency order
DROP TRIGGER IF EXISTS trigger_complete_deal ON public.deals CASCADE;
DROP FUNCTION IF EXISTS public.complete_deal() CASCADE;
DROP TABLE IF EXISTS public.address CASCADE;
DROP TABLE IF EXISTS public.categories CASCADE;
DROP TABLE IF EXISTS public.deal_images CASCADE;
DROP TABLE IF EXISTS public.deals CASCADE;
DROP TABLE IF EXISTS public.factories CASCADE;
DROP TABLE IF EXISTS public.order_track CASCADE;
DROP TABLE IF EXISTS public.orders CASCADE;
DROP TABLE IF EXISTS public.payments CASCADE;
DROP TABLE IF EXISTS public.product_images CASCADE;
DROP TABLE IF EXISTS public.products CASCADE;
DROP TABLE IF EXISTS public.transactions CASCADE;
DROP TABLE IF EXISTS public.users CASCADE;
DROP TYPE IF EXISTS public.deal_status CASCADE;
DROP TYPE IF EXISTS public.order_status CASCADE;
DROP TYPE IF EXISTS public.payment_status CASCADE;
DROP TYPE IF EXISTS public.user_role CASCADE;
DROP TYPE IF EXISTS public.user_status CASCADE;

-- Create Enums
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

-- Create Functions
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

-- Create Tables
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
