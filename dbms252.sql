--
-- PostgreSQL database dump
--

\restrict Uco41RS0rzYTAjcUPeZIeoveJPaASeotac7kXWO6lRdQrd0doVbcyBx5s55Baob

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2026-04-13 21:43:43

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 17252)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 5559 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1066 (class 1247 OID 18152)
-- Name: contacts_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.contacts_status_enum AS ENUM (
    'new',
    'in_progress',
    'resolved',
    'closed'
);


ALTER TYPE public.contacts_status_enum OWNER TO postgres;

--
-- TOC entry 961 (class 1247 OID 17582)
-- Name: designs_license_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.designs_license_type_enum AS ENUM (
    'standard',
    'premium',
    'exclusive'
);


ALTER TYPE public.designs_license_type_enum OWNER TO postgres;

--
-- TOC entry 964 (class 1247 OID 17590)
-- Name: designs_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.designs_status_enum AS ENUM (
    'pending',
    'approved',
    'rejected',
    'draft'
);


ALTER TYPE public.designs_status_enum OWNER TO postgres;

--
-- TOC entry 1078 (class 1247 OID 18260)
-- Name: employees_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.employees_role_enum AS ENUM (
    'admin',
    'manager',
    'staff',
    'designer'
);


ALTER TYPE public.employees_role_enum OWNER TO postgres;

--
-- TOC entry 1015 (class 1247 OID 17896)
-- Name: orders_paymentstatus_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.orders_paymentstatus_enum AS ENUM (
    'pending',
    'completed',
    'failed'
);


ALTER TYPE public.orders_paymentstatus_enum OWNER TO postgres;

--
-- TOC entry 1012 (class 1247 OID 17884)
-- Name: orders_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.orders_status_enum AS ENUM (
    'pending',
    'processing',
    'shipped',
    'delivered',
    'cancelled'
);


ALTER TYPE public.orders_status_enum OWNER TO postgres;

--
-- TOC entry 991 (class 1247 OID 17784)
-- Name: payment_methods_method_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_methods_method_enum AS ENUM (
    'credit_card',
    'debit_card',
    'paypal',
    'bank_transfer',
    'cash_on_delivery'
);


ALTER TYPE public.payment_methods_method_enum OWNER TO postgres;

--
-- TOC entry 994 (class 1247 OID 17796)
-- Name: payment_methods_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_methods_status_enum AS ENUM (
    'active',
    'inactive',
    'expired'
);


ALTER TYPE public.payment_methods_status_enum OWNER TO postgres;

--
-- TOC entry 1000 (class 1247 OID 17821)
-- Name: payments_payment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payments_payment_status_enum AS ENUM (
    'pending',
    'completed',
    'failed',
    'refunded'
);


ALTER TYPE public.payments_payment_status_enum OWNER TO postgres;

--
-- TOC entry 1006 (class 1247 OID 17852)
-- Name: return_requests_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.return_requests_status_enum AS ENUM (
    'pending',
    'approved',
    'rejected',
    'processing',
    'completed'
);


ALTER TYPE public.return_requests_status_enum OWNER TO postgres;

--
-- TOC entry 1060 (class 1247 OID 18123)
-- Name: reward_catalog_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.reward_catalog_type_enum AS ENUM (
    'voucher',
    'discount',
    'free_product',
    'free_shipping'
);


ALTER TYPE public.reward_catalog_type_enum OWNER TO postgres;

--
-- TOC entry 1054 (class 1247 OID 18088)
-- Name: reward_points_source_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.reward_points_source_enum AS ENUM (
    'purchase',
    'eco_product_bonus',
    'review',
    'referral',
    'welcome_bonus',
    'admin_adjustment',
    'voucher_redemption'
);


ALTER TYPE public.reward_points_source_enum OWNER TO postgres;

--
-- TOC entry 1051 (class 1247 OID 18081)
-- Name: reward_points_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.reward_points_type_enum AS ENUM (
    'earned',
    'redeemed',
    'expired'
);


ALTER TYPE public.reward_points_type_enum OWNER TO postgres;

--
-- TOC entry 982 (class 1247 OID 17729)
-- Name: shipments_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shipments_status_enum AS ENUM (
    'pending',
    'processing',
    'shipped',
    'in_transit',
    'delivered',
    'returned'
);


ALTER TYPE public.shipments_status_enum OWNER TO postgres;

--
-- TOC entry 1081 (class 1247 OID 18272)
-- Name: stock_movements_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.stock_movements_type_enum AS ENUM (
    'inbound',
    'outbound',
    'reserve',
    'release',
    'adjust'
);


ALTER TYPE public.stock_movements_type_enum OWNER TO postgres;

--
-- TOC entry 1036 (class 1247 OID 18016)
-- Name: user_vouchers_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_vouchers_status_enum AS ENUM (
    'available',
    'used',
    'expired'
);


ALTER TYPE public.user_vouchers_status_enum OWNER TO postgres;

--
-- TOC entry 1030 (class 1247 OID 17989)
-- Name: users_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.users_role_enum AS ENUM (
    'user',
    'admin'
);


ALTER TYPE public.users_role_enum OWNER TO postgres;

--
-- TOC entry 1045 (class 1247 OID 18048)
-- Name: vouchers_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.vouchers_status_enum AS ENUM (
    'active',
    'inactive',
    'expired'
);


ALTER TYPE public.vouchers_status_enum OWNER TO postgres;

--
-- TOC entry 1042 (class 1247 OID 18040)
-- Name: vouchers_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.vouchers_type_enum AS ENUM (
    'percentage',
    'fixed_amount',
    'free_shipping'
);


ALTER TYPE public.vouchers_type_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 243 (class 1259 OID 17689)
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    addr_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    label character varying(100) NOT NULL,
    line1 character varying(255) NOT NULL,
    line2 character varying(255),
    state character varying(100) NOT NULL,
    zip character varying(20) NOT NULL,
    country character varying(100) NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17437)
-- Name: asset_disposals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.asset_disposals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "assetId" uuid NOT NULL,
    "disposedBy" uuid,
    reason character varying(255) NOT NULL,
    note character varying(500),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.asset_disposals OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17420)
-- Name: assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.assets (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(500) NOT NULL,
    "mimeType" character varying(100),
    "sizeBytes" integer,
    "isActive" boolean DEFAULT true NOT NULL,
    "uploadedBy" uuid,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.assets OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17526)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "cartId" uuid NOT NULL,
    "productId" uuid NOT NULL,
    "colorCode" character varying(20),
    "designId" uuid,
    qty integer NOT NULL,
    unit_price_snapshot numeric(10,2) NOT NULL,
    "customDesignData" jsonb,
    "sizeCode" character varying(100),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17507)
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "totalAmount" numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    "itemCount" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17456)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    image character varying(500),
    "parentId" uuid,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17546)
-- Name: color_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.color_options (
    "ColorCode" character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    hex character varying(7) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.color_options OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 18161)
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid,
    name character varying NOT NULL,
    email character varying NOT NULL,
    phone character varying,
    subject character varying NOT NULL,
    message text NOT NULL,
    status public.contacts_status_enum DEFAULT 'new'::public.contacts_status_enum NOT NULL,
    response character varying,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17474)
