/*
 *  create table users with simple 2 columns
 */
CREATE TABLE users (
  id   int         AUTO_INCREMENT PRIMARY KEY,
  name varchar(8)  NOT NULL
);

/*
 *  insert the first row in the table
 */
INSERT INTO users(name) VALUES ('a');

/*
 *  this inserts one row in the table `users`.
 *  because ID is not passed as the parameter, default auto incremented ID is generated and used
 *  which leads to the following table structure
 */

```
mysql> select * from users;
+----+------+
| id | name |
+----+------+
|  1 | a    |
+----+------+
1 row in set (0.00 sec
```

/*
 *  insert another row in the table without passing any ID
 */
INSERT INTO users(name) VALUES ('b');

/*
 *  we not have two rows in the table with IDs 1 and 2
 *  if we continue to insert rows the ID column continues to increase
 *  from 1, 2, 3, ... and so on
 */

```
mysql> select * from users;
+----+------+
| id | name |
+----+------+
|  1 | a    |
|  2 | b    |
+----+------+
2 rows in set (0.00 sec)
```

/*
 *  now let's insert a high value breaking the sequence and see what happens
 */

INSERT INTO users(id, name) VALUES (100, 'c');

/*
 *  we see that the row with name `c` and id `100` is inserted in the table
 */

```
mysql> select * from users;
+-----+------+
| id  | name |
+-----+------+
|   1 | a    |
|   2 | b    |
| 100 | c    |
+-----+------+
3 rows in set (0.00 sec)
```

/*
 *  now if we insert another row without specifying the ID, what ID would it insert
 */

INSERT INTO users(name) VALUES ('d');

/*
 *  we see that the row with name `d` and id `101` is inserted in the table
 *  this shows that auto incrementing sequence is updated when we insert the row
 *  while specifying the ID
 */

```
mysql> select * from users;
+-----+------+
| id  | name |
+-----+------+
|   1 | a    |
|   2 | b    |
| 100 | c    |
| 101 | d    |
+-----+------+
4 rows in set (0.00 sec)
```

/*
 *  The type of the `id` columns is `int` and its limit 2147483647
 *  The value 2147483647 is actually 2^31 − 1 which indicates the number is a signed integer
 *  with width of 32 bits. Hence the limits are -2147483648 to 2147483647
 *  as specified in https://dev.mysql.com/doc/refman/8.0/en/integer-types.html
 *  Let's try to insert a row with id = 2147483647
 */

INSERT INTO users(id, name) VALUES (2147483647, 'e');


/*
 *  We see that the row with the ID 2147483647 is inserted successfully. The output
 *  SELECT * is as shown.
 */

```
mysql> select * from users;
+------------+------+
| id         | name |
+------------+------+
|          1 | a    |
|          2 | b    |
|        100 | c    |
|        101 | d    |
| 2147483647 | e    |
+------------+------+
5 rows in set (0.00 sec)
```

/*
 *  Now that our ID column which is auto-increment int (signed by default) has hit its max value
 *  what would happen when we try to insert a new row without specifying the ID?
 */

INSERT INTO users(name) VALUES ('f');

/*
 *  We get an error
 */

```
mysql> INSERT INTO users(name) VALUES ('f');
ERROR 1062 (23000): Duplicate entry '2147483647' for key 'users.PRIMARY'
```

/*
 *  When we are inserting the record without ID, the database engine is trying to
 *  auto increment the ID. because we are at the max value of 2147483647, the auto increment
 *  is not able to go beyond it.
 *
 *  In MySQL 8, it throws an error stating 
 *
 *     ERROR 1062 (23000): Duplicate entry '2147483647' for key 'users.PRIMARY'
 *
 *  which means after an auto increment ID reaches its max value it stays there
 *  and when DB is trying to use the same ID to insert the row, it is breaking the
 *  unique constraint on the primary key.
 */
