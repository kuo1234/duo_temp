from flask import Blueprint, jsonify, request
from firebase_admin_init import db
from firebase_admin import firestore

class_search_api = Blueprint('class_search_api', __name__)

# GET /api/class_search: Retrieve all courses from Firestore
@class_search_api.route('/class_search', methods=['GET'])
def class_search():
    try:
        # Reference to the Firestore collection
        courses_ref = db.collection('courses')
        
        # Fetch all documents from the courses collection
        docs = courses_ref.stream()
        
        # Convert documents to a list of dictionaries
        courses = [doc.to_dict() for doc in docs]
        
        return jsonify({
            'message': 'Courses retrieved successfully',
            'count': len(courses),
            'courses': courses
        }), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

#