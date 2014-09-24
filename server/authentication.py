import sqlite3
from contextlib import contextmanager

def _connect():
    return sqlite3.connect('.data.db')

@contextmanager
def _db_context(connection):
    try:
        yield None
    except:
        connection.rollback()
    else:
        connection.commit()
    finally:
        connection.close()

def setup_users_table():
    connection = _connect()
    with _db_context(connection):
        connection.execute("CREATE TABLE IF NOT EXISTS users (username TEXT PRIMARY KEY, password TEXT)")

def verify_user_password(username, password):
    connection = _connect()
    with _db_context(connection):
        cursor = connection.cursor()
        cursor.execute('SELECT * FROM users WHERE username=? AND password=?', (username, password))
        return True if cursor.fetchone() else False

def create_user(username, password):
    connection = _connect()
    with _db_context(connection):
        cursor = connection.cursor()
        cursor.execute('SELECT * FROM users WHERE username=?', (username,))
        if cursor.fetchone():
            return False

        connection.execute('INSERT INTO users VALUES (?, ?)', (username, password))
        return True