-- Name: design_assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.design_assets (
    "ASSET_ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "designId" uuid NOT NULL,
    file_url character varying(500) NOT NULL,
    mime character varying(100) NOT NULL,
    width_px integer,
    height_px integer,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.design_assets OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17491)
-- Name: design_placements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.design_placements (
    "PlacementID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "designId" uuid NOT NULL,
    "printMethodId" uuid NOT NULL,
    color_profile character varying(100),
    pos_x_cm numeric(8,2),
    pos_y_cm numeric(8,2),
    width_cm numeric(8,2),
    height_cm numeric(8,2),
    print_area character varying(100),
    notes text,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.design_placements OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17599)
-- Name: designs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.designs (
    "DESIGN_ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    license_type public.designs_license_type_enum DEFAULT 'standard'::public.designs_license_type_enum NOT NULL,
    design_tag character varying(255),
    preview_url character varying(500),
    approved_at timestamp without time zone,
    description text,
    submitted_at timestamp without time zone,
    status public.designs_status_enum DEFAULT 'draft'::public.designs_status_enum NOT NULL,
    title character varying(255) NOT NULL,
    downloads integer DEFAULT 0 NOT NULL,
    likes integer DEFAULT 0 NOT NULL,
    price numeric(10,2),
    "categoryId" uuid,
    stock integer DEFAULT 0 NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.designs OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 18180)
-- Name: employee_color_management; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_color_management (
    "employeeId" uuid NOT NULL,
    "colorCode" character varying(20) NOT NULL
);


ALTER TABLE public.employee_color_management OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17369)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    shift character varying(50) NOT NULL,
    salary numeric(10,2) NOT NULL,
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "taxID" character varying(50) NOT NULL,
    join_date date NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    role public.employees_role_enum DEFAULT 'staff'::public.employees_role_enum NOT NULL
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17955)
-- Name: favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorites (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "productId" uuid,
    "designId" uuid,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.favorites OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17969)
-- Name: invitation_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invitation_codes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "Code" character varying(50) NOT NULL,
    message text,
    "ownerId" uuid,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.invitation_codes OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17391)
-- Name: materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materials (
    name character varying(255) NOT NULL,
    stretchable boolean DEFAULT false NOT NULL,
    "MatID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    wash_care_rating integer,
    is_recycled boolean DEFAULT false NOT NULL,
    grammage_gsm integer,
    supplier character varying(255),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    composition text
);


ALTER TABLE public.materials OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17264)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17263)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 5560 (class 0 OID 0)
-- Dependencies: 220
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 246 (class 1259 OID 17764)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "orderId" uuid NOT NULL,
    "productId" uuid,
    "skuId" uuid NOT NULL,
    qty integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    "colorCode" character varying(20),
    "sizeCode" character varying(100),
    "designId" uuid,
    "customDesignData" jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17903)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "Status" public.orders_status_enum DEFAULT 'pending'::public.orders_status_enum NOT NULL,
    "Order_date" timestamp without time zone DEFAULT now() NOT NULL,
    "Subtotal" numeric(10,2) NOT NULL,
    "Discount" numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    "Total" numeric(10,2) NOT NULL,
    "shippingAddress" text NOT NULL,
    "paymentMethod" character varying(100) NOT NULL,
    "paymentStatus" public.orders_paymentstatus_enum DEFAULT 'pending'::public.orders_paymentstatus_enum NOT NULL,
    "trackingNumber" character varying(100),
    notes text,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17342)
-- Name: packagings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.packagings (
    "PKG_ID" uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    max_weight numeric(8,2) NOT NULL,
    cost numeric(10,2),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.packagings OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 17803)
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_methods (
    "MethodID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid,
    "MethodName" character varying(50),
    method public.payment_methods_method_enum NOT NULL,
    status public.payment_methods_status_enum DEFAULT 'active'::public.payment_methods_status_enum NOT NULL,
    card_no character varying(50),
    card_holder_name character varying(100),
    expiry_date character varying(10),
    is_default boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payment_methods OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17829)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    "PaymentID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "paymentMethodId" uuid NOT NULL,
    "orderId" uuid NOT NULL,
    amount numeric(10,2) NOT NULL,
    paid_at timestamp without time zone,
    payment_status public.payments_payment_status_enum DEFAULT 'pending'::public.payments_payment_status_enum NOT NULL,
    tax numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    txn_ref character varying(255),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17406)
-- Name: print_methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.print_methods (
    name character varying(255) NOT NULL,
    description text,
    "PM_ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    min_resolution_dpi integer,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.print_methods OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 18189)
-- Name: product_materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_materials (
    "materialId" uuid NOT NULL,
    "productId" uuid NOT NULL
);


ALTER TABLE public.product_materials OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17649)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    care_instructions text,
    design_areas text,
    "printArea" jsonb,
    price numeric(10,2) NOT NULL,
    "oldPrice" numeric(10,2),
    stock integer DEFAULT 0 NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    image character varying(500),
    images text DEFAULT '[]'::text NOT NULL,
    "categoryId" uuid NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "isNew" boolean DEFAULT false NOT NULL,
    "isFeatured" boolean DEFAULT false NOT NULL,
    "averageRating" numeric(3,2) DEFAULT '0'::numeric NOT NULL,
    rating numeric(3,2) DEFAULT '0'::numeric NOT NULL,
    "numReviews" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17355)
-- Name: return_reasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_reasons (
    description text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "Reason_code" character varying(50) NOT NULL
);


ALTER TABLE public.return_reasons OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17863)
-- Name: return_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_requests (
    "RET_ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "orderId" uuid NOT NULL,
    "reasonCode" character varying(50) NOT NULL,
    requested_at timestamp without time zone NOT NULL,
    refund_amount numeric(10,2) NOT NULL,
    status public.return_requests_status_enum DEFAULT 'pending'::public.return_requests_status_enum NOT NULL,
    approved_at timestamp without time zone,
    notes text,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.return_requests OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 17625)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    "REVIEW_ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "productId" uuid NOT NULL,
    "orderId" uuid,
    "designId" uuid,
    rating integer NOT NULL,
    comment text,
    media_url character varying(500),
    "isVerified" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 18131)
-- Name: reward_catalog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reward_catalog (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    type public.reward_catalog_type_enum NOT NULL,
    "pointsRequired" integer NOT NULL,
    description text,
    "discountValue" numeric(10,2),
    "minOrderAmount" numeric(10,2),
    "imageUrl" character varying(500),
    "isActive" boolean DEFAULT true NOT NULL,
    "redemptionCount" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reward_catalog OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 18103)
-- Name: reward_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reward_points (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "orderId" uuid,
    type public.reward_points_type_enum NOT NULL,
    source public.reward_points_source_enum NOT NULL,
    points integer NOT NULL,
    description text,
    "expiresAt" date,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.reward_points OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17932)
-- Name: saved_designs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_designs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "productId" uuid NOT NULL,
    "designId" uuid,
    name character varying(255) NOT NULL,
    "canvasData" jsonb NOT NULL,
    "colorCode" character varying(20) NOT NULL,
    "sizeCode" character varying(20) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    "calculatedPrice" numeric(10,2) NOT NULL,
    "previewUrl" character varying(500),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.saved_designs OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17326)
