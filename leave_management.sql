--
-- PostgreSQL database cluster dump
--

-- Started on 2025-03-30 00:48:09

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:afB4n1eGCEvQLcS3XY888g==$1KNufhypWAfmRU3TnpCl8CLuEPQRbD7va31crBVUvHY=:TecR9Nt9yYDSEYdxgNaoNrJwtj2h50n3RiF6znnJZ3Q=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.10
-- Dumped by pg_dump version 15.10

-- Started on 2025-03-30 00:48:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2025-03-30 00:48:10

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.10
-- Dumped by pg_dump version 15.10

-- Started on 2025-03-30 00:48:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16466)
-- Name: leave_balances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leave_balances (
    id integer NOT NULL,
    user_id integer NOT NULL,
    remaining_days integer NOT NULL,
    total_days character varying(50),
    used_days character varying(50),
    CONSTRAINT leave_balances_remaining_days_check CHECK ((remaining_days >= 0))
);


ALTER TABLE public.leave_balances OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16465)
-- Name: leave_balances_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leave_balances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leave_balances_id_seq OWNER TO postgres;

--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 220
-- Name: leave_balances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leave_balances_id_seq OWNED BY public.leave_balances.id;


--
-- TOC entry 219 (class 1259 OID 16459)
-- Name: leave_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leave_requests (
    id integer NOT NULL,
    user_id integer NOT NULL,
    leave_type character varying(50) NOT NULL,
    s_date date NOT NULL,
    e_date date NOT NULL,
    status character varying(50)
);


ALTER TABLE public.leave_requests OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16458)
-- Name: leave_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leave_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leave_requests_id_seq OWNER TO postgres;

--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 218
-- Name: leave_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leave_requests_id_seq OWNED BY public.leave_requests.id;


--
-- TOC entry 215 (class 1259 OID 16442)
-- Name: stajyer_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stajyer_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stajyer_seq OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16449)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(50) NOT NULL,
    insurance_start_date character varying(50),
    role character varying(50) NOT NULL,
    CONSTRAINT chk_users_role CHECK (((role)::text = ANY ((ARRAY['ADMIN'::character varying, 'HR'::character varying, 'EMPLOYEE'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16448)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3187 (class 2604 OID 16469)
-- Name: leave_balances id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balances ALTER COLUMN id SET DEFAULT nextval('public.leave_balances_id_seq'::regclass);


--
-- TOC entry 3186 (class 2604 OID 16462)
-- Name: leave_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests ALTER COLUMN id SET DEFAULT nextval('public.leave_requests_id_seq'::regclass);


--
-- TOC entry 3185 (class 2604 OID 16452)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3348 (class 0 OID 16466)
-- Dependencies: 221
-- Data for Name: leave_balances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leave_balances (id, user_id, remaining_days, total_days, used_days) FROM stdin;
\.


--
-- TOC entry 3346 (class 0 OID 16459)
-- Dependencies: 219
-- Data for Name: leave_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leave_requests (id, user_id, leave_type, s_date, e_date, status) FROM stdin;
\.


--
-- TOC entry 3344 (class 0 OID 16449)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, password, email, insurance_start_date, role) FROM stdin;
1	Turul	Biber	ruhi123	turul@gmail.com	12.12.2012	EMPLOYEE
2	Ozco	Atis	maniyaq	ozco@gmail.com	12.12.2012	EMPLOYEE
3	Mert	CK	mastro	karakoc@gmail.com	12.12.2012	EMPLOYEE
4	Emre	Orhen	1234	orhen@gmail.com	12.12.2012	HR
\.


--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 220
-- Name: leave_balances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_balances_id_seq', 1, false);


--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 218
-- Name: leave_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_requests_id_seq', 1, false);


--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 215
-- Name: stajyer_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stajyer_seq', 1, false);


--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- TOC entry 3197 (class 2606 OID 16472)
-- Name: leave_balances leave_balances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balances
    ADD CONSTRAINT leave_balances_pkey PRIMARY KEY (id);


--
-- TOC entry 3195 (class 2606 OID 16464)
-- Name: leave_requests leave_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT leave_requests_pkey PRIMARY KEY (id);


--
-- TOC entry 3191 (class 2606 OID 16492)
-- Name: users users_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email UNIQUE (email);


--
-- TOC entry 3193 (class 2606 OID 16455)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3199 (class 2606 OID 16475)
-- Name: leave_balances fk_leave_balances_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balances
    ADD CONSTRAINT fk_leave_balances_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3198 (class 2606 OID 16480)
-- Name: leave_requests fk_leave_requests_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT fk_leave_requests_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2025-03-30 00:48:10

--
-- PostgreSQL database dump complete
--

--
-- Database "qweee" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.10
-- Dumped by pg_dump version 15.10

-- Started on 2025-03-30 00:48:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3327 (class 1262 OID 16398)
-- Name: qweee; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE qweee WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Turkish_T�rkiye.1254';


ALTER DATABASE qweee OWNER TO postgres;

\connect qweee

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16402)
-- Name: ewqewqeqw; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ewqewqeqw (
    stj_id integer NOT NULL,
    stj_isim character varying(50) NOT NULL,
    stj_alan character varying(50) NOT NULL,
    stj_deneyim character varying(50)
);


ALTER TABLE public.ewqewqeqw OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16399)
-- Name: wqe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wqe (
);


ALTER TABLE public.wqe OWNER TO postgres;

--
-- TOC entry 3321 (class 0 OID 16402)
-- Dependencies: 215
-- Data for Name: ewqewqeqw; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ewqewqeqw (stj_id, stj_isim, stj_alan, stj_deneyim) FROM stdin;
1	Turul	Noob	allah
2	Ozco	Pro	az pro
3	Orhen	IOS	ToDoList
4	Ramazan	FrontendPro	Site
5	Ozgur	Otcu	Hersey
6	Anıl	Test	Testcie
7	Yiğit	Test	Testcie
\.


--
-- TOC entry 3320 (class 0 OID 16399)
-- Dependencies: 214
-- Data for Name: wqe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wqe  FROM stdin;
\.


--
-- TOC entry 3177 (class 2606 OID 16406)
-- Name: ewqewqeqw ewqewqeqw_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ewqewqeqw
    ADD CONSTRAINT ewqewqeqw_pkey PRIMARY KEY (stj_id);


-- Completed on 2025-03-30 00:48:10

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-03-30 00:48:10

--
-- PostgreSQL database cluster dump complete
--

