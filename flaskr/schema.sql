DROP TABLE IF EXISTS user; 
DROP TABLE IF EXISTS post; 

CREATE TABLE user (
	id INTEGER PRIMARY KEY AUTOINCREMENT, 
	username TEXT UNIQUE NOT NULL, 
	password TEXT NOT NULL 
);

CREATE TABLE post (
	id INTEGER PRIMARY KEY AUTOINCREMENT, 
	author_id INTEGER NOT NULL, 
	created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	title TEXT NOT NULL, 
	body TEXT NOT NULL, 
	likes INT NOT NULL DEFAULT 1,
	image TEXT DEFAULT NULL,  
	FOREIGN KEY (author_id) REFERENCES user (id)
);

CREATE TABLE likes (
	user_id INTEGER NOT NULL, 
	post_id INTEGER NOT NULL,
	FOREIGN KEY (user_id) REFERENCES user (id),
	FOREIGN KEY (post_id) REFERENCES post (id),
	PRIMARY KEY (user_id, post_id)
); 

CREATE TABLE c_likes (
	user_id INTEGER NOT NULL, 
	comment_id INTEGER NOT NULL,
	FOREIGN KEY (user_id) REFERENCES user (id),
	FOREIGN KEY (comment_id) REFERENCES comments (id),
	PRIMARY KEY (user_id, comment_id)
); 

CREATE TABLE comments (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	parent_id INTEGER DEFAULT NULL,
	post_id INTEGER,  
	body text NOT NULL, 
	author_id INTEGER NOT NULL, 
	created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
	likes INT NOT NULL DEFAULT 1,
	FOREIGN KEY (post_id) REFERENCES post (id), 
	FOREIGN KEY (parent_id) REFERENCES comments (id), 
	FOREIGN KEY (author_id) REFERENCES user (id)
);

CREATE TABLE children (
	parent_id INTEGER NOT NULL,
	child_id INTEGER NOT NULL,
	FOREIGN KEY (parent_id) REFERENCES comments (id),
	FOREIGN KEY (child_id) REFERENCES comments (id),
	PRIMARY KEY (parent_id, child_id)
);