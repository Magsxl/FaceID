from flask import Flask
from flask.wrappers import Response
import git

app = Flask(__name__)

@app.route('/git_update', methods=['POST'])
def git_update():
    repo = git.Repo('./FaceID')
    origin = repo.remotes.origin
    repo.create_head('master', origin.refs.master).set_tracking_branch(origin.refs.master).checkout()
    origin.pull()
    return '', 200
    
@app.route("/", methods=['GET'])
def home():
    return "Hello world!"

if __name__ == '__main__':
    app.run(debug=True)