from flask import Flask, request
from flask_cors import CORS
import logging
from config.settings_loader import AppSettings
from flask import Blueprint, jsonify, request

app = Flask(__name__)
CORS(app)

settings = AppSettings()
app.logger.info(f"[ENV] environment: {settings.env}")
app.logger.info(f"[FIREBASE] credentials: {settings.firebase_credential_path}")

# 設定 logging
logging.basicConfig(level=logging.INFO)

# 請求前 log：記錄 method、路徑、IP
@app.before_request
def log_request_info():
    app.logger.info(f"[REQ] {request.method} {request.path} | IP: {request.remote_addr}")

# 回應後 log：記錄狀態與請求路徑
@app.after_request
def log_response_info(response):
    app.logger.info(f"[RES] {response.status_code} | {request.method} {request.path}")
    return response

''' 註冊 Blueprint '''
# sample
from blueprints.bp_register_api import bp_register_api
app.register_blueprint(bp_register_api, url_prefix='/api')

from blueprints.bp_approve_api import bp_approve_api
app.register_blueprint(bp_approve_api, url_prefix='/api')

from blueprints.set_approve_api import set_approve_api
app.register_blueprint(set_approve_api, url_prefix='/api')

from blueprints.class_search_api import class_search_api
app.register_blueprint(class_search_api, url_prefix='/api')


if __name__ == '__main__':
    if settings.env == 'development':
        app.run(debug=True, host="0.0.0.0", port=5000)
    elif settings.env == 'staging':
        app.run(debug=True, host="0.0.0.0", port=5000)
    elif settings.env == 'production':
        app.run(debug=False, host="0.0.0.0", port=5000)

