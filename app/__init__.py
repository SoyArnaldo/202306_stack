

import os


from flask import Flask


app = Flask(__name__)


from dotenv import load_dotenv


load_dotenv()


app.secret_key = os.getenv("SECRET_KEY")