-- Name: shipment_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "shipmentId" uuid NOT NULL,
    "orderItemId" uuid NOT NULL,
    quantity integer NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.shipment_items OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17741)
-- Name: shipments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipments (
    "Ship_ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "orderId" uuid NOT NULL,
    "addressId" uuid NOT NULL,
    "packagingId" uuid NOT NULL,
    ship_date date,
    status public.shipments_status_enum DEFAULT 'pending'::public.shipments_status_enum NOT NULL,
    "Shipping_fee" numeric(10,2) NOT NULL,
    carrier character varying(100) NOT NULL,
    service_level character varying(100) NOT NULL,
    tracking_number character varying(100),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.shipments OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17381)
-- Name: sizes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sizes (
    "SizeCode" character varying(20) NOT NULL,
    chest_cm numeric(5,2),
    length_cm numeric(5,2),
    gender_fit character varying(20),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.sizes OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17560)
-- Name: sku_variants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sku_variants (
    "SkuID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "productId" uuid NOT NULL,
    "SizeCode" character varying(20) NOT NULL,
    "ColorCode" character varying(20) NOT NULL,
    price numeric(10,2) NOT NULL,
    weight_grams numeric(8,2),
    base_cost numeric(10,2),
    sku_name character varying(255) NOT NULL,
    avai_status character varying(50) DEFAULT 'available'::character varying NOT NULL,
    currency character varying(10) DEFAULT 'USD'::character varying NOT NULL,
    "designId" uuid,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.sku_variants OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17306)
-- Name: stock_movements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_movements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "stockId" uuid NOT NULL,
    type public.stock_movements_type_enum NOT NULL,
    quantity integer NOT NULL,
    "referenceType" character varying(255),
    "referenceId" character varying(255),
    note character varying(500),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.stock_movements OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17287)
-- Name: stocks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stocks (
    "StockID" uuid DEFAULT gen_random_uuid() NOT NULL,
    "skuId" uuid NOT NULL,
    qty_outbound integer DEFAULT 0 NOT NULL,
    qty_inbound integer DEFAULT 0 NOT NULL,
    qty_on_hand integer DEFAULT 0 NOT NULL,
    qty_reserved integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.stocks OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17711)
-- Name: track_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.track_events (
    "TrackID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "shipmentId" uuid NOT NULL,
    status_text character varying(255) NOT NULL,
    even_time timestamp without time zone NOT NULL,
    location character varying(255),
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.track_events OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 18023)
-- Name: user_vouchers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_vouchers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "voucherId" uuid NOT NULL,
    "orderId" uuid,
    status public.user_vouchers_status_enum DEFAULT 'available'::public.user_vouchers_status_enum NOT NULL,
    "usedAt" timestamp without time zone,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_vouchers OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17993)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    "UserID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    role public.users_role_enum DEFAULT 'user'::public.users_role_enum NOT NULL,
    phone character varying(20),
    dob date,
    image character varying(500),
    is_active boolean DEFAULT true NOT NULL,
    "invitationCodeString" character varying(50),
    "invitedById" uuid,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 18055)
-- Name: vouchers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vouchers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    code character varying(50) NOT NULL,
    type public.vouchers_type_enum NOT NULL,
    value numeric(10,2) NOT NULL,
    "minOrderAmount" numeric(10,2),
    "maxUses" integer,
    "usedCount" integer DEFAULT 0 NOT NULL,
    "maxUsesPerUser" integer,
    "validFrom" date NOT NULL,
    "validUntil" date NOT NULL,
    status public.vouchers_status_enum DEFAULT 'active'::public.vouchers_status_enum NOT NULL,
    "pointsRequired" integer,
    description text,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.vouchers OWNER TO postgres;

--
-- TOC entry 5037 (class 2604 OID 17267)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 5288 (class 2606 OID 17780)
-- Name: order_items PK_005269d8574e6fac0493715c308; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "PK_005269d8574e6fac0493715c308" PRIMARY KEY (id);


--
-- TOC entry 5272 (class 2606 OID 17684)
-- Name: products PK_0806c755e0aca124e67c0cf6d7d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "PK_0806c755e0aca124e67c0cf6d7d" PRIMARY KEY (id);


--
-- TOC entry 5237 (class 2606 OID 17471)
-- Name: categories PK_24dbc6126a28ff948da33e97d3b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "PK_24dbc6126a28ff948da33e97d3b" PRIMARY KEY (id);


--
-- TOC entry 5295 (class 2606 OID 17846)
-- Name: payments PK_30246df7f6b96672874fb248aa3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT "PK_30246df7f6b96672874fb248aa3" PRIMARY KEY ("PaymentID");


--
-- TOC entry 5242 (class 2606 OID 17489)
-- Name: design_assets PK_324b0ec04fd9c3b0d0acdab7dd9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.design_assets
    ADD CONSTRAINT "PK_324b0ec04fd9c3b0d0acdab7dd9" PRIMARY KEY ("ASSET_ID");


--
-- TOC entry 5266 (class 2606 OID 17644)
-- Name: reviews PK_395e0ddd06999a8cc815fe47e79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "PK_395e0ddd06999a8cc815fe47e79" PRIMARY KEY ("REVIEW_ID");


--
-- TOC entry 5347 (class 2606 OID 18195)
-- Name: product_materials PK_3b151b156b035177c2ae1a6ad15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_materials
    ADD CONSTRAINT "PK_3b151b156b035177c2ae1a6ad15" PRIMARY KEY ("materialId", "productId");


--
-- TOC entry 5255 (class 2606 OID 17559)
-- Name: color_options PK_44c337bb04c293193e7ffc790e6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.color_options
    ADD CONSTRAINT "PK_44c337bb04c293193e7ffc790e6" PRIMARY KEY ("ColorCode");


--
-- TOC entry 5326 (class 2606 OID 18037)
-- Name: user_vouchers PK_66534a148ba312dd88e48ee6072; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_vouchers
    ADD CONSTRAINT "PK_66534a148ba312dd88e48ee6072" PRIMARY KEY (id);


--
-- TOC entry 5258 (class 2606 OID 17579)
-- Name: sku_variants PK_67fac5d4bfe2f84031ba391b895; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sku_variants
    ADD CONSTRAINT "PK_67fac5d4bfe2f84031ba391b895" PRIMARY KEY ("SkuID");


--
-- TOC entry 5282 (class 2606 OID 17759)
-- Name: shipments PK_6a0f6e3f24aabaf374d6d148919; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT "PK_6a0f6e3f24aabaf374d6d148919" PRIMARY KEY ("Ship_ID");


--
-- TOC entry 5253 (class 2606 OID 17542)
-- Name: cart_items PK_6fccf5ec03c172d27a28a82928b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT "PK_6fccf5ec03c172d27a28a82928b" PRIMARY KEY (id);


--
-- TOC entry 5315 (class 2606 OID 17982)
-- Name: invitation_codes PK_707eabf9705bec823c436dfa264; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation_codes
    ADD CONSTRAINT "PK_707eabf9705bec823c436dfa264" PRIMARY KEY (id);


--
-- TOC entry 5305 (class 2606 OID 17928)
-- Name: orders PK_710e2d4957aa5878dfe94e4ac2f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "PK_710e2d4957aa5878dfe94e4ac2f" PRIMARY KEY (id);


