from flask import Blueprint, jsonify, request
from firebase_admin_init import db
from firebase_admin import firestore
from firebase_admin_init import db

set_approve_api = Blueprint('set_approve_api', __name__)


@set_approve_api.route('/students/<student_id>/approve', methods=['PUT'])
def approve_student(student_id):
    try:
        data = request.get_json()
        is_approved = data.get('isApproved')

        if is_approved is None:
            return jsonify({'error': 'isApproved is required'}), 400

        student_ref = db.collection('students').document(student_id)
        student_snapshot = student_ref.get()

        if not student_snapshot.exists:
            return jsonify({'error': 'Student not found'}), 404

        student_data = student_snapshot.to_dict()

        # 若 isApproved 欄位不存在，先補上 false
        if 'isApproved' not in student_data:
            student_ref.update({'isApproved': False})

        # 再更新為新的值（true / false）
        student_ref.update({'isApproved': is_approved})

        return jsonify({'message': f'Student {student_id} approval set to {is_approved}'}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500
