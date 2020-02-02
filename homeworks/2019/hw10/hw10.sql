CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size from dogs, sizes where height > min and height <= max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child from parents, dogs where name = parent order by height desc;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child as first, b.child as second 
    from parents as a, parents as b
    where first < second and a.parent = b.parent;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT first || " and " || second || " are " || a.size || " siblings"
    from siblings, size_of_dogs as a, size_of_dogs as b
    where a.name = first and b.name = second and a.size = b.size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
insert into stacks_helper select name as dogs, height as stack_height, height as last_height from dogs;
insert into stacks_helper
  select a.dogs || ", " || b.dogs, a.stack_height + b.stack_height, b.last_height
  from stacks_helper as a, stacks_helper as b
  where a.last_height < b.last_height and a.dogs <> b.dogs and b.last_height = b.stack_height;
insert into stacks_helper
  select a.dogs || ", " || b.dogs, a.stack_height + b.stack_height, b.last_height
  from stacks_helper as a, stacks_helper as b
  where a.last_height < b.last_height and a.dogs <> b.dogs and b.last_height = b.stack_height;
insert into stacks_helper
  select a.dogs || ", " || b.dogs, a.stack_height + b.stack_height, b.last_height
  from stacks_helper as a, stacks_helper as b
  where a.last_height < b.last_height and a.dogs <> b.dogs and b.last_height = b.stack_height;


CREATE TABLE stacks AS
  SELECT dogs, stack_height from stacks_helper where stack_height >= 170 order by stack_height asc;
