.read lab12.sql

CREATE TABLE smallest_int_having AS
  SELECT time, smallest FROM students GROUP BY smallest HAVING count(*) = 1;

CREATE TABLE fa19favpets AS
  SELECT pet, count(*) as count FROM students GROUP BY pet ORDER BY count DESC LIMIT 10;


CREATE TABLE fa19dog AS
  SELECT pet, count(*) as count FROM students GROUP BY pet HAVING pet = "dog";


CREATE TABLE obedienceimages AS
  SELECT seven, instructor, count(*) from students where seven = "7" group by instructor;
