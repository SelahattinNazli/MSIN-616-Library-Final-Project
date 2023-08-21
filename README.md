## Touro University Graduate School of Technology
## MSIN 616 - Advanced Database Mangement Course Final Project


This is a simple database that can be used to maintain the data stored and processed by a lending library. In this database, it is aimed to create a real data library database with all its features.



## Library Queries

### Query 1
List the title of the book that is the most popular book to be borrowed.(Namely, it has been borrowed most often number of times)

'''sql
SELECT B.Title, COUNT(Borrowed_id) AS Count_of_Borrowed
FROM Books_Borrowed BB
INNER JOIN BookCopies BC ON BC.Copy_id = BB.Copy_id
INNER JOIN Books B ON B.Book_id = BC.Book_id
GROUP BY B.Title
HAVING COUNT(Borrowed_id) >= ALL
                        (
                         SELECT  COUNT(Borrowed_id) AS Count_of_Borrowed
                         FROM Books_Borrowed BB
                         INNER JOIN BookCopies BC ON BC.Copy_id = BB.Copy_id
                         INNER JOIN Books B ON B.Book_id = BC.Book_id
                         GROUP BY B.Title
                        )
'''
