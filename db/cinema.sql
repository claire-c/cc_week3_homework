DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE screenings (
  id SERIAL4 PRIMARY KEY,
  time VARCHAR(255),
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  remaining_tickets INT
);

CREATE TABLE tickets (
id SERIAL4 PRIMARY KEY,
film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE
);
