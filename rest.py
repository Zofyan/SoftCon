from flask import Flask, jsonify, request, redirect

messages = [{"id": 1, "content": "SIUUUU"}, {"id": 2, "content": "idk"}]

api = Flask(__name__)

@api.route('/', methods=['GET'])
def get_messages():
    return jsonify(messages)

@api.route('/new', methods=['POST'])
def post_message():
    content = request.form.get('content')
    print(content)
    return redirect("/", code=302)

if __name__ == '__main__':
    api.run(host='0.0.0.0', port=1234)