CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SCHEMA IF NOT EXISTS stg AUTHORIZATION postgres;

COMMENT ON SCHEMA stg IS 'stg Staging database schema';
---


--
-- Name: address; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.address (
    id uuid default uuid_generate_v4(),
    address_id integer NOT NULL,
    street_number character varying(10),
    street_name character varying(200),
    city character varying(100),
    country_id integer,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.address OWNER TO postgres;

--
-- Name: address_status; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.address_status (
    id uuid default uuid_generate_v4(),
    status_id integer NOT NULL,
    address_status character varying(30),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.address_status OWNER TO postgres;

--
-- Name: author; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.author (
    id uuid default uuid_generate_v4(),
    author_id integer NOT NULL,
    author_name character varying(400),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.author OWNER TO postgres;

--
-- Name: book; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.book (
    id uuid default uuid_generate_v4(),
    book_id integer NOT NULL,
    title character varying(400),
    isbn13 character varying(13),
    language_id integer,
    num_pages integer,
    stgation_date date,
    publisher_id integer,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.book OWNER TO postgres;

--
-- Name: book_author; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.book_author (
    id uuid default uuid_generate_v4(),
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.book_author OWNER TO postgres;

--
-- Name: book_language; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.book_language (
    id uuid default uuid_generate_v4(),
    language_id integer NOT NULL,
    language_code character varying(8),
    language_name character varying(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.book_language OWNER TO postgres;

--
-- Name: country; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.country (
    id uuid default uuid_generate_v4(),
    country_id integer NOT NULL,
    country_name character varying(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.country OWNER TO postgres;

--
-- Name: cust_order; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.cust_order (
    id uuid default uuid_generate_v4(),
    order_id integer NOT NULL,
    order_date timestamp without time zone,
    customer_id integer,
    shipping_method_id integer,
    dest_address_id integer,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.cust_order OWNER TO postgres;

--
-- Name: cust_order_order_id_seq; Type: SEQUENCE; Schema: stg; Owner: postgres
--

CREATE SEQUENCE stg.cust_order_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stg.cust_order_order_id_seq OWNER TO postgres;

--
-- Name: cust_order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: stg; Owner: postgres
--

ALTER SEQUENCE stg.cust_order_order_id_seq OWNED BY stg.cust_order.order_id;


--
-- Name: customer; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.customer (
    id uuid default uuid_generate_v4(),
    customer_id integer NOT NULL,
    first_name character varying(200),
    last_name character varying(200),
    email character varying(350),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.customer OWNER TO postgres;

--
-- Name: customer_address; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.customer_address (
    id uuid default uuid_generate_v4(),
    customer_id integer NOT NULL,
    address_id integer NOT NULL,
    status_id integer,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.customer_address OWNER TO postgres;

--
-- Name: order_history; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.order_history (
    id uuid default uuid_generate_v4(),
    history_id integer NOT NULL,
    order_id integer,
    status_id integer,
    status_date timestamp without time zone,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.order_history OWNER TO postgres;

--
-- Name: order_history_history_id_seq; Type: SEQUENCE; Schema: stg; Owner: postgres
--

CREATE SEQUENCE stg.order_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stg.order_history_history_id_seq OWNER TO postgres;

--
-- Name: order_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: stg; Owner: postgres
--

ALTER SEQUENCE stg.order_history_history_id_seq OWNED BY stg.order_history.history_id;


--
-- Name: order_line; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.order_line (
    id uuid default uuid_generate_v4(),
    line_id integer NOT NULL,
    order_id integer,
    book_id integer,
    price numeric(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.order_line OWNER TO postgres;

--
-- Name: order_line_line_id_seq; Type: SEQUENCE; Schema: stg; Owner: postgres
--

CREATE SEQUENCE stg.order_line_line_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stg.order_line_line_id_seq OWNER TO postgres;

--
-- Name: order_line_line_id_seq; Type: SEQUENCE OWNED BY; Schema: stg; Owner: postgres
--

ALTER SEQUENCE stg.order_line_line_id_seq OWNED BY stg.order_line.line_id;


--
-- Name: order_status; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.order_status (
    id uuid default uuid_generate_v4(),
    status_id integer NOT NULL,
    status_value character varying(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.order_status OWNER TO postgres;

--
-- Name: publisher; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.publisher (
    id uuid default uuid_generate_v4(),
    publisher_id integer NOT NULL,
    publisher_name character varying(400),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.publisher OWNER TO postgres;

--
-- Name: shipping_method; Type: TABLE; Schema: stg; Owner: postgres
--

CREATE TABLE stg.shipping_method (
    id uuid default uuid_generate_v4(),
    method_id integer NOT NULL,
    method_name character varying(100),
    cost numeric(6,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE stg.shipping_method OWNER TO postgres;

--
-- Name: cust_order order_id; Type: DEFAULT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.cust_order ALTER COLUMN order_id SET DEFAULT nextval('stg.cust_order_order_id_seq'::regclass);


--
-- Name: order_history history_id; Type: DEFAULT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.order_history ALTER COLUMN history_id SET DEFAULT nextval('stg.order_history_history_id_seq'::regclass);


--
-- Name: order_line line_id; Type: DEFAULT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.order_line ALTER COLUMN line_id SET DEFAULT nextval('stg.order_line_line_id_seq'::regclass);


--

--
-- Name: address_status pk_addr_status; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.address_status
    ADD CONSTRAINT pk_addr_status PRIMARY KEY (id);


--
-- Name: address pk_address; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.address
    ADD CONSTRAINT pk_address PRIMARY KEY (id);


--
-- Name: author pk_author; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.author
    ADD CONSTRAINT pk_author PRIMARY KEY (id);


--
-- Name: book pk_book; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.book
    ADD CONSTRAINT pk_book PRIMARY KEY (id);


--
-- Name: book_author pk_bookauthor; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.book_author
    ADD CONSTRAINT pk_bookauthor PRIMARY KEY (id);


--
-- Name: country pk_country; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.country
    ADD CONSTRAINT pk_country PRIMARY KEY (id);


--
-- Name: customer_address pk_custaddr; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.customer_address
    ADD CONSTRAINT pk_custaddr PRIMARY KEY (id);


--
-- Name: customer pk_customer; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.customer
    ADD CONSTRAINT pk_customer PRIMARY KEY (id);


--
-- Name: cust_order pk_custorder; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.cust_order
    ADD CONSTRAINT pk_custorder PRIMARY KEY (id);


--
-- Name: book_language pk_language; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.book_language
    ADD CONSTRAINT pk_language PRIMARY KEY (id);


--
-- Name: order_history pk_orderhist; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.order_history
    ADD CONSTRAINT pk_orderhist PRIMARY KEY (id);


--
-- Name: order_line pk_orderline; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.order_line
    ADD CONSTRAINT pk_orderline PRIMARY KEY (id);


--
-- Name: order_status pk_orderstatus; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.order_status
    ADD CONSTRAINT pk_orderstatus PRIMARY KEY (id);


--
-- Name: publisher pk_publisher; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.publisher
    ADD CONSTRAINT pk_publisher PRIMARY KEY (id);


--
-- Name: shipping_method pk_shipmethod; Type: CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.shipping_method
    ADD CONSTRAINT pk_shipmethod PRIMARY KEY (id);


--
-- Name: address fk_addr_ctry; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.country ADD UNIQUE (country_id);

ALTER TABLE ONLY stg.address
    ADD CONSTRAINT fk_addr_ctry FOREIGN KEY (country_id) REFERENCES stg.country(country_id);


--
-- Name: book_author fk_ba_author; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE stg.author ADD UNIQUE (author_id);

ALTER TABLE ONLY stg.book_author
    ADD CONSTRAINT fk_ba_author FOREIGN KEY (author_id) REFERENCES stg.author(author_id);


--
-- Name: book_author fk_ba_book; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.book ADD UNIQUE (book_id);


ALTER TABLE ONLY stg.book_author
    ADD CONSTRAINT fk_ba_book FOREIGN KEY (book_id) REFERENCES stg.book(book_id);


--
-- Name: book fk_book_lang; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.book_language ADD UNIQUE (language_id);


ALTER TABLE ONLY stg.book
    ADD CONSTRAINT fk_book_lang FOREIGN KEY (language_id) REFERENCES stg.book_language(language_id);


--
-- Name: book fk_book_pub; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.publisher ADD UNIQUE (publisher_id);


ALTER TABLE ONLY stg.book
    ADD CONSTRAINT fk_book_pub FOREIGN KEY (publisher_id) REFERENCES stg.publisher(publisher_id);


--
-- Name: customer_address fk_ca_addr; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.address ADD UNIQUE (address_id);


ALTER TABLE ONLY stg.customer_address
    ADD CONSTRAINT fk_ca_addr FOREIGN KEY (address_id) REFERENCES stg.address(address_id);


--
-- Name: customer_address fk_ca_cust; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.customer ADD UNIQUE (customer_id);


ALTER TABLE ONLY stg.customer_address
    ADD CONSTRAINT fk_ca_cust FOREIGN KEY (customer_id) REFERENCES stg.customer(customer_id);


--
-- Name: order_history fk_oh_order; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.cust_order ADD UNIQUE (order_id);


ALTER TABLE ONLY stg.order_history
    ADD CONSTRAINT fk_oh_order FOREIGN KEY (order_id) REFERENCES stg.cust_order(order_id);


--
-- Name: order_history fk_oh_status; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.order_status ADD UNIQUE (status_id);


ALTER TABLE ONLY stg.order_history
    ADD CONSTRAINT fk_oh_status FOREIGN KEY (status_id) REFERENCES stg.order_status(status_id);


--
-- Name: order_line fk_ol_book; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.book ADD UNIQUE (book_id);


ALTER TABLE ONLY stg.order_line
    ADD CONSTRAINT fk_ol_book FOREIGN KEY (book_id) REFERENCES stg.book(book_id);


--
-- Name: order_line fk_ol_order; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.order_line
    ADD CONSTRAINT fk_ol_order FOREIGN KEY (order_id) REFERENCES stg.cust_order(order_id);


--
-- Name: cust_order fk_order_addr; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.cust_order
    ADD CONSTRAINT fk_order_addr FOREIGN KEY (dest_address_id) REFERENCES stg.address(address_id);


--
-- Name: cust_order fk_order_cust; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--

ALTER TABLE ONLY stg.cust_order
    ADD CONSTRAINT fk_order_cust FOREIGN KEY (customer_id) REFERENCES stg.customer(customer_id);


--
-- Name: cust_order fk_order_ship; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.shipping_method ADD UNIQUE (method_id);


ALTER TABLE ONLY stg.cust_order
    ADD CONSTRAINT fk_order_ship FOREIGN KEY (shipping_method_id) REFERENCES stg.shipping_method(method_id);


--
-- Name: customer_address fkey_status_add; Type: FK CONSTRAINT; Schema: stg; Owner: postgres
--
ALTER TABLE stg.address_status ADD UNIQUE (status_id);


ALTER TABLE ONLY stg.customer_address
    ADD CONSTRAINT fkey_status_add FOREIGN KEY (status_id) REFERENCES stg.address_status(status_id);



-- PostgreSQL database dump complete
--

