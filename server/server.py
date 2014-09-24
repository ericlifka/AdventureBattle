from flask import Flask
from flask import render_template
from flask import request
from flask import make_response
from flask import session
import json
import authentication

app = Flask(__name__)

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

    if authentication.verify_user_password(username, password):
        session['username'] = username
        return make_response(('success', 200))
    else:
        return make_response(('unauthorized', 401))

@app.route("/register", methods=['POST'])
def register():
    username = request.form['username']
    password = request.form['password']

    if authentication.create_user(username, password):
        session['username'] = username
        return make_response(('success', 201))
    else:
        return make_response(('unauthorized', 401))

# putting secret key in source because TROLLOLOL:
app.secret_key = 'keep it secret, keep it safe'

if __name__ == "__main__":
    authentication.setup_users_table()
    app.run(debug=True)
