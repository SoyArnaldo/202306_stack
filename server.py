

from app import app


from app.controllers.login import index
from app.controllers.login import register
from app.controllers.login import login
from app.controllers.login import logout


if __name__ == "__main__":
    app.run(debug=True, port=5000)