--
-- TOC entry 5260 (class 2606 OID 17624)
-- Name: designs PK_7d4c372c8cea4893b285f750056; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.designs
    ADD CONSTRAINT "PK_7d4c372c8cea4893b285f750056" PRIMARY KEY ("DESIGN_ID");


--
-- TOC entry 5312 (class 2606 OID 17966)
-- Name: favorites PK_890818d27523748dd36a4d1bdc8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT "PK_890818d27523748dd36a4d1bdc8" PRIMARY KEY (id);


--
-- TOC entry 5321 (class 2606 OID 18012)
-- Name: users PK_897a8e0062b8cece58b6cff4e65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_897a8e0062b8cece58b6cff4e65" PRIMARY KEY ("UserID");


--
-- TOC entry 5229 (class 2606 OID 18206)
-- Name: print_methods PK_8bdb681b339f47a3e6c69615165; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.print_methods
    ADD CONSTRAINT "PK_8bdb681b339f47a3e6c69615165" PRIMARY KEY ("PM_ID");


--
-- TOC entry 5200 (class 2606 OID 17274)
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- TOC entry 5308 (class 2606 OID 17953)
-- Name: saved_designs PK_96bc4b5de7df51df2788fd9404a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_designs
    ADD CONSTRAINT "PK_96bc4b5de7df51df2788fd9404a" PRIMARY KEY (id);


--
-- TOC entry 5227 (class 2606 OID 18241)
-- Name: materials PK_975ac48b7894f1e23c7a3224400; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT "PK_975ac48b7894f1e23c7a3224400" PRIMARY KEY ("MatID");


--
-- TOC entry 5275 (class 2606 OID 17709)
-- Name: addresses PK_9814ef8441b0c8bab7a47f90a37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT "PK_9814ef8441b0c8bab7a47f90a37" PRIMARY KEY (addr_id);


--
-- TOC entry 5278 (class 2606 OID 17726)
-- Name: track_events PK_9e0e7e1c429c05ea5b9daff5324; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.track_events
    ADD CONSTRAINT "PK_9e0e7e1c429c05ea5b9daff5324" PRIMARY KEY ("TrackID");


--
-- TOC entry 5335 (class 2606 OID 18119)
-- Name: reward_points PK_b04907622cbfc5e492056cfc72c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reward_points
    ADD CONSTRAINT "PK_b04907622cbfc5e492056cfc72c" PRIMARY KEY (id);


--
-- TOC entry 5248 (class 2606 OID 17524)
-- Name: carts PK_b5f695a59f5ebb50af3c8160816; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT "PK_b5f695a59f5ebb50af3c8160816" PRIMARY KEY (id);


--
-- TOC entry 5219 (class 2606 OID 18221)
-- Name: employees PK_b9535a98350d5b26e7eb0c26af4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT "PK_b9535a98350d5b26e7eb0c26af4" PRIMARY KEY (id);


--
-- TOC entry 5339 (class 2606 OID 18179)
-- Name: contacts PK_b99cd40cfd66a99f1571f4f72e6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT "PK_b99cd40cfd66a99f1571f4f72e6" PRIMARY KEY (id);


--
-- TOC entry 5291 (class 2606 OID 17818)
-- Name: payment_methods PK_bdc959f7ad1a218a8ea3a607609; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT "PK_bdc959f7ad1a218a8ea3a607609" PRIMARY KEY ("MethodID");


--
-- TOC entry 5343 (class 2606 OID 18186)
-- Name: employee_color_management PK_c2037ec1799f2d25d6c079cc326; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_color_management
    ADD CONSTRAINT "PK_c2037ec1799f2d25d6c079cc326" PRIMARY KEY ("employeeId", "colorCode");


--
-- TOC entry 5337 (class 2606 OID 18150)
-- Name: reward_catalog PK_d78cab5082c8da41c748fe36189; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reward_catalog
    ADD CONSTRAINT "PK_d78cab5082c8da41c748fe36189" PRIMARY KEY (id);


--
-- TOC entry 5216 (class 2606 OID 18250)
-- Name: return_reasons PK_e8303e09fcfca38e72490696858; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_reasons
    ADD CONSTRAINT "PK_e8303e09fcfca38e72490696858" PRIMARY KEY ("Reason_code");


--
-- TOC entry 5329 (class 2606 OID 18076)
-- Name: vouchers PK_ed1b7dd909a696560763acdbc04; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT "PK_ed1b7dd909a696560763acdbc04" PRIMARY KEY (id);


--
-- TOC entry 5245 (class 2606 OID 17505)
-- Name: design_placements PK_f800a021f632ca7e95fc3ea7aeb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.design_placements
    ADD CONSTRAINT "PK_f800a021f632ca7e95fc3ea7aeb" PRIMARY KEY ("PlacementID");


--
-- TOC entry 5300 (class 2606 OID 17881)
-- Name: return_requests PK_ff2a7ae506dd31a7d637aac3eb6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_requests
    ADD CONSTRAINT "PK_ff2a7ae506dd31a7d637aac3eb6" PRIMARY KEY ("RET_ID");


--
-- TOC entry 5317 (class 2606 OID 17986)
-- Name: invitation_codes REL_946a5df42e6dbf2550115cbb8b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation_codes
    ADD CONSTRAINT "REL_946a5df42e6dbf2550115cbb8b" UNIQUE ("ownerId");


--
-- TOC entry 5284 (class 2606 OID 17761)
-- Name: shipments UQ_13ba957bcb616719a0dc3fca82f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT "UQ_13ba957bcb616719a0dc3fca82f" UNIQUE ("orderId");


--
-- TOC entry 5319 (class 2606 OID 17984)
-- Name: invitation_codes UQ_464711f4753834c3ec111ffb711; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation_codes
    ADD CONSTRAINT "UQ_464711f4753834c3ec111ffb711" UNIQUE ("Code");


--
-- TOC entry 5221 (class 2606 OID 18224)
-- Name: employees UQ_737991e10350d9626f592894cef; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT "UQ_737991e10350d9626f592894cef" UNIQUE ("userId");


--
-- TOC entry 5239 (class 2606 OID 17473)
-- Name: categories UQ_8b0be371d28245da6e4f4b61878; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "UQ_8b0be371d28245da6e4f4b61878" UNIQUE (name);


--
-- TOC entry 5323 (class 2606 OID 18014)
-- Name: users UQ_97672ac88f789774dd47f7c8be3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE (email);


--
-- TOC entry 5297 (class 2606 OID 17848)
-- Name: payments UQ_af929a5f2a400fdb6913b4967e1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT "UQ_af929a5f2a400fdb6913b4967e1" UNIQUE ("orderId");


--
-- TOC entry 5223 (class 2606 OID 18227)
-- Name: employees UQ_cd181ebbe6bf15fa9cbbc91a914; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT "UQ_cd181ebbe6bf15fa9cbbc91a914" UNIQUE ("taxID");


--
-- TOC entry 5331 (class 2606 OID 18078)
-- Name: vouchers UQ_efc30b2b9169e05e0e1e19d6dd6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT "UQ_efc30b2b9169e05e0e1e19d6dd6" UNIQUE (code);


--
-- TOC entry 5235 (class 2606 OID 17449)
-- Name: asset_disposals asset_disposals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_disposals
    ADD CONSTRAINT asset_disposals_pkey PRIMARY KEY (id);


