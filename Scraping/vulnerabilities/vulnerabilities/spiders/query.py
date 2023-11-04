import sqlite3
connection = sqlite3.connect("vuln.db")
cursor = connection.cursor()
connection.commit()
select_query = 'SELECT * from vulns'
for result in cursor.execute(select_query):
    print(result)