from flask import Flask, jsonify, request, redirect
from flask_cors import CORS, cross_origin

messages = [{"id": 1, "content": "SIUUUU"}, {"id": 2, "content": "idk"}]

api = Flask(__name__)
cors = CORS(api)
api.config['CORS_HEADERS'] = 'Content-Type'

@api.route('/', methods=['GET'])
@cross_origin()
def get_messages():
    return jsonify(messages)

@api.route('/new', methods=['POST'])
@cross_origin()
def post_message():
    content = request.form.get('content')
    print(content)
    return redirect("/", code=302)

if __name__ == '__main__':
    api.run(host='0.0.0.0', port=1234)