--
-- TOC entry 5232 (class 2606 OID 17435)
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- TOC entry 5214 (class 2606 OID 17354)
-- Name: packagings packagings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.packagings
    ADD CONSTRAINT packagings_pkey PRIMARY KEY ("PKG_ID");


--
-- TOC entry 5212 (class 2606 OID 17339)
-- Name: shipment_items shipment_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_items
    ADD CONSTRAINT shipment_items_pkey PRIMARY KEY (id);


--
-- TOC entry 5225 (class 2606 OID 17390)
-- Name: sizes sizes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sizes
    ADD CONSTRAINT sizes_pkey PRIMARY KEY ("SizeCode");


--
-- TOC entry 5208 (class 2606 OID 17319)
-- Name: stock_movements stock_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_pkey PRIMARY KEY (id);


--
-- TOC entry 5203 (class 2606 OID 17302)
-- Name: stocks stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT stocks_pkey PRIMARY KEY ("StockID");


--
-- TOC entry 5205 (class 2606 OID 17304)
-- Name: stocks stocks_skuId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT "stocks_skuId_key" UNIQUE ("skuId");


--
-- TOC entry 5298 (class 1259 OID 17882)
-- Name: IDX_01853126105daa52caee638ab8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_01853126105daa52caee638ab8" ON public.return_requests USING btree ("orderId");


--
-- TOC entry 5301 (class 1259 OID 17929)
-- Name: IDX_01b20118a3f640214e7a8a6b29; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_01b20118a3f640214e7a8a6b29" ON public.orders USING btree ("paymentStatus");


--
-- TOC entry 5201 (class 1259 OID 18304)
-- Name: IDX_08d8d66a3c53115fa464d8c81a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_08d8d66a3c53115fa464d8c81a" ON public.stocks USING btree ("skuId");


--
-- TOC entry 5279 (class 1259 OID 17763)
-- Name: IDX_13ba957bcb616719a0dc3fca82; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_13ba957bcb616719a0dc3fca82" ON public.shipments USING btree ("orderId");


--
-- TOC entry 5302 (class 1259 OID 17931)
-- Name: IDX_151b79a83ba240b0cb31b2302d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_151b79a83ba240b0cb31b2302d" ON public.orders USING btree ("userId");


--
-- TOC entry 5209 (class 1259 OID 18305)
-- Name: IDX_2590a15118d9fef2d0f7793a8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_2590a15118d9fef2d0f7793a8b" ON public.shipment_items USING btree ("orderItemId");


--
-- TOC entry 5249 (class 1259 OID 17543)
-- Name: IDX_2bf7996b7946ce753b60a87468; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_2bf7996b7946ce753b60a87468" ON public.cart_items USING btree ("cartId", "productId");


--
-- TOC entry 5324 (class 1259 OID 18038)
-- Name: IDX_3194b155a5885f3267098bb4f8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_3194b155a5885f3267098bb4f8" ON public.user_vouchers USING btree ("userId", "voucherId");


--
-- TOC entry 5309 (class 1259 OID 17967)
-- Name: IDX_31fa9a16148e2aeb1118363a3f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_31fa9a16148e2aeb1118363a3f" ON public.favorites USING btree ("userId", "designId") WHERE ("productId" IS NULL);


--
-- TOC entry 5230 (class 1259 OID 18307)
-- Name: IDX_32efd6f12ff7a7c3026a03996a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_32efd6f12ff7a7c3026a03996a" ON public.assets USING btree ("uploadedBy");


--
-- TOC entry 5332 (class 1259 OID 18120)
-- Name: IDX_368d4b3067c85cb00fea060f2e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_368d4b3067c85cb00fea060f2e" ON public.reward_points USING btree ("orderId");


--
-- TOC entry 5267 (class 1259 OID 17686)
-- Name: IDX_3bc954b9e8a3a02e45106cac22; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_3bc954b9e8a3a02e45106cac22" ON public.products USING btree ("isNew");


--
-- TOC entry 5246 (class 1259 OID 17525)
-- Name: IDX_3fdcfeb19101d2b0b5adfa7d8a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_3fdcfeb19101d2b0b5adfa7d8a" ON public.carts USING btree ("userId", "isActive") WHERE ("isActive" = true);


--
-- TOC entry 5313 (class 1259 OID 17987)
-- Name: IDX_464711f4753834c3ec111ffb71; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_464711f4753834c3ec111ffb71" ON public.invitation_codes USING btree ("Code");


--
-- TOC entry 5261 (class 1259 OID 17646)
-- Name: IDX_53a68dc905777554b7f702791f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_53a68dc905777554b7f702791f" ON public.reviews USING btree ("orderId");


--
-- TOC entry 5289 (class 1259 OID 17819)
-- Name: IDX_580f1dbf7bceb9c2cde8baf7ff; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_580f1dbf7bceb9c2cde8baf7ff" ON public.payment_methods USING btree ("userId");


--
-- TOC entry 5256 (class 1259 OID 17580)
-- Name: IDX_698c2cecf3ebc000b9a59d0525; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_698c2cecf3ebc000b9a59d0525" ON public.sku_variants USING btree ("productId", "SizeCode", "ColorCode");


--
-- TOC entry 5250 (class 1259 OID 17544)
-- Name: IDX_72679d98b31c737937b8932ebe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_72679d98b31c737937b8932ebe" ON public.cart_items USING btree ("productId");


--
-- TOC entry 5340 (class 1259 OID 18187)
-- Name: IDX_7546fb1ff1da342b0319d05046; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_7546fb1ff1da342b0319d05046" ON public.employee_color_management USING btree ("employeeId");


--
-- TOC entry 5206 (class 1259 OID 18303)
-- Name: IDX_7d46969a34089aeea345f1f328; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_7d46969a34089aeea345f1f328" ON public.stock_movements USING btree ("stockId");


--
-- TOC entry 5262 (class 1259 OID 17648)
-- Name: IDX_7ed5659e7139fc8bc039198cc1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_7ed5659e7139fc8bc039198cc1" ON public.reviews USING btree ("userId");


--
-- TOC entry 5233 (class 1259 OID 18308)
-- Name: IDX_8722b3284a820badab4769012e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_8722b3284a820badab4769012e" ON public.asset_disposals USING btree ("assetId");


--
-- TOC entry 5243 (class 1259 OID 17506)
-- Name: IDX_90ac60831033837488dc40e315; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_90ac60831033837488dc40e315" ON public.design_placements USING btree ("designId");


--
-- TOC entry 5303 (class 1259 OID 17930)
-- Name: IDX_916d0593328eb479898792abd3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_916d0593328eb479898792abd3" ON public.orders USING btree ("Status");


--
-- TOC entry 5276 (class 1259 OID 17727)
-- Name: IDX_93a2c641c60bd7bf2428d11e07; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_93a2c641c60bd7bf2428d11e07" ON public.track_events USING btree ("shipmentId");


--
-- TOC entry 5273 (class 1259 OID 17710)
-- Name: IDX_95c93a584de49f0b0e13f75363; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_95c93a584de49f0b0e13f75363" ON public.addresses USING btree ("userId");


