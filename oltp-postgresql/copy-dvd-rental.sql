
COPY public.actor (actor_id, first_name, last_name, last_update) FROM 'home/3057.dat';
COPY public.category (category_id, name, last_update) FROM '/home/3059.dat';
COPY public.customer (customer_id, store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active) FROM '/home/3055.dat';


--be careful about foreign key constraints (checl the ER diagram to determine COPY order)
COPY public.country (country_id, country, last_update) FROM 'home/3069.dat';
COPY public.city (city_id, city, country_id, last_update) FROM 'home/3067.dat';
COPY public.address (address_id, address, address2, district, city_id, postal_code, phone, last_update) FROM '/home/3065.dat';


--films
COPY public.film (film_id, title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update, special_features, fulltext) FROM 'home/3061.dat';
COPY public.film_actor (actor_id, film_id, last_update) FROM '/home/3062.dat';
COPY public.film_category (film_id, category_id, last_update) FROM '/home/3063.dat';
COPY public.language (language_id, name, last_update) FROM '/home/3073.dat';

--inventory
COPY public.inventory (inventory_id, film_id, store_id, last_update) FROM '/home/3071.dat';

--staff, rentals and payment and store
COPY public.staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update, picture) FROM '/home/3079.dat';
COPY public.rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update) FROM '/home/3077.dat';
COPY public.payment (payment_id, customer_id, staff_id, rental_id, amount, payment_date) FROM '/home/3075.dat';
COPY public.store (store_id, manager_staff_id, address_id, last_update) FROM '/home/3081.dat';
