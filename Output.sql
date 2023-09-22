SQL> 
SQL> -- 1: Display the structure of the MM_MEMBER table.
SQL> DESCRIBE mm_member;
 Name                                                              Null?    Type
 ----------------------------------------------------------------- -------- --------------------------------------------
 MEMBER_ID                                                         NOT NULL NUMBER(4)
 LAST                                                                       VARCHAR2(12)
 FIRST                                                                      VARCHAR2(8)
 LICENSE_NO                                                                 VARCHAR2(9)
 LICENSE_ST                                                                 VARCHAR2(2)
 CREDIT_CARD                                                                VARCHAR2(12)
 SUSPENSION                                                                 VARCHAR2(1)
 MAILING_LIST                                                               VARCHAR2(1)

SQL> 
SQL> -- 2: Add yourself as a member (populate only the first three columns).
SQL> INSERT INTO mm_member (member_id, last, first)
  2  VALUES (15, 'Name', 'Name');

1 row created.

SQL> 
SQL> -- 3: Modify your membership by adding a made-up credit card number (following check constraint).
SQL> UPDATE mm_member
  2  SET credit_card = '123456789012'
  3  WHERE member_id = 15;

1 row updated.

SQL> 
SQL> -- 4: Remove your membership.
SQL> DELETE FROM mm_member
  2  WHERE member_id = 15;

1 row deleted.

