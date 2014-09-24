import sqlite3

def _db_conn():
    connection = sqlite3.connect('.data.db')
    cursor = connection.cursor()
    return (connection, cursor)

def setup_users_table():
    (connection, cursor) = _db_conn()
    try:
        cursor.execute("CREATE TABLE IF NOT EXISTS users (username TEXT PRIMARY KEY, password TEXT)")
        connection.commit()
    finally:
        connection.close()

def verify_user_password(username, password):
    (connection, cursor) = _db_conn()
    try:
        cursor.execute('SELECT * FROM users WHERE username=? AND password=?', (username, password))
        return True if cursor.fetchone() else False
    finally:
        connection.close()

def create_user(username, password):
    (connection, cursor) = _db_conn()
    try:
        cursor.execute('SELECT * FROM users WHERE username=?', (username,))
        if cursor.fetchone():
            return False

        cursor.execute('INSERT INTO users VALUES (?, ?)', (username, password))
        connection.commit()
        return True
    finally:
        connection.close()
