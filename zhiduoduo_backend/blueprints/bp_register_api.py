from flask import Blueprint, jsonify, request
from email_validator import validate_email, EmailNotValidError
import logging
from firebase_admin_init import db
from firebase_admin import firestore

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

bp_register_api = Blueprint('bp_register_api', __name__)

@bp_register_api.route('/register', methods=['POST'])

def student_register():
    try:
        logger.info("Received student registration request")
        data = request.get_json()
        if not data:
            logger.warning("No JSON data received in request")
            return jsonify({"success": False, "message": "No data provided"}), 400
            
        logger.info(f"Registration data: {data}")
        
        # 檢查必要欄位
        required_fields = ['studentName', 'parentName', 'parentEmail']
        for field in required_fields:
            if not data.get(field):
                logger.warning(f"Missing required field: {field}")
                return jsonify({"success": False, "message": f"缺少必要欄位: {field}"}), 400
        
        # 檢查 Email 格式
        try:
            validate_email(data.get('parentEmail'))
        except EmailNotValidError as e:
            logger.warning(f"Invalid email: {str(e)}")
            return jsonify({"success": False, "message": f"Email 格式錯誤: {str(e)}"}), 400
            
        # 儲存學生資料到 Firestore
        students_ref = db.collection('students')
        doc_ref = students_ref.document()
        
        # 加入創建時間和文檔ID
        data['created_at'] = firestore.SERVER_TIMESTAMP
        data['id'] = doc_ref.id
        
        doc_ref.set(data)
        
        logger.info(f"Student registered successfully with ID: {doc_ref.id}")
        return jsonify({
            "success": True, 
            "message": "學生註冊成功！", 
            "id": doc_ref.id
        }), 201
        
    except Exception as e:
        logger.error(f"Error processing registration: {str(e)}", exc_info=True)
        return jsonify({"success": False, "message": f"註冊處理失敗: {str(e)}"}), 500