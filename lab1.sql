SET LINESIZE 120
SET PAGESIZE 80
SET ECHO ON
SPOOL "C:\Users\Melody\Desktop\sad++\3\db2\lab1 Output.out"

-- 1: Display the structure of the MM_MEMBER table.
DESCRIBE mm_member;

-- 2: Add yourself as a member (populate only the first three columns).
INSERT INTO mm_member (member_id, last, first)
VALUES (15, 'Name', 'Name');

-- 3: Modify your membership by adding a made-up credit card number (following check constraint).
UPDATE mm_member
SET credit_card = '123456789012'
WHERE member_id = 15;

-- 4: Remove your membership.
DELETE FROM mm_member
WHERE member_id = 15;

-- 5: Save your data changes (assuming you're using a transaction and want to commit).
COMMIT;

-- 6: Display the title of each movie, the rental ID, and the last names of all members who have rented those movies using JOIN...ON.
SELECT mm_movie.movie_title, mm_rental.rental_id, mm_member.last
FROM mm_movie
JOIN mm_rental ON mm_movie.movie_id = mm_rental.movie_id
JOIN mm_member ON mm_rental.member_id = mm_member.member_id
ORDER BY mm_rental.rental_id;

-- 7: Display the title of each movie, the rental ID, and the last names of all members who have rented those movies using traditional join in WHERE clause.
SELECT mm_movie.movie_title, mm_rental.rental_id, mm_member.last
FROM mm_movie, mm_rental, mm_member
WHERE mm_movie.movie_id = mm_rental.movie_id
AND mm_rental.member_id = mm_member.member_id
ORDER BY mm_rental.rental_id;

-- 8: Create a new table called MY_TABLE.
CREATE TABLE MY_TABLE (
  MY_NUMBER NUMBER,
  MY_DATE DATE,
  MY_STRING VARCHAR2(5)
);

-- 9: Create a new sequence called seq_movie_id with a start value of 20 and an increment of 2.
CREATE SEQUENCE seq_movie_id
START WITH 20
INCREMENT BY 2;

-- 10: Display the sequence information (at least the last number and increment by) from the data dictionary's user_sequences view.
SELECT last_number, increment_by
FROM user_sequences
WHERE sequence_name = 'SEQ_MOVIE_ID';

-- 11: Display the next sequence number on the screen.
SELECT seq_movie_id.NEXTVAL FROM DUAL;

-- 12: Change the sequence created in Step 9 to increment by 5 instead of 2.
ALTER SEQUENCE seq_movie_id INCREMENT BY 5;

-- 13: Add your favorite movie to the MM_MOVIE table using the sequence created in Step 9 for the movie_id.
INSERT INTO mm_movie (movie_id, movie_title, movie_cat_id, movie_value, movie_qty)
VALUES (seq_movie_id.NEXTVAL, 'Your Favorite Movie', '1', 10.00, 1);

-- 14: Create a view named VW_MOVIE_RENTAL using the query from either Step 6 or Step 7.
CREATE VIEW VW_MOVIE_RENTAL AS
SELECT mm_movie.movie_title, mm_rental.rental_id, mm_member.last
FROM mm_movie
JOIN mm_rental ON mm_movie.movie_id = mm_rental.movie_id
JOIN mm_member ON mm_rental.member_id = mm_member.member_id;

-- 15: Use a query to display the data accessed by the VW_MOVIE_RENTAL view.
SELECT * FROM VW_MOVIE_RENTAL;

SPOOL OFF