SQL> 
SQL> -- 5: Save your data changes (assuming you're using a transaction and want to commit).
SQL> COMMIT;

Commit complete.

SQL> 
SQL> -- 6: Display the title of each movie, the rental ID, and the last names of all members who have rented those movies using JOIN...ON.
SQL> SELECT mm_movie.movie_title, mm_rental.rental_id, mm_member.last
  2  FROM mm_movie
  3  JOIN mm_rental ON mm_movie.movie_id = mm_rental.movie_id
  4  JOIN mm_member ON mm_rental.member_id = mm_member.member_id
  5  ORDER BY mm_rental.rental_id;

MOVIE_TITLE                               RENTAL_ID LAST                                                                
---------------------------------------- ---------- ------------                                                        
Deep Blue Sea                                     1 Tangier                                                             
Duck Soup                                         2 Tangier                                                             
The good, the bad and the ugly                    3 Maulder                                                             
Star Wars                                         4 Wild                                                                
Jaws                                              5 Wild                                                                
Deep Blue Sea                                     6 Wild                                                                
Waking Ned Devine                                 7 Casteel                                                             
Silverado                                         8 Casteel                                                             
Texas Chainsaw Masacre                            9 Maulder                                                             
The Fifth Element                                10 Maulder                                                             
Star Wars                                        11 Maulder                                                             
Texas Chainsaw Masacre                           12 Wild                                                                

12 rows selected.

SQL> 
SQL> -- 7: Display the title of each movie, the rental ID, and the last names of all members who have rented those movies using traditional join in WHERE clause.
SQL> SELECT mm_movie.movie_title, mm_rental.rental_id, mm_member.last
  2  FROM mm_movie, mm_rental, mm_member
  3  WHERE mm_movie.movie_id = mm_rental.movie_id
  4  AND mm_rental.member_id = mm_member.member_id
  5  ORDER BY mm_rental.rental_id;

MOVIE_TITLE                               RENTAL_ID LAST                                                                
---------------------------------------- ---------- ------------                                                        
Deep Blue Sea                                     1 Tangier                                                             
Duck Soup                                         2 Tangier                                                             
The good, the bad and the ugly                    3 Maulder                                                             
Star Wars                                         4 Wild                                                                
Jaws                                              5 Wild                                                                
Deep Blue Sea                                     6 Wild                                                                
Waking Ned Devine                                 7 Casteel                                                             
Silverado                                         8 Casteel                                                             
Texas Chainsaw Masacre                            9 Maulder                                                             
The Fifth Element                                10 Maulder                                                             
Star Wars                                        11 Maulder                                                             
Texas Chainsaw Masacre                           12 Wild                                                                

12 rows selected.

SQL> 
SQL> -- 8: Create a new table called MY_TABLE.
SQL> CREATE TABLE MY_TABLE (
  2    MY_NUMBER NUMBER,
  3    MY_DATE DATE,
  4    MY_STRING VARCHAR2(5)
  5  );
CREATE TABLE MY_TABLE (
             *
ERROR at line 1:
ORA-00955: name is already used by an existing object 


SQL> 
SQL> -- 9: Create a new sequence called seq_movie_id with a start value of 20 and an increment of 2.
SQL> CREATE SEQUENCE seq_movie_id
  2  START WITH 20
  3  INCREMENT BY 2;
CREATE SEQUENCE seq_movie_id
                *
ERROR at line 1:
ORA-00955: name is already used by an existing object 


SQL> 
SQL> -- 10: Display the sequence information (at least the last number and increment by) from the data dictionary's user_sequences view.
SQL> SELECT last_number, increment_by
  2  FROM user_sequences
  3  WHERE sequence_name = 'SEQ_MOVIE_ID';

LAST_NUMBER INCREMENT_BY                                                                                                
----------- ------------                                                                                                
        440            5                                                                                                

SQL> 
SQL> -- 11: Display the next sequence number on the screen.
SQL> SELECT seq_movie_id.NEXTVAL FROM DUAL;

   NEXTVAL                                                                                                              
----------                                                                                                              
       440                                                                                                              

SQL> 
SQL> -- 12: Change the sequence created in Step 9 to increment by 5 instead of 2.
SQL> ALTER SEQUENCE seq_movie_id INCREMENT BY 5;

Sequence altered.

SQL> 
SQL> -- 13: Add your favorite movie to the MM_MOVIE table using the sequence created in Step 9 for the movie_id.
SQL> INSERT INTO mm_movie (movie_id, movie_title, movie_cat_id, movie_value, movie_qty)
  2  VALUES (seq_movie_id.NEXTVAL, 'Your Favorite Movie', '1', 10.00, 1);

1 row created.

SQL> 
SQL> -- 14: Create a view named VW_MOVIE_RENTAL using the query from either Step 6 or Step 7.
SQL> CREATE VIEW VW_MOVIE_RENTAL AS
  2  SELECT mm_movie.movie_title, mm_rental.rental_id, mm_member.last
  3  FROM mm_movie
  4  JOIN mm_rental ON mm_movie.movie_id = mm_rental.movie_id
  5  JOIN mm_member ON mm_rental.member_id = mm_member.member_id;
CREATE VIEW VW_MOVIE_RENTAL AS
            *
ERROR at line 1:
ORA-00955: name is already used by an existing object 


SQL> 
SQL> -- 15: Use a query to display the data accessed by the VW_MOVIE_RENTAL view.
SQL> SELECT * FROM VW_MOVIE_RENTAL;

MOVIE_TITLE                               RENTAL_ID LAST                                                                
---------------------------------------- ---------- ------------                                                        
Star Wars                                         4 Wild                                                                
Star Wars                                        11 Maulder                                                             
Texas Chainsaw Masacre                            9 Maulder                                                             
Texas Chainsaw Masacre                           12 Wild                                                                
Jaws                                              5 Wild                                                                
The good, the bad and the ugly                    3 Maulder                                                             
Silverado                                         8 Casteel                                                             
Duck Soup                                         2 Tangier                                                             
Waking Ned Devine                                 7 Casteel                                                             
Deep Blue Sea                                     1 Tangier                                                             
Deep Blue Sea                                     6 Wild                                                                
The Fifth Element                                10 Maulder                                                             

12 rows selected.

SQL> 
SQL> -- 16: Make the VW_MOVIE_RENTAL view read-only.
SQL> CREATE OR REPLACE VIEW VW_MOVIE_RENTAL AS
  2  SELECT mm_movie.movie_title, mm_rental.rental_id, mm_member.last
  3  FROM mm_movie
  4  JOIN mm_rental ON mm_movie.movie_id = mm_rental.movie_id
  5  JOIN mm_member ON mm_rental.member_id = mm_member.member_id
  6  WITH READ ONLY;

View created.

SQL> 
SQL> -- 17: Using the VW_MOVIE_RENTAL view in Step 14, change the last name of the member who rented the movie with the ID of 2 to "Tangier 1."
SQL> -- 17: Using the VW_MOVIE_RENTAL view in Step 16, change the last name of the member who rented the movie with the ID of 2 to "Tangier 1."
SQL> UPDATE VW_MOVIE_RENTAL
  2  SET last = 'Tangier 1'
  3  	 WHERE rental_id = 2;
SET last = 'Tangier 1'
    *
ERROR at line 2:
ORA-42399: cannot perform a DML operation on a read-only view 


SQL> 
SQL> 
SQL> SPOOL OFF