--
-- TOC entry 5268 (class 1259 OID 17685)
-- Name: IDX_9e5b46d54cb77570fa51430ef6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_9e5b46d54cb77570fa51430ef6" ON public.products USING btree ("isFeatured");


--
-- TOC entry 5310 (class 1259 OID 17968)
-- Name: IDX_a3612e072e450a54221a07840d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_a3612e072e450a54221a07840d" ON public.favorites USING btree ("userId", "productId") WHERE ("designId" IS NULL);


--
-- TOC entry 5263 (class 1259 OID 17647)
-- Name: IDX_a6b3c434392f5d10ec17104366; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_a6b3c434392f5d10ec17104366" ON public.reviews USING btree ("productId");


--
-- TOC entry 5344 (class 1259 OID 18197)
-- Name: IDX_a8e64062fa4bc1b02c7d370f2e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_a8e64062fa4bc1b02c7d370f2e" ON public.product_materials USING btree ("productId");


--
-- TOC entry 5292 (class 1259 OID 17850)
-- Name: IDX_af929a5f2a400fdb6913b4967e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_af929a5f2a400fdb6913b4967e" ON public.payments USING btree ("orderId");


--
-- TOC entry 5306 (class 1259 OID 17954)
-- Name: IDX_b991b670b45e401d5e225028f4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_b991b670b45e401d5e225028f4" ON public.saved_designs USING btree ("userId");


--
-- TOC entry 5269 (class 1259 OID 17688)
-- Name: IDX_c30f00a871de74c8e8c213acc4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c30f00a871de74c8e8c213acc4" ON public.products USING btree (title);


--
-- TOC entry 5240 (class 1259 OID 17490)
-- Name: IDX_c9f785ed614d474d10c6a3f4d0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_c9f785ed614d474d10c6a3f4d0" ON public.design_assets USING btree ("designId");


--
-- TOC entry 5293 (class 1259 OID 17849)
-- Name: IDX_cbe18cae039006a9c217d5a66a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cbe18cae039006a9c217d5a66a" ON public.payments USING btree ("paymentMethodId");


--
-- TOC entry 5217 (class 1259 OID 18302)
-- Name: IDX_cd181ebbe6bf15fa9cbbc91a91; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_cd181ebbe6bf15fa9cbbc91a91" ON public.employees USING btree ("taxID");


--
-- TOC entry 5285 (class 1259 OID 17781)
-- Name: IDX_cdb99c05982d5191ac8465ac01; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_cdb99c05982d5191ac8465ac01" ON public.order_items USING btree ("productId");


--
-- TOC entry 5345 (class 1259 OID 18196)
-- Name: IDX_ce2eec148df0a0d7886d35b9c5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ce2eec148df0a0d7886d35b9c5" ON public.product_materials USING btree ("materialId");


--
-- TOC entry 5341 (class 1259 OID 18188)
-- Name: IDX_e20f4612658de127bb5add81fd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_e20f4612658de127bb5add81fd" ON public.employee_color_management USING btree ("colorCode");


--
-- TOC entry 5333 (class 1259 OID 18121)
-- Name: IDX_e2c9064b90dd5b530c2b01ce22; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_e2c9064b90dd5b530c2b01ce22" ON public.reward_points USING btree ("userId");


--
-- TOC entry 5280 (class 1259 OID 17762)
-- Name: IDX_e79f1bbae38909ba65ccf7f748; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_e79f1bbae38909ba65ccf7f748" ON public.shipments USING btree ("addressId");


--
-- TOC entry 5251 (class 1259 OID 17545)
-- Name: IDX_edd714311619a5ad0952504583; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_edd714311619a5ad0952504583" ON public.cart_items USING btree ("cartId");


--
-- TOC entry 5210 (class 1259 OID 18306)
-- Name: IDX_eeef177e88218449410bbb3af4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_eeef177e88218449410bbb3af4" ON public.shipment_items USING btree ("shipmentId");


--
-- TOC entry 5327 (class 1259 OID 18079)
-- Name: IDX_efc30b2b9169e05e0e1e19d6dd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IDX_efc30b2b9169e05e0e1e19d6dd" ON public.vouchers USING btree (code);


--
-- TOC entry 5286 (class 1259 OID 17782)
-- Name: IDX_f1d359a55923bb45b057fbdab0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f1d359a55923bb45b057fbdab0" ON public.order_items USING btree ("orderId");


--
-- TOC entry 5264 (class 1259 OID 17645)
-- Name: IDX_f4b88c05a7adf404a6e6b2f1eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_f4b88c05a7adf404a6e6b2f1eb" ON public.reviews USING btree (rating);


--
-- TOC entry 5270 (class 1259 OID 17687)
-- Name: IDX_ff56834e735fa78a15d0cf2192; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_ff56834e735fa78a15d0cf2192" ON public.products USING btree ("categoryId");


--
-- TOC entry 5386 (class 2606 OID 18484)
-- Name: return_requests FK_01853126105daa52caee638ab8a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_requests
    ADD CONSTRAINT "FK_01853126105daa52caee638ab8a" FOREIGN KEY ("orderId") REFERENCES public.orders(id);


--
-- TOC entry 5365 (class 2606 OID 18379)
-- Name: sku_variants FK_022c5bb11f1bbc6b4d53fdd033a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sku_variants
    ADD CONSTRAINT "FK_022c5bb11f1bbc6b4d53fdd033a" FOREIGN KEY ("ColorCode") REFERENCES public.color_options("ColorCode");


--
-- TOC entry 5348 (class 2606 OID 18364)
-- Name: stocks FK_08d8d66a3c53115fa464d8c81ad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stocks
    ADD CONSTRAINT "FK_08d8d66a3c53115fa464d8c81ad" FOREIGN KEY ("skuId") REFERENCES public.sku_variants("SkuID");


--
-- TOC entry 5392 (class 2606 OID 18519)
-- Name: favorites FK_0c7bba48aac77ad13092685ba5b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT "FK_0c7bba48aac77ad13092685ba5b" FOREIGN KEY ("productId") REFERENCES public.products(id);


--
-- TOC entry 5397 (class 2606 OID 18559)
-- Name: user_vouchers FK_133943cc01869b20c2064e9f79b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_vouchers
    ADD CONSTRAINT "FK_133943cc01869b20c2064e9f79b" FOREIGN KEY ("voucherId") REFERENCES public.vouchers(id);


--
-- TOC entry 5377 (class 2606 OID 18429)
-- Name: shipments FK_13ba957bcb616719a0dc3fca82f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT "FK_13ba957bcb616719a0dc3fca82f" FOREIGN KEY ("orderId") REFERENCES public.orders(id);


--
-- TOC entry 5388 (class 2606 OID 18494)
-- Name: orders FK_151b79a83ba240b0cb31b2302d1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "FK_151b79a83ba240b0cb31b2302d1" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5398 (class 2606 OID 18554)
-- Name: user_vouchers FK_1d664edcc508b45021dadaad2ee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_vouchers
    ADD CONSTRAINT "FK_1d664edcc508b45021dadaad2ee" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5399 (class 2606 OID 18564)
-- Name: user_vouchers FK_1f6d63ed9514b23f409972b9564; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_vouchers
    ADD CONSTRAINT "FK_1f6d63ed9514b23f409972b9564" FOREIGN KEY ("orderId") REFERENCES public.orders(id);


