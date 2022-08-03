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

-- Music_albums and genres

CREATE TABLE music_albums(
  id INT PRIMARY KEY,
  on_spotify BOOLEAN,
  publish_date DATE,
  archived BOOLEAN,
  label_id INT,
  source_id INT,
  author_id INT,
  genre_id INT,
  CONSTRAINT fk_label_id FOREIGN KEY (label_id) REFERENCES label(id)
  CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES source(id)
  CONSTRAINT fk_author_id FOREIGN KEY (author_id) REFERENCES author(id)
  CONSTRAINT fk_genre_id FOREIGN KEY (genre_id) REFERENCES genre(id)
)

CREATE TABLE genres(
  id INT PRIMARY KEY,
  name varchar(50),
)