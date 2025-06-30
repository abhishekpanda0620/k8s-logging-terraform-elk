from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from uuid import uuid4

app = FastAPI(title="User CRUD Service")

# In-memory DB (replace with real DB later)
fake_db = {}

class User(BaseModel):
    name: str
    email: str

@app.post("/users")
def create_user(user: User):
    user_id = str(uuid4())
    fake_db[user_id] = user.dict()
    return {"id": user_id, "user": fake_db[user_id]}

@app.get("/users/{user_id}")
def get_user(user_id: str):
    user = fake_db.get(user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return {"id": user_id, "user": user}

@app.put("/users/{user_id}")
def update_user(user_id: str, user: User):
    if user_id not in fake_db:
        raise HTTPException(status_code=404, detail="User not found")
    fake_db[user_id] = user.dict()
    return {"id": user_id, "user": fake_db[user_id]}

@app.delete("/users/{user_id}")
def delete_user(user_id: str):
    if user_id not in fake_db:
        raise HTTPException(status_code=404, detail="User not found")
    del fake_db[user_id]
    return {"status": "deleted"}

@app.get("/health")
def health_check():
    return {"status": "ok"}
