CREATE SCHEMA IF NOT EXISTS pacbook AUTHORIZATION postgres;

COMMENT ON SCHEMA pacbook IS 'Pacbook demo database schema';
---


--
-- Name: address; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.address (
    address_id integer NOT NULL,
    street_number character varying(10),
    street_name character varying(200),
    city character varying(100),
    country_id integer,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.address OWNER TO postgres;

--
-- Name: address_status; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.address_status (
    status_id integer NOT NULL,
    address_status character varying(30),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.address_status OWNER TO postgres;

--
-- Name: author; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.author (
    author_id integer NOT NULL,
    author_name character varying(400),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.author OWNER TO postgres;

--
-- Name: book; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.book (
    book_id integer NOT NULL,
    title character varying(400),
    isbn13 character varying(13),
    language_id integer,
    num_pages integer,
    publication_date date,
    publisher_id integer,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.book OWNER TO postgres;

--
-- Name: book_author; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.book_author (
    book_id integer NOT NULL,
    author_id integer NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.book_author OWNER TO postgres;

--
-- Name: book_language; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.book_language (
    language_id integer NOT NULL,
    language_code character varying(8),
    language_name character varying(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.book_language OWNER TO postgres;

--
-- Name: country; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.country (
    country_id integer NOT NULL,
    country_name character varying(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.country OWNER TO postgres;

--
-- Name: cust_order; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.cust_order (
    order_id integer NOT NULL,
    order_date timestamp without time zone,
    customer_id integer,
    shipping_method_id integer,
    dest_address_id integer,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.cust_order OWNER TO postgres;

--
-- Name: cust_order_order_id_seq; Type: SEQUENCE; Schema: pacbook; Owner: postgres
--

CREATE SEQUENCE pacbook.cust_order_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pacbook.cust_order_order_id_seq OWNER TO postgres;

--
-- Name: cust_order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: pacbook; Owner: postgres
--

ALTER SEQUENCE pacbook.cust_order_order_id_seq OWNED BY pacbook.cust_order.order_id;


--
-- Name: customer; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.customer (
    customer_id integer NOT NULL,
    first_name character varying(200),
    last_name character varying(200),
    email character varying(350),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.customer OWNER TO postgres;

--
-- Name: customer_address; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.customer_address (
    customer_id integer NOT NULL,
    address_id integer NOT NULL,
    status_id integer,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.customer_address OWNER TO postgres;

--
-- Name: order_history; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.order_history (
    history_id integer NOT NULL,
    order_id integer,
    status_id integer,
    status_date timestamp without time zone,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.order_history OWNER TO postgres;

--
-- Name: order_history_history_id_seq; Type: SEQUENCE; Schema: pacbook; Owner: postgres
--

CREATE SEQUENCE pacbook.order_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pacbook.order_history_history_id_seq OWNER TO postgres;

--
-- Name: order_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: pacbook; Owner: postgres
--

ALTER SEQUENCE pacbook.order_history_history_id_seq OWNED BY pacbook.order_history.history_id;


--
-- Name: order_line; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.order_line (
    line_id integer NOT NULL,
    order_id integer,
    book_id integer,
    price numeric(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.order_line OWNER TO postgres;

--
-- Name: order_line_line_id_seq; Type: SEQUENCE; Schema: pacbook; Owner: postgres
--

CREATE SEQUENCE pacbook.order_line_line_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE pacbook.order_line_line_id_seq OWNER TO postgres;

--
-- Name: order_line_line_id_seq; Type: SEQUENCE OWNED BY; Schema: pacbook; Owner: postgres
--

ALTER SEQUENCE pacbook.order_line_line_id_seq OWNED BY pacbook.order_line.line_id;


--
-- Name: order_status; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.order_status (
    status_id integer NOT NULL,
    status_value character varying(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.order_status OWNER TO postgres;

--
-- Name: publisher; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.publisher (
    publisher_id integer NOT NULL,
    publisher_name character varying(400),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.publisher OWNER TO postgres;

--
-- Name: shipping_method; Type: TABLE; Schema: pacbook; Owner: postgres
--

CREATE TABLE pacbook.shipping_method (
    method_id integer NOT NULL,
    method_name character varying(100),
    cost numeric(6,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE pacbook.shipping_method OWNER TO postgres;

--
-- Name: cust_order order_id; Type: DEFAULT; Schema: pacbook; Owner: postgres
--

ALTER TABLE ONLY pacbook.cust_order ALTER COLUMN order_id SET DEFAULT nextval('pacbook.cust_order_order_id_seq'::regclass);


--
-- Name: order_history history_id; Type: DEFAULT; Schema: pacbook; Owner: postgres
--

ALTER TABLE ONLY pacbook.order_history ALTER COLUMN history_id SET DEFAULT nextval('pacbook.order_history_history_id_seq'::regclass);


--
-- Name: order_line line_id; Type: DEFAULT; Schema: pacbook; Owner: postgres
--

ALTER TABLE ONLY pacbook.order_line ALTER COLUMN line_id SET DEFAULT nextval('pacbook.order_line_line_id_seq'::regclass);


--

--
-- Name: address_status pk_addr_status; Type: CONSTRAINT; Schema: pacbook; Owner: postgres
--

ALTER TABLE ONLY public.address_status
    ADD CONSTRAINT pk_addr_status PRIMARY KEY (status_id);


--
-- Name: address pk_address; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT pk_address PRIMARY KEY (address_id);


--
-- Name: author pk_author; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT pk_author PRIMARY KEY (author_id);


--
-- Name: book pk_book; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT pk_book PRIMARY KEY (book_id);


--
-- Name: book_author pk_bookauthor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT pk_bookauthor PRIMARY KEY (book_id, author_id);


--
-- Name: country pk_country; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT pk_country PRIMARY KEY (country_id);


--
-- Name: customer_address pk_custaddr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_address
    ADD CONSTRAINT pk_custaddr PRIMARY KEY (customer_id, address_id);


--
-- Name: customer pk_customer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT pk_customer PRIMARY KEY (customer_id);


--
-- Name: cust_order pk_custorder; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cust_order
    ADD CONSTRAINT pk_custorder PRIMARY KEY (order_id);


--
-- Name: book_language pk_language; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_language
    ADD CONSTRAINT pk_language PRIMARY KEY (language_id);


--
-- Name: order_history pk_orderhist; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_history
    ADD CONSTRAINT pk_orderhist PRIMARY KEY (history_id);


--
-- Name: order_line pk_orderline; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_line
    ADD CONSTRAINT pk_orderline PRIMARY KEY (line_id);


--
-- Name: order_status pk_orderstatus; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT pk_orderstatus PRIMARY KEY (status_id);


--
-- Name: publisher pk_publisher; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT pk_publisher PRIMARY KEY (publisher_id);


--
-- Name: shipping_method pk_shipmethod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipping_method
    ADD CONSTRAINT pk_shipmethod PRIMARY KEY (method_id);


--
-- Name: address fk_addr_ctry; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

-- ALTER TABLE ONLY public.address
--     ADD CONSTRAINT fk_addr_ctry FOREIGN KEY (country_id) REFERENCES public.country(country_id);


-- --
-- -- Name: book_author fk_ba_author; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.book_author
--     ADD CONSTRAINT fk_ba_author FOREIGN KEY (author_id) REFERENCES public.author(author_id);


-- --
-- -- Name: book_author fk_ba_book; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.book_author
--     ADD CONSTRAINT fk_ba_book FOREIGN KEY (book_id) REFERENCES public.book(book_id);


-- --
-- -- Name: book fk_book_lang; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.book
--     ADD CONSTRAINT fk_book_lang FOREIGN KEY (language_id) REFERENCES public.book_language(language_id);


-- --
-- -- Name: book fk_book_pub; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.book
--     ADD CONSTRAINT fk_book_pub FOREIGN KEY (publisher_id) REFERENCES public.publisher(publisher_id);


-- --
-- -- Name: customer_address fk_ca_addr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.customer_address
--     ADD CONSTRAINT fk_ca_addr FOREIGN KEY (address_id) REFERENCES public.address(address_id);


-- --
-- -- Name: customer_address fk_ca_cust; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.customer_address
--     ADD CONSTRAINT fk_ca_cust FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


-- --
-- -- Name: order_history fk_oh_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.order_history
--     ADD CONSTRAINT fk_oh_order FOREIGN KEY (order_id) REFERENCES public.cust_order(order_id);


-- --
-- -- Name: order_history fk_oh_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.order_history
--     ADD CONSTRAINT fk_oh_status FOREIGN KEY (status_id) REFERENCES public.order_status(status_id);


-- --
-- -- Name: order_line fk_ol_book; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.order_line
--     ADD CONSTRAINT fk_ol_book FOREIGN KEY (book_id) REFERENCES public.book(book_id);


-- --
-- -- Name: order_line fk_ol_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.order_line
--     ADD CONSTRAINT fk_ol_order FOREIGN KEY (order_id) REFERENCES public.cust_order(order_id);


-- --
-- -- Name: cust_order fk_order_addr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.cust_order
--     ADD CONSTRAINT fk_order_addr FOREIGN KEY (dest_address_id) REFERENCES public.address(address_id);


-- --
-- -- Name: cust_order fk_order_cust; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.cust_order
--     ADD CONSTRAINT fk_order_cust FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


-- --
-- -- Name: cust_order fk_order_ship; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.cust_order
--     ADD CONSTRAINT fk_order_ship FOREIGN KEY (shipping_method_id) REFERENCES public.shipping_method(method_id);


-- --
-- -- Name: customer_address fkey_status_add; Type: FK CONSTRAINT; Schema: public; Owner: postgres
-- --

-- ALTER TABLE ONLY public.customer_address
--     ADD CONSTRAINT fkey_status_add FOREIGN KEY (status_id) REFERENCES public.address_status(status_id);


-- --
-- -- PostgreSQL database dump complete
-- --

