from flask import Flask
from flask import send_from_directory
from flask import render_template

app = Flask(__name__)

FLUTTER_WEB_APP = 'templates'

@app.route("/web/", methods=['GET'])
def render_page_web():
    return render_template('index.html')

@app.route("/web/<path:name>")
def return_flutter_doc(name):
    datalist = str(name).split('/')
    DIR_NAME = FLUTTER_WEB_APP

    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            DIR_NAME += '/' + datalist[i]
    
    return send_from_directory(DIR_NAME, datalist[-1])

@app.route("/")
def render_page():
    return render_template('/index.html')

if __name__ == '__main__':
    app.run(debug=True)