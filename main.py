import psycopg2


# Connect to the PostgreSQL database
try:
    connection = psycopg2.connect()
    cursor = connection.cursor()
    
    # Execute a query to retrieve all rows from the 'person' table
    cursor.execute("SELECT * FROM person where age > 8 ORDER BY age ASC")
    
    # Fetch all rows from the query result
    rows = cursor.fetchall()
    
    # Print the column names
    column_names = [desc[0] for desc in cursor.description]
    print(column_names)
    
    # Print each row in the 'person' table
    for row in rows:
        print(row)

except Exception as e:
    print(f"An error occurred: {e}")
finally:
    # Close the database connection
    if connection:
        cursor.close()
        connection.close()
