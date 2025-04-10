import json

class AppSettings:
    def __init__(self, settings_path="config/settings.json"):
        with open(settings_path, "r") as f:
            self._config = json.load(f)
        self.env = self._config.get("environment", "development")

    @property
    def firebase_credential_path(self):
        if self.env == "development":
            return self._config["firebase"]["credential_development"]
        elif self.env == "staging":
            return self._config["firebase"]["credential_staging"]
        elif self.env == "production":
            return self._config["firebase"]["credential_production"]
        return self._config["firebase"]["credential_staging"]