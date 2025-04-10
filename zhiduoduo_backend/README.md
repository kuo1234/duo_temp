# zhiduoduo backend

## 環境建置 (anaconda)
- 創建 conda 環境
```shell
conda create -n zhiduoduo_backend python=3.10
conda activate zhiduoduo_backend 
```

- 安裝套件
```shell
pip install flask flask-sqlalchemy firebase-admin flask-cors
```

## 建置專案
- clone 專案
```shell
git clone https://github.com/flyingsnake5254/zhiduoduo_backend.git
```

- firebase firestore 配置  
把自己的 firebase firestore 憑證貼到 `credentials/firebase_credentials_development.json`

- 運行專案
```python
python app.py
```
