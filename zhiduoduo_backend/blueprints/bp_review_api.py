from flask import Blueprint, jsonify
from firebase_admin_init import db
from firebase_admin import firestore
from firebase_admin_init import db



bp_review_api = Blueprint('bp_review_api', __name__)

@bp_review_api.route('/review', methods=['GET'])
def get_review_students():
    students_ref = db.collection('students')
    docs = students_ref.stream()
    result = []

    for doc in docs:
        data = doc.to_dict()
        data['id'] = doc.id

        # 前端需要 pending 的資料 → 這邊手動判斷
        if data.get('isApproved') is None:
            result.append(data)

    return jsonify(result)
