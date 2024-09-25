#!/usr/bin/env bash

user=$(id -nu)
echo "Defaults:$user !authenticate" | sudo tee -a /etc/sudoers

# Update and upgrade the system
sudo apt-get update -y
sudo apt-get upgrade -y
# Install PostgreSQL client and Python3
sudo apt-get install postgresql-client -y
sudo apt-get install python3 python3-pip -y
sudo apt-get install vim curl -y
# Install psycopg2 library for PostgreSQL interaction
pip3 install psycopg2-binary

# Define the PostgreSQL connection details
cat << EOF >> ~/.bashrc
export PGPASSWORD=$DB_PASSWORD
export PGUSER=$DB_USER
export PGHOST=$DB_HOST
export PGDATABSE=$DB_NAME
EOF
source ~/.bashrc

psql -c "DROP TABLE IF EXISTS person"

psql -c "
CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT
);

INSERT INTO person (first_name, last_name, age) VALUES
('Alice', 'Smith', 30),
('Bob', 'Johnson', 25),
('Charlie', 'Brown', 35),
('Daisy', 'Miller', 28),
('Edward', 'Wilson', 40);
"
