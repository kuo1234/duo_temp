from flask import Blueprint, jsonify
from firebase_admin_init import db

user_api = Blueprint('user_api', __name__)

@user_api.route('/get-users', methods=['GET'])
def get_users():
    users_ref = db.collection('users')
    docs = users_ref.stream()
    result = []
    for doc in docs:
        data = doc.to_dict()
        data['id'] = doc.id
        result.append(data)
    return jsonify(result)
