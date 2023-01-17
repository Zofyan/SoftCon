from flask import Flask, jsonify, request, redirect
from flask_cors import CORS, cross_origin
import os
import string 
import random
from dotenv import load_dotenv
import psycopg

load_dotenv()

conn = psycopg.connect("dbname={} user={} password={} host={} port={}".format(
    os.getenv('DB_DATABASE'),
     os.getenv('DB_USERNAME'),
      os.getenv('DB_PASSWORD'),
       os.getenv('DB_HOST'),
        os.getenv('DB_PORT')
        )
)
cursor = conn.cursor()

api = Flask(__name__)
cors = CORS(api)
api.config['CORS_HEADERS'] = 'Content-Type'

@api.route('/get_messages', methods=['GET'])
@cross_origin()
def get_messages():
    cursor.execute('select * from messages')
    messages = []
    for m in cursor.fetchall():
        messages.append({'id': m[0], 'content': m[1]})
    return jsonify(messages)


@api.route('/get_threads', methods=['GET'])
@cross_origin()
def get_threads():
    cursor.execute('select * from threads')
    threads = []
    for m in cursor.fetchall():
        threads.append({'id': m[0], 'name': m[1]})
    return jsonify(threads)


@api.route('/get_thread_msgs', methods=['GET'])
@cross_origin()
def get_thread_msgs():
    print('get_thread_msgs : ', request.values)
    name = request.values.get('name')
    cursor.execute('select * from threads where name = %s', (name, ))
    conn.commit()

    thread_msgs = []
    for m in cursor.fetchall():
        print('get_thread_msgs, m[2] = ', m[2])
        thread_msgs.append({'thread_msgs' : m[2]})

    return jsonify(thread_msgs)


@api.route('/new_message', methods=['POST'])
@cross_origin()
def post_message():
    content = request.values.get('content')
    cursor.execute("INSERT INTO messages (content) VALUES(%s)", (content, ))
    conn.commit()
    return redirect("/get_messages", code=302)


@api.route('/new_thread', methods=['POST'])
@cross_origin()
def post_new_thread():
    name = request.values.get('name')
    cursor.execute("INSERT INTO threads (name) VALUES(%s)", (name, ))
    conn.commit()
    return redirect("/get_threads", code=302)


@api.route('/new_thread_msg', methods=['POST'])
@cross_origin()
def post_new_thread_msg():
    print("new_thread_msg, request values : ", request.values)
    name = request.values.get('name')
    msg = request.values.get('msg')
    print('name : ', name, ' msg : ', msg)

    sql = """ UPDATE threads    
            SET thread_msgs = thread_msgs || %s
            WHERE name = %s"""

    cursor.execute(sql, ([msg], name))
    conn.commit()

    return 'New thread msg url'


if __name__ == '__main__':
    api.run(host='0.0.0.0', port=1234)