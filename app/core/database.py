from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker, AsyncSession
from sqlalchemy.orm import DeclarativeBase
import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

# Upewnienie się, że URL jest poprawny dla aiosqlite (jeśli w .env jest sqlite:///...)
if DATABASE_URL and DATABASE_URL.startswith("sqlite"):
    # Fix dla SQLite, jeśli user wpisał sqlite:// zamiast sqlite+aiosqlite://
    if "aiosqlite" not in DATABASE_URL:
        DATABASE_URL = DATABASE_URL.replace("sqlite://", "sqlite+aiosqlite://")

engine = create_async_engine(DATABASE_URL, echo=True)
AsyncSessionLocal = async_sessionmaker(bind=engine, class_=AsyncSession, expire_on_commit=False)

class Base(DeclarativeBase):
    pass

# --- TO JEST CZĘŚĆ, KTÓREJ BRAKUJE ---
async def get_db():
    async with AsyncSessionLocal() as session:
        yield session