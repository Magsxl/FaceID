from flask import Flask
from flask.wrappers import Response

app = Flask(__name__)

@app.route("/", methods=['GET'])
def home():
    return "dupa"

if __name__ == '__main__':
    app.run(debug=True)