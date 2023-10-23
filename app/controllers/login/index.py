
# App config
from app import app

# Flask
from flask import render_template


@app.route("/")
def index():

    return render_template("login/index.html")
