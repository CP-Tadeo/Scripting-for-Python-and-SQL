import mysql.connector

host = 'localhost'
user = 'root'
password = 'root'
database = 'misc'

connection = mysql.connector.connect(
    host=host,
    user=user,
    password=password,
    database=database
)

cursor = connection.cursor()

# select_query = 'SELECT * FROM users;'
# cursor.execute(select_query)

# # Step 10: Fetch and print the results
# results = cursor.fetchall()
# for row in results:
#     print(row)

    # Step 9: Execute the SELECT query and fetch the results
select_query = 'SELECT * FROM pokemon;'
cursor.execute(select_query)

# Step 10: Fetch and print the results
results = cursor.fetchall()
for row in results:
    print(row)