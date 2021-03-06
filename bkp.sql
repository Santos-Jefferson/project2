--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE category (
    categoryid integer NOT NULL,
    category_name character varying(50) NOT NULL
);


ALTER TABLE category OWNER TO postgres;

--
-- Name: category_categoryId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "category_categoryId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "category_categoryId_seq" OWNER TO postgres;

--
-- Name: category_categoryId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "category_categoryId_seq" OWNED BY category.categoryid;


--
-- Name: expense; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE expense (
    expenseid integer NOT NULL,
    date date NOT NULL,
    amount money NOT NULL,
    categoryid integer NOT NULL,
    description character varying(500) NOT NULL,
    familyid integer NOT NULL
);


ALTER TABLE expense OWNER TO postgres;

--
-- Name: expense_expenseId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "expense_expenseId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "expense_expenseId_seq" OWNER TO postgres;

--
-- Name: expense_expenseId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "expense_expenseId_seq" OWNED BY expense.expenseid;


--
-- Name: family; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE family (
    familyid integer NOT NULL,
    familyusername character varying(100) NOT NULL,
    familypassword character varying(100) NOT NULL
);


ALTER TABLE family OWNER TO postgres;

--
-- Name: family_familyId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "family_familyId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "family_familyId_seq" OWNER TO postgres;

--
-- Name: family_familyId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "family_familyId_seq" OWNED BY family.familyid;


--
-- Name: income; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE income (
    incomeid integer NOT NULL,
    date date NOT NULL,
    amount money NOT NULL,
    categoryid integer NOT NULL,
    description character varying(500) NOT NULL,
    familyid integer NOT NULL
);


ALTER TABLE income OWNER TO postgres;

--
-- Name: income_incomeId_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "income_incomeId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "income_incomeId_seq" OWNER TO postgres;

--
-- Name: income_incomeId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "income_incomeId_seq" OWNED BY income.incomeid;


--
-- Name: category categoryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY category ALTER COLUMN categoryid SET DEFAULT nextval('"category_categoryId_seq"'::regclass);


--
-- Name: expense expenseid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expense ALTER COLUMN expenseid SET DEFAULT nextval('"expense_expenseId_seq"'::regclass);


--
-- Name: family familyid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY family ALTER COLUMN familyid SET DEFAULT nextval('"family_familyId_seq"'::regclass);


--
-- Name: income incomeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY income ALTER COLUMN incomeid SET DEFAULT nextval('"income_incomeId_seq"'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY category (categoryid, category_name) FROM stdin;
3	Incomes
4	Giving
5	Food
6	Utilities
7	Clothing
8	Transportation
9	Medical
10	Insurance
11	Personal
12	Retirement
13	Education
14	Savings
15	Gifts
1	Housing
\.


--
-- Name: category_categoryId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"category_categoryId_seq"', 15, true);


--
-- Data for Name: expense; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY expense (expenseid, date, amount, categoryid, description, familyid) FROM stdin;
1	2017-06-29	R$750,00	1	House rental	1
8	2017-05-20	R$5.000,00	4	Test 123	2
2	2017-05-30	R$234.234,00	1	New House	1
9	2017-07-15	R$5.000,00	1	New car	1
10	2017-07-15	R$5.000,00	1	New car	1
11	2017-07-13	R$1.000,00	1	New good	1
12	2017-07-04	R$1.000,00	1	New stuff	1
13	2017-07-21	R$500,00	1	Test	1
14	2017-07-19	R$100,00	1	test	1
15	2017-07-05	R$100,00	1	123123123	1
17	2017-07-15	R$200,00	1	teste 200	1
18	2017-07-21	R$11.122,00	1	asdfsdf	1
19	2017-07-06	R$324.234,00	1	asd	1
20	2017-07-06	R$324.234,00	1	asd	1
21	2017-07-12	R$1.133,00	1	asdf	1
22	2017-07-12	R$1.133,00	1	asdf	1
23	2017-07-12	R$1.133,00	1	asdf	1
24	2017-07-12	R$1.133,00	1	asdf	1
25	2017-07-12	R$1.133,00	1	asdf	1
\.


--
-- Name: expense_expenseId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"expense_expenseId_seq"', 25, true);


--
-- Data for Name: family; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY family (familyid, familyusername, familypassword) FROM stdin;
1	santos	santos123
2	fialla	fialla123
\.


--
-- Name: family_familyId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"family_familyId_seq"', 11, true);


--
-- Data for Name: income; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY income (incomeid, date, amount, categoryid, description, familyid) FROM stdin;
1	2017-06-29	R$2.000,00	2	Salary	1
\.


--
-- Name: income_incomeId_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"income_incomeId_seq"', 1, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (categoryid);


--
-- Name: expense expense_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expense
    ADD CONSTRAINT expense_pkey PRIMARY KEY (expenseid);


--
-- Name: family family_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY family
    ADD CONSTRAINT family_pkey PRIMARY KEY (familyid);


--
-- Name: income income_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY income
    ADD CONSTRAINT income_pkey PRIMARY KEY (incomeid);


--
-- PostgreSQL database dump complete
--

