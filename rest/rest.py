from flask import Flask, jsonify, request, redirect
from flask_cors import CORS, cross_origin
import os
from dotenv import load_dotenv
import psycopg

load_dotenv()

conn = psycopg.connect("dbname={} user={} password={} host={}".format(os.getenv('DB_DATABASE'), os.getenv('DB_USERNAME'), os.getenv('DB_PASSWORD'), os.getenv('DB_HOST')))
cursor = conn.cursor()

api = Flask(__name__)
cors = CORS(api)
api.config['CORS_HEADERS'] = 'Content-Type'

@api.route('/', methods=['GET'])
@cross_origin()
def get_messages():
    cursor.execute('select * from messages')
    messages = []
    for m in cursor.fetchall():
        messages += m
        print(m)
    return jsonify(messages)

@api.route('/new', methods=['POST'])
@cross_origin()
def post_message():
    content = request.form.get('content')
    cursor.execute('prepare myinsert as INSERT INTO messages (content) VALUES($1)')
    cursor.execute("execute myinsert (%s)", content)
    return redirect("/", code=302)

if __name__ == '__main__':
    api.run(host='0.0.0.0', port=1234)