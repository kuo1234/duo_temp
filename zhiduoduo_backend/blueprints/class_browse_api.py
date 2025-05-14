from flask import Blueprint, jsonify
from firebase_admin_init import db

class_browse_api = Blueprint('class_browse_api', __name__)

# GET /api/class_browse: Retrieve all courses from Firestore
@class_browse_api.route('/class_browse', methods=['GET'])
def class_search():
    courses_ref = db.collection('courses')
    docs = courses_ref.stream()
    courses = [doc.to_dict() for doc in docs]
    return jsonify(courses), 200
