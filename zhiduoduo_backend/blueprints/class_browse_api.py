from flask import Blueprint, jsonify, request
from firebase_admin_init import db

class_browse_api = Blueprint('class_browse_api', __name__)

@class_browse_api.route('/class_browse', methods=['GET'])
def class_search():
    category = request.args.get('category')
    courses_ref = db.collection('courses')
    docs = courses_ref.stream()
    courses = [doc.to_dict() for doc in docs]

    # 如果有指定分類，就過濾
    if category:
        courses = [course for course in courses if category in course.get('courseCategories', [])]

    return jsonify(courses), 200
