from flask import Flask
from flask import render_template
from flask import request
from flask import make_response

app = Flask(__name__)

users = {'test': '1234'}

@app.route("/")
def hello():
    return render_template('index.html')

@app.route("/login", methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']

    if username in users and users[username] == password:
        return make_response(('success', '201'))
    else:
        return make_response(('Unauthorized', 401))

if __name__ == "__main__":
    app.run(debug=True)
