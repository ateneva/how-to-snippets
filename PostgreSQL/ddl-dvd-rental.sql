DROP TYPE IF EXISTS public.mpaa_rating;
CREATE TYPE public.mpaa_rating AS ENUM (
    'G',
    'PG',
    'PG-13',
    'R',
    'NC-17'
);
ALTER TYPE public.mpaa_rating OWNER TO ateneva;


--
-- CREATE DOMAINS
--

DROP DOMAIN IF EXISTS public.year;
CREATE DOMAIN public.year AS integer
	CONSTRAINT year_check CHECK (((VALUE >= 1901) AND (VALUE <= 2155)));
ALTER DOMAIN public.year OWNER TO ateneva;


--
-- CREATE SEQUENCES AND TABLES
--

DROP TABLE IF EXISTS public.customer;
DROP SEQUENCE IF EXISTS public.customer_customer_id_seq;
CREATE SEQUENCE public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.customer_customer_id_seq OWNER TO ateneva;

SET default_tablespace = '';
SET default_with_oids = false;

DROP TABLE IF EXISTS public.customer;
CREATE TABLE public.customer (
    customer_id integer DEFAULT nextval('public.customer_customer_id_seq'::regclass) NOT NULL,
    store_id smallint NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(50),
    address_id smallint NOT NULL,
    activebool boolean DEFAULT true NOT NULL,
    create_date date DEFAULT ('now'::text)::date NOT NULL,
    last_update timestamp without time zone DEFAULT now(),
    active integer
);
ALTER TABLE public.customer OWNER TO ateneva;

DROP TABLE IF EXISTS public.actor;
DROP SEQUENCE IF EXISTS public.actor_actor_id_seq;
CREATE SEQUENCE public.actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.actor_actor_id_seq OWNER TO ateneva;


