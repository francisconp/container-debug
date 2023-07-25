#!/usr/bin/python

# Franciscon P. dos Santos
# francisconp@gmail.com

from flask import Flask, render_template
from socket import gethostname
from os import environ

app = Flask(__name__)

default_port = environ.get('PORT',8080)

@app.route('/<path:path>')
def static_file(path):
    return app.send_static_file(path)

@app.route("/")
def root():
    var_hostname = gethostname()
    msgs = { "hostname" : var_hostname,
             "port": default_port }
    return render_template('index.html', msgs=msgs)

@app.route("/hostname")
def hostname():
    var_hostname = gethostname()
    return var_hostname

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=int(default_port),debug=True)
