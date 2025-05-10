DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;

CREATE TABLE roles(
id 			SERIAL PRIMARY KEY,
name 		VARCHAR(20)
);

CREATE TABLE users(
id 			SERIAL PRIMARY KEY,
username 		VARCHAR(20),
password 	VARCHAR(100)
);

CREATE TABLE user_roles (
    user_id INT REFERENCES users(id),
    role_id INT REFERENCES roles(id)
);

-- Insert initial roles
INSERT INTO roles (name) VALUES ('ROLE_USER');
INSERT INTO roles (name) VALUES ('ROLE_ADMIN');

-- Insert regular user (password: user123)
INSERT INTO users (username, password) 
VALUES ('user', '$2a$10$FzS20OfAGFzbahGSJZ.neuHUCR1L.8HuLO4vWG3HPrw8zZvgsaTd6');

-- Insert admin user (password: admin123)
INSERT INTO users (username, password) 
VALUES ('admin', '$2a$10$YSi/dM9AveHwQICCkaxVZeAsj8N7XctiuulsZ4jWYYpaaFdSmtRUy');

-- Assign roles
INSERT INTO user_roles (user_id, role_id) VALUES ((SELECT id FROM users WHERE username = 'user'), (SELECT id FROM roles WHERE name = 'ROLE_USER'));
INSERT INTO user_roles (user_id, role_id) VALUES ((SELECT id FROM users WHERE username = 'admin'), (SELECT id FROM roles WHERE name = 'ROLE_ADMIN'));

--INSERT INTO user_roles (user_id, role_id) VALUES (1, 1); -- Usuario 'user' tiene el rol 'ROLE_USER'
--INSERT INTO user_roles (user_id, role_id) VALUES (2, 2); -- Usuario 'admin' tiene el rol 'ROLE_ADMIN'

SELECT * FROM roles;
SELECT * FROM users;
SELECT * FROM user_roles;

