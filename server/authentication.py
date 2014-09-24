import sqlite3
from contextlib import contextmanager

def _connect():
    return sqlite3.connect('.data.db')

@contextmanager
def _db_context():
    connection = _connect()
    try:
        yield connection
    except:
        connection.rollback()
    else:
        connection.commit()
    finally:
        connection.close()

def setup_users_table():
    with _db_context() as connection:
        connection.execute("CREATE TABLE IF NOT EXISTS users (username TEXT PRIMARY KEY, password TEXT)")

def verify_user_password(username, password):
    with _db_context() as connection:
        cursor = connection.cursor()
        cursor.execute('SELECT * FROM users WHERE username=? AND password=?', (username, password))
        return True if cursor.fetchone() else False

def create_user(username, password):
    with _db_context() as connection:
        cursor = connection.cursor()
        cursor.execute('SELECT * FROM users WHERE username=?', (username,))
        if cursor.fetchone():
            return False

        connection.execute('INSERT INTO users VALUES (?, ?)', (username, password))
        return True