--
-- TOC entry 5370 (class 2606 OID 18409)
-- Name: reviews FK_23bf332320be3bcd69d2f16f99b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "FK_23bf332320be3bcd69d2f16f99b" FOREIGN KEY ("designId") REFERENCES public.designs("DESIGN_ID");


--
-- TOC entry 5358 (class 2606 OID 18324)
-- Name: design_placements FK_243657581cb0cdf86038f115d54; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.design_placements
    ADD CONSTRAINT "FK_243657581cb0cdf86038f115d54" FOREIGN KEY ("printMethodId") REFERENCES public.print_methods("PM_ID");


--
-- TOC entry 5350 (class 2606 OID 18449)
-- Name: shipment_items FK_2590a15118d9fef2d0f7793a8b2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_items
    ADD CONSTRAINT "FK_2590a15118d9fef2d0f7793a8b2" FOREIGN KEY ("orderItemId") REFERENCES public.order_items(id) ON DELETE CASCADE;


--
-- TOC entry 5378 (class 2606 OID 18439)
-- Name: shipments FK_2a2540e4b3a6b5c77937b44f2b5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT "FK_2a2540e4b3a6b5c77937b44f2b5" FOREIGN KEY ("packagingId") REFERENCES public.packagings("PKG_ID");


--
-- TOC entry 5361 (class 2606 OID 18349)
-- Name: cart_items FK_30087a95555f2ebfbed93e15d24; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT "FK_30087a95555f2ebfbed93e15d24" FOREIGN KEY ("designId") REFERENCES public.designs("DESIGN_ID");


--
-- TOC entry 5402 (class 2606 OID 18579)
-- Name: contacts FK_30ef77942fc8c05fcb829dcc61d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT "FK_30ef77942fc8c05fcb829dcc61d" FOREIGN KEY ("userId") REFERENCES public.users("UserID") ON DELETE CASCADE;


--
-- TOC entry 5353 (class 2606 OID 18529)
-- Name: assets FK_32efd6f12ff7a7c3026a03996ac; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT "FK_32efd6f12ff7a7c3026a03996ac" FOREIGN KEY ("uploadedBy") REFERENCES public.users("UserID");


--
-- TOC entry 5366 (class 2606 OID 18374)
-- Name: sku_variants FK_351b8d68889e32424a31965461f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sku_variants
    ADD CONSTRAINT "FK_351b8d68889e32424a31965461f" FOREIGN KEY ("SizeCode") REFERENCES public.sizes("SizeCode");


--
-- TOC entry 5400 (class 2606 OID 18574)
-- Name: reward_points FK_368d4b3067c85cb00fea060f2e9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reward_points
    ADD CONSTRAINT "FK_368d4b3067c85cb00fea060f2e9" FOREIGN KEY ("orderId") REFERENCES public.orders(id);


--
-- TOC entry 5362 (class 2606 OID 18344)
-- Name: cart_items FK_3eeb7a8cc1bc4564af9169510e0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT "FK_3eeb7a8cc1bc4564af9169510e0" FOREIGN KEY ("colorCode") REFERENCES public.color_options("ColorCode");


--
-- TOC entry 5396 (class 2606 OID 18539)
-- Name: users FK_446a800a0dc374a54f98f1ef5c4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "FK_446a800a0dc374a54f98f1ef5c4" FOREIGN KEY ("invitedById") REFERENCES public.invitation_codes(id);


--
-- TOC entry 5389 (class 2606 OID 18509)
-- Name: saved_designs FK_4ce64d84efb72eea9bd9e655d1e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_designs
    ADD CONSTRAINT "FK_4ce64d84efb72eea9bd9e655d1e" FOREIGN KEY ("designId") REFERENCES public.designs("DESIGN_ID");


--
-- TOC entry 5371 (class 2606 OID 18404)
-- Name: reviews FK_53a68dc905777554b7f702791fa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "FK_53a68dc905777554b7f702791fa" FOREIGN KEY ("orderId") REFERENCES public.orders(id);


--
-- TOC entry 5387 (class 2606 OID 18489)
-- Name: return_requests FK_550bf6343a19fd747b7788858ec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_requests
    ADD CONSTRAINT "FK_550bf6343a19fd747b7788858ec" FOREIGN KEY ("reasonCode") REFERENCES public.return_reasons("Reason_code");


--
-- TOC entry 5383 (class 2606 OID 18469)
-- Name: payment_methods FK_580f1dbf7bceb9c2cde8baf7ff4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT "FK_580f1dbf7bceb9c2cde8baf7ff4" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5369 (class 2606 OID 18389)
-- Name: designs FK_60158f7cc0ad6a8dae62dc10ca5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.designs
    ADD CONSTRAINT "FK_60158f7cc0ad6a8dae62dc10ca5" FOREIGN KEY ("categoryId") REFERENCES public.categories(id);


--
-- TOC entry 5390 (class 2606 OID 18504)
-- Name: saved_designs FK_669c1546f2d560c081c5f818c1e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_designs
    ADD CONSTRAINT "FK_669c1546f2d560c081c5f818c1e" FOREIGN KEY ("productId") REFERENCES public.products(id);


--
-- TOC entry 5360 (class 2606 OID 18329)
-- Name: carts FK_69828a178f152f157dcf2f70a89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT "FK_69828a178f152f157dcf2f70a89" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5363 (class 2606 OID 18339)
-- Name: cart_items FK_72679d98b31c737937b8932ebe6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT "FK_72679d98b31c737937b8932ebe6" FOREIGN KEY ("productId") REFERENCES public.products(id);


