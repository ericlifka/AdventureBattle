import json

from flask import Flask
from flask import render_template
from flask import request
from flask import make_response
from flask import session

app = Flask(__name__)
users = {'test': '1234'}

@app.route("/")
def hello():
    return render_template('index.html')

@app.route("/session", methods=['GET'])
def checkSession():
    if 'username' not in session:
        return make_response(('Unauthorized', 401))
    else:
        return make_response((
            json.dumps({
                'username': session['username']
            }),
            201
        ))

@app.route("/login", methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    if username in users and users[username] == password:
        session['username'] = username
        return make_response(('success', 201))
    else:
        return make_response(('unauthorized', 401))

@app.route("/register", methods=['POST'])
def register():
    username = request.form['username']
    password = request.form['password']

    if username in users:
        return make_response(('unauthorized', 401))
    else:
        users[username] = password
        session['username'] = username
        return make_response(('success', 201))

# putting secret key in source because TROLLOLOL:
app.secret_key = 'keep it secret, keep it safe'

if __name__ == "__main__":
    app.run(debug=True)
