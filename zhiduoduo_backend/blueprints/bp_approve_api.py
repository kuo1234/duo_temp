from flask import Blueprint, jsonify
from firebase_admin_init import db
from firebase_admin import firestore
from firebase_admin_init import db



bp_approve_api = Blueprint('bp_approve_api', __name__)

@bp_approve_api.route('/approve', methods=['GET'])
def get_approve_students():
    students_ref = db.collection('students')
    docs = students_ref.stream()
    result = []

    for doc in docs:
        data = doc.to_dict()
        data['id'] = doc.id

        # 如果缺少 isApproved，就補上 False
        if 'isApproved' not in data:
            students_ref.document(doc.id).update({'isApproved': False})
            data['isApproved'] = False

        # 只回傳 isApproved 為 False 的
        if data['isApproved'] is False:
            result.append(data)

    return jsonify(result)