--
-- TOC entry 5352 (class 2606 OID 18354)
-- Name: employees FK_737991e10350d9626f592894cef; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT "FK_737991e10350d9626f592894cef" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5403 (class 2606 OID 18584)
-- Name: employee_color_management FK_7546fb1ff1da342b0319d050467; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_color_management
    ADD CONSTRAINT "FK_7546fb1ff1da342b0319d050467" FOREIGN KEY ("employeeId") REFERENCES public.employees(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5349 (class 2606 OID 18359)
-- Name: stock_movements FK_7d46969a34089aeea345f1f328f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT "FK_7d46969a34089aeea345f1f328f" FOREIGN KEY ("stockId") REFERENCES public.stocks("StockID") ON DELETE CASCADE;


--
-- TOC entry 5372 (class 2606 OID 18394)
-- Name: reviews FK_7ed5659e7139fc8bc039198cc1f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "FK_7ed5659e7139fc8bc039198cc1f" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5354 (class 2606 OID 18544)
-- Name: asset_disposals FK_8722b3284a820badab4769012ec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_disposals
    ADD CONSTRAINT "FK_8722b3284a820badab4769012ec" FOREIGN KEY ("assetId") REFERENCES public.assets(id) ON DELETE CASCADE;


--
-- TOC entry 5359 (class 2606 OID 18319)
-- Name: design_placements FK_90ac60831033837488dc40e3156; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.design_placements
    ADD CONSTRAINT "FK_90ac60831033837488dc40e3156" FOREIGN KEY ("designId") REFERENCES public.designs("DESIGN_ID");


--
-- TOC entry 5376 (class 2606 OID 18424)
-- Name: track_events FK_93a2c641c60bd7bf2428d11e07c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.track_events
    ADD CONSTRAINT "FK_93a2c641c60bd7bf2428d11e07c" FOREIGN KEY ("shipmentId") REFERENCES public.shipments("Ship_ID");


--
-- TOC entry 5395 (class 2606 OID 18534)
-- Name: invitation_codes FK_946a5df42e6dbf2550115cbb8b9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation_codes
    ADD CONSTRAINT "FK_946a5df42e6dbf2550115cbb8b9" FOREIGN KEY ("ownerId") REFERENCES public.users("UserID");


--
-- TOC entry 5375 (class 2606 OID 18419)
-- Name: addresses FK_95c93a584de49f0b0e13f753630; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT "FK_95c93a584de49f0b0e13f753630" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5356 (class 2606 OID 18309)
-- Name: categories FK_9a6f051e66982b5f0318981bcaa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "FK_9a6f051e66982b5f0318981bcaa" FOREIGN KEY ("parentId") REFERENCES public.categories(id);


--
-- TOC entry 5373 (class 2606 OID 18399)
-- Name: reviews FK_a6b3c434392f5d10ec171043666; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT "FK_a6b3c434392f5d10ec171043666" FOREIGN KEY ("productId") REFERENCES public.products(id);


--
-- TOC entry 5405 (class 2606 OID 28531)
-- Name: product_materials FK_a8e64062fa4bc1b02c7d370f2ec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_materials
    ADD CONSTRAINT "FK_a8e64062fa4bc1b02c7d370f2ec" FOREIGN KEY ("productId") REFERENCES public.products(id);


--
-- TOC entry 5384 (class 2606 OID 18479)
-- Name: payments FK_af929a5f2a400fdb6913b4967e1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT "FK_af929a5f2a400fdb6913b4967e1" FOREIGN KEY ("orderId") REFERENCES public.orders(id);


--
-- TOC entry 5393 (class 2606 OID 18524)
-- Name: favorites FK_b8f48757aa17efd5424d93b8e6a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT "FK_b8f48757aa17efd5424d93b8e6a" FOREIGN KEY ("designId") REFERENCES public.designs("DESIGN_ID");


--
-- TOC entry 5391 (class 2606 OID 18499)
-- Name: saved_designs FK_b991b670b45e401d5e225028f49; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_designs
    ADD CONSTRAINT "FK_b991b670b45e401d5e225028f49" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5380 (class 2606 OID 18464)
-- Name: order_items FK_bba09df965d9d1e44eb8f05fec7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "FK_bba09df965d9d1e44eb8f05fec7" FOREIGN KEY ("skuId") REFERENCES public.sku_variants("SkuID");


--
-- TOC entry 5367 (class 2606 OID 18384)
-- Name: sku_variants FK_c993b4964615d740b2d07e20537; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sku_variants
    ADD CONSTRAINT "FK_c993b4964615d740b2d07e20537" FOREIGN KEY ("designId") REFERENCES public.designs("DESIGN_ID");


--
-- TOC entry 5357 (class 2606 OID 18314)
-- Name: design_assets FK_c9f785ed614d474d10c6a3f4d0e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.design_assets
    ADD CONSTRAINT "FK_c9f785ed614d474d10c6a3f4d0e" FOREIGN KEY ("designId") REFERENCES public.designs("DESIGN_ID");


--
-- TOC entry 5385 (class 2606 OID 18474)
-- Name: payments FK_cbe18cae039006a9c217d5a66a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT "FK_cbe18cae039006a9c217d5a66a6" FOREIGN KEY ("paymentMethodId") REFERENCES public.payment_methods("MethodID");


--
-- TOC entry 5381 (class 2606 OID 18459)
-- Name: order_items FK_cdb99c05982d5191ac8465ac010; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "FK_cdb99c05982d5191ac8465ac010" FOREIGN KEY ("productId") REFERENCES public.products(id);


--
-- TOC entry 5406 (class 2606 OID 28526)
-- Name: product_materials FK_ce2eec148df0a0d7886d35b9c5d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_materials
    ADD CONSTRAINT "FK_ce2eec148df0a0d7886d35b9c5d" FOREIGN KEY ("materialId") REFERENCES public.materials("MatID") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5368 (class 2606 OID 18369)
-- Name: sku_variants FK_ded8df7f00c25ee72a7a19604d5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sku_variants
    ADD CONSTRAINT "FK_ded8df7f00c25ee72a7a19604d5" FOREIGN KEY ("productId") REFERENCES public.products(id);


--
-- TOC entry 5404 (class 2606 OID 18589)
-- Name: employee_color_management FK_e20f4612658de127bb5add81fdb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_color_management
    ADD CONSTRAINT "FK_e20f4612658de127bb5add81fdb" FOREIGN KEY ("colorCode") REFERENCES public.color_options("ColorCode");


--
-- TOC entry 5401 (class 2606 OID 18569)
-- Name: reward_points FK_e2c9064b90dd5b530c2b01ce223; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reward_points
    ADD CONSTRAINT "FK_e2c9064b90dd5b530c2b01ce223" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5394 (class 2606 OID 18514)
-- Name: favorites FK_e747534006c6e3c2f09939da60f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT "FK_e747534006c6e3c2f09939da60f" FOREIGN KEY ("userId") REFERENCES public.users("UserID");


--
-- TOC entry 5379 (class 2606 OID 18434)
-- Name: shipments FK_e79f1bbae38909ba65ccf7f7486; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipments
    ADD CONSTRAINT "FK_e79f1bbae38909ba65ccf7f7486" FOREIGN KEY ("addressId") REFERENCES public.addresses(addr_id);


--
-- TOC entry 5364 (class 2606 OID 18334)
-- Name: cart_items FK_edd714311619a5ad09525045838; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT "FK_edd714311619a5ad09525045838" FOREIGN KEY ("cartId") REFERENCES public.carts(id);


--
-- TOC entry 5351 (class 2606 OID 18444)
-- Name: shipment_items FK_eeef177e88218449410bbb3af44; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_items
    ADD CONSTRAINT "FK_eeef177e88218449410bbb3af44" FOREIGN KEY ("shipmentId") REFERENCES public.shipments("Ship_ID") ON DELETE CASCADE;


--
-- TOC entry 5382 (class 2606 OID 18454)
-- Name: order_items FK_f1d359a55923bb45b057fbdab0d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "FK_f1d359a55923bb45b057fbdab0d" FOREIGN KEY ("orderId") REFERENCES public.orders(id);


--
-- TOC entry 5355 (class 2606 OID 18549)
-- Name: asset_disposals FK_f7f7281ebf0cea23589967c348a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.asset_disposals
    ADD CONSTRAINT "FK_f7f7281ebf0cea23589967c348a" FOREIGN KEY ("disposedBy") REFERENCES public.users("UserID");


--
-- TOC entry 5374 (class 2606 OID 18414)
-- Name: products FK_ff56834e735fa78a15d0cf21926; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "FK_ff56834e735fa78a15d0cf21926" FOREIGN KEY ("categoryId") REFERENCES public.categories(id);


-- Completed on 2026-04-13 21:43:43

--
-- PostgreSQL database dump complete
--

\unrestrict Uco41RS0rzYTAjcUPeZIeoveJPaASeotac7kXWO6lRdQrd0doVbcyBx5s55Baob

