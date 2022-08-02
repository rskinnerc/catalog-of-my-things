CREATE TABLE authors (
  id INT GENERATED ALWAYS AS IDENTITY UNIQUE,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE games (
  id INT UNIQUE,
  multiplayer BOOLEAN,
  last_played_at DATE,
  PRIMARY KEY (id),
  CONSTRAINT fk_items_id FOREIGN KEY (id) REFERENCES items(id)
);

CREATE TABLE books (
	id INT UNIQUE,
	publisher	varchar(50), 
	cover_state	varchar(50), 
	PRIMARY KEY(id),
  CONSTRAINT fk_items_id FOREIGN KEY (id) REFERENCES items(id)
)

CREATE TABLE labels (
	id INT GENERATED ALWAYS AS IDENTITY,
	title	varchar(50),
	color	varchar(50)
)