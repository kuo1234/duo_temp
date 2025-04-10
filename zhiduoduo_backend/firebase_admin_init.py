import firebase_admin
from firebase_admin import credentials, firestore
from config.settings_loader import AppSettings

settings = AppSettings()

cred = credentials.Certificate(settings.firebase_credential_path)
firebase_admin.initialize_app(cred)

db = firestore.client()
