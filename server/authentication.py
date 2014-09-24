import sqlite3

def setup_users_table():
    connection = sqlite3.connect('.data.db')
    cursor = connection.cursor()

    cursor.execute("CREATE TABLE IF NOT EXISTS users (username TEXT PRIMARY KEY, password TEXT)")
    connection.commit()

def verify_user_password(username, password):
    connection = sqlite3.connect('.data.db')
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM users WHERE username=? AND password=?', (username, password))
    return True if cursor.fetchone() else False

def create_user(username, password):
    connection = sqlite3.connect('.data.db')
    cursor = connection.cursor()

    cursor.execute('SELECT * FROM users WHERE username=?', (username,))
    if cursor.fetchone():
        return False

    cursor.execute('INSERT INTO users VALUES (?, ?)', (username, password))
    connection.commit()
    return True