DROP TABLE IF EXISTS public.actor;
CREATE TABLE public.actor (
    actor_id integer NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.actor OWNER TO ateneva;


CREATE SEQUENCE public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.category_category_id_seq OWNER TO ateneva;

CREATE TABLE public.category (
    category_id integer DEFAULT nextval('public.category_category_id_seq'::regclass) NOT NULL,
    name character varying(25) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.category OWNER TO ateneva;


CREATE SEQUENCE public.film_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.film_film_id_seq OWNER TO ateneva;

CREATE TABLE public.film (
    film_id integer DEFAULT nextval('public.film_film_id_seq'::regclass) NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    release_year public.year,
    language_id smallint NOT NULL,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length smallint,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating public.mpaa_rating DEFAULT 'G'::public.mpaa_rating,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    special_features text[],
    fulltext tsvector NOT NULL
);
ALTER TABLE public.film OWNER TO ateneva;

CREATE TABLE public.film_actor (
    actor_id smallint NOT NULL,
    film_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.film_actor OWNER TO ateneva;


CREATE TABLE public.film_category (
    film_id smallint NOT NULL,
    category_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.film_category OWNER TO ateneva;


CREATE SEQUENCE public.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.address_address_id_seq OWNER TO ateneva;
CREATE TABLE public.address (
    address_id integer DEFAULT nextval('public.address_address_id_seq'::regclass) NOT NULL,
    address character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.address OWNER TO ateneva;


CREATE SEQUENCE public.city_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.city_city_id_seq OWNER TO ateneva;
CREATE TABLE public.city (
    city_id integer DEFAULT nextval('public.city_city_id_seq'::regclass) NOT NULL,
    city character varying(50) NOT NULL,
    country_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.city OWNER TO ateneva;

CREATE SEQUENCE public.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.country_country_id_seq OWNER TO ateneva;
CREATE TABLE public.country (
    country_id integer DEFAULT nextval('public.country_country_id_seq'::regclass) NOT NULL,
    country character varying(50) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.country OWNER TO ateneva;

--
-- Name: customer_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.customer_list AS
 SELECT cu.customer_id AS id,
    (((cu.first_name)::text || ' '::text) || (cu.last_name)::text) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
        CASE
            WHEN cu.activebool THEN 'active'::text
            ELSE ''::text
        END AS notes,
    cu.store_id AS sid
   FROM (((public.customer cu
     JOIN public.address a ON ((cu.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));
ALTER TABLE public.customer_list OWNER TO ateneva;

--
-- Name: film_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.film_list AS
 SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    NULL AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;
ALTER TABLE public.film_list OWNER TO ateneva;

--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventory_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.inventory_inventory_id_seq OWNER TO ateneva;

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    inventory_id integer DEFAULT nextval('public.inventory_inventory_id_seq'::regclass) NOT NULL,
    film_id smallint NOT NULL,
    store_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.inventory OWNER TO ateneva;

--
-- Name: language_language_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.language_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.language_language_id_seq OWNER TO ateneva;

CREATE TABLE public.language (
    language_id integer DEFAULT nextval('public.language_language_id_seq'::regclass) NOT NULL,
    name character(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.language OWNER TO ateneva;


CREATE VIEW public.nicer_but_slower_film_list AS
 SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    NULL AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;

ALTER TABLE public.nicer_but_slower_film_list OWNER TO ateneva;


CREATE SEQUENCE public.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.payment_payment_id_seq OWNER TO ateneva;
CREATE TABLE public.payment (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id smallint NOT NULL,
    staff_id smallint NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp without time zone NOT NULL
);
ALTER TABLE public.payment OWNER TO ateneva;


CREATE SEQUENCE public.rental_rental_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rental_rental_id_seq OWNER TO ateneva;
CREATE TABLE public.rental (
    rental_id integer DEFAULT nextval('public.rental_rental_id_seq'::regclass) NOT NULL,
    rental_date timestamp without time zone NOT NULL,
    inventory_id integer NOT NULL,
    customer_id smallint NOT NULL,
    return_date timestamp without time zone,
    staff_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.rental OWNER TO ateneva;


CREATE VIEW public.sales_by_film_category AS
 SELECT c.name AS category,
    sum(p.amount) AS total_sales
   FROM (((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.film f ON ((i.film_id = f.film_id)))
     JOIN public.film_category fc ON ((f.film_id = fc.film_id)))
     JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY c.name
  ORDER BY (sum(p.amount)) DESC;
ALTER TABLE public.sales_by_film_category OWNER TO ateneva;


CREATE SEQUENCE public.staff_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.staff_staff_id_seq OWNER TO ateneva;
CREATE TABLE public.staff (
    staff_id integer DEFAULT nextval('public.staff_staff_id_seq'::regclass) NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    address_id smallint NOT NULL,
    email character varying(50),
    store_id smallint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(40),
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    picture bytea
);
ALTER TABLE public.staff OWNER TO ateneva;


CREATE SEQUENCE public.store_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.store_store_id_seq OWNER TO ateneva;

CREATE TABLE public.store (
    store_id integer DEFAULT nextval('public.store_store_id_seq'::regclass) NOT NULL,
    manager_staff_id smallint NOT NULL,
    address_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);
ALTER TABLE public.store OWNER TO ateneva;


CREATE VIEW public.sales_by_store AS
 SELECT (((c.city)::text || ','::text) || (cy.country)::text) AS store,
    (((m.first_name)::text || ' '::text) || (m.last_name)::text) AS manager,
    sum(p.amount) AS total_sales
   FROM (((((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.store s ON ((i.store_id = s.store_id)))
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city c ON ((a.city_id = c.city_id)))
     JOIN public.country cy ON ((c.country_id = cy.country_id)))
     JOIN public.staff m ON ((s.manager_staff_id = m.staff_id)))
  GROUP BY cy.country, c.city, s.store_id, m.first_name, m.last_name
  ORDER BY cy.country, c.city;


ALTER TABLE public.sales_by_store OWNER TO ateneva;

--
-- Name: staff_list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.staff_list AS
 SELECT s.staff_id AS id,
    (((s.first_name)::text || ' '::text) || (s.last_name)::text) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
    s.store_id AS sid
   FROM (((public.staff s
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));

ALTER TABLE public.staff_list OWNER TO ateneva;

--
-- CREATE PRIMARY KEY CONSTARINTS
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id);

ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id);

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);


ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (language_id);

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);



--
-- CREATE FOREIGN KEY CONSTRAINTS
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) 
    REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) 
    REFERENCES public.actor(actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) 
    REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) 
    REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) 
    REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) 
    REFERENCES public.language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.address
    ADD CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES public.city(city_id);


ALTER TABLE ONLY public.city
    ADD CONSTRAINT fk_city FOREIGN KEY (country_id) REFERENCES public.country(country_id);


ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) 
    REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_customer_id_fkey FOREIGN KEY (customer_id) 
    REFERENCES public.customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_rental_id_fkey FOREIGN KEY (rental_id) 
    REFERENCES public.rental(rental_id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_staff_id_fkey FOREIGN KEY (staff_id) 
    REFERENCES public.staff(staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (customer_id) 
    REFERENCES public.customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) 
    REFERENCES public.inventory(inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_staff_id_key FOREIGN KEY (staff_id) 
    REFERENCES public.staff(staff_id);


ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) 
    REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) 
    REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_manager_staff_id_fkey FOREIGN KEY (manager_staff_id) 
    REFERENCES public.staff(staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- CREATE INDEXES
--

CREATE INDEX film_fulltext_idx 
    ON public.film USING gist (fulltext);


CREATE INDEX idx_actor_last_name 
    ON public.actor USING btree (last_name);


CREATE INDEX idx_fk_address_id 
    ON public.customer USING btree (address_id);


CREATE INDEX idx_fk_city_id 
    ON public.address USING btree (city_id);


CREATE INDEX idx_fk_country_id 
    ON public.city USING btree (country_id);


CREATE INDEX idx_fk_customer_id 
    ON public.payment USING btree (customer_id);

CREATE INDEX idx_fk_film_id 
    ON public.film_actor USING btree (film_id);


CREATE INDEX idx_fk_inventory_id 
    ON public.rental USING btree (inventory_id);


CREATE INDEX idx_fk_language_id 
    ON public.film USING btree (language_id);


CREATE INDEX idx_fk_rental_id 
    ON public.payment USING btree (rental_id);


CREATE INDEX idx_fk_staff_id 
    ON public.payment USING btree (staff_id);


CREATE INDEX idx_fk_store_id 
    ON public.customer USING btree (store_id);


CREATE INDEX idx_last_name 
    ON public.customer USING btree (last_name);

CREATE INDEX idx_store_id_film_id 
    ON public.inventory USING btree (store_id, film_id);


CREATE INDEX idx_title 
    ON public.film USING btree (title);

CREATE UNIQUE INDEX idx_unq_manager_staff_id 
    ON public.store USING btree (manager_staff_id);


CREATE UNIQUE INDEX idx_unq_rental_rental_date_inventory_id_customer_id 
    ON public.rental USING btree (rental_date, inventory_id, customer_id);


--
-- CREATE FUNCTIONS
--

CREATE FUNCTION public.last_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$;
ALTER FUNCTION public.last_updated() OWNER TO ateneva;

--
-- CREATE TRIGGERS
--

CREATE TRIGGER film_fulltext_trigger 
BEFORE INSERT OR UPDATE ON public.film FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.actor FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.address FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.category FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.city FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.country FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.customer FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.film FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.film_actor FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.film_category FOR EACH ROW EXECUTE PROCEDURE public.last_updated();

CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.inventory FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.language FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.rental FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.staff FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


CREATE TRIGGER last_updated 
BEFORE UPDATE ON public.store FOR EACH ROW EXECUTE PROCEDURE public.last_updated();
