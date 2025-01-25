
SELECT * FROM mysql.user; 

CREATE USER 'user_morador'@'localhost' IDENTIFIED by 'user_morador';

GRANT SELECT ON *.* to 'user_morador'@'localhost';

CREATE USER 'user_administrador'@'localhost' IDENTIFIED by 'user_administrador';

GRANT ALL PRIVILEGES ON *.* TO 'user_administrador'@'localhost';

CREATE USER 'user_sindico'@'localhost' IDENTIFIED by 'user_sindico';

GRANT ALL PRIVILEGES ON *.* TO 'user_sindico'@'localhost';
