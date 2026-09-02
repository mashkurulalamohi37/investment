# Swapnojatri Investment Platform — Production Backend API

![FastAPI](https://img.shields.io/badge/FastAPI-0.115+-009688.svg?logo=fastapi&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12%20%7C%203.13-blue.svg?logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791.svg?logo=postgresql&logoColor=white)
![Redis](https://img.shields.io/badge/Redis-7-DC382D.svg?logo=redis&logoColor=white)
![Celery](https://img.shields.io/badge/Celery-5.4-37814A.svg?logo=celery&logoColor=white)

Production-grade, modular monolith backend for the **Swapnojatri Investment Platform (LandVest 100)**. Built with Clean Architecture, financial concurrency locking, deterministic `Decimal` arithmetic, and comprehensive double-entry ledger tracking.

---

## 🚀 Quick Start (Local Development with Docker)

```bash
# 1. Navigate to backend directory
cd backend

# 2. Start all services (FastAPI, PostgreSQL 16, Redis 7, MinIO S3, Celery Worker, Celery Beat)
docker compose up -d

# 3. Run database seed (Creates LandVest 100, Super Admin, and Investor accounts)
docker compose exec api python scripts/seed_data.py

# 4. Access Interactive API Documentation
# Swagger UI: http://localhost:8000/docs
# ReDoc:      http://localhost:8000/redoc
```

---

## 🏛️ Architecture Overview

```
backend/
├── app/
│   ├── main.py                  # FastAPI application entry point, CORS & Middlewares
│   ├── core/                    # Config, Database, Redis, Security, Permissions, Logging
│   ├── models/                  # SQLAlchemy 2.x Declarative Models (Strict constraints)
│   ├── schemas/                 # Pydantic v2 DTOs & Validation
│   ├── services/                # Authoritative Domain & Financial Services
│   ├── api/v1/                  # REST Controllers (Auth, Projects, Investments, Payments, Admin)
│   ├── workers/                 # Celery App, Workers, and Beat periodic schedules
│   └── utils/                   # Exact Decimal Money math, ID generators, Pagination
├── scripts/                     # Seed and maintenance scripts
├── docker/                      # Multi-stage Dockerfile and Nginx reverse proxy configuration
├── tests/                       # Unit, Concurrency, and API integration tests
├── docker-compose.yml           # Complete infrastructure orchestration
└── requirements.txt
```

---

## 🔒 Financial Concurrency & Security Features

1. **Deterministic Money**: Zero float representation. All currency is calculated using Python `Decimal` and PostgreSQL `Numeric(18, 2)`.
2. **Concurrency-Safe Share Allocation**: Uses PostgreSQL `SELECT ... FOR UPDATE` row locks to prevent over-allocation race conditions during high-volume subscription rounds.
3. **Idempotency Safeguard**: `Idempotency-Key` headers on financial mutations prevent duplicate charges and double lot issuances.
4. **Dual Payment Engine**:
   - **EPS (Easy Payment System) Gateway**: Instant online checkout supporting bKash, Nagad, Rocket, Cards, and Net Banking with IPN webhook processing.
   - **Manual Bank Deposit**: Bank slip image upload with administrative review queue.
5. **Immutable Double-Entry Ledger**: Every investment, payout, and expense generates balancing debit/credit journal entries.

---

## 🔑 Default Seed Credentials (Development)

| Role | Mobile / Email | Password |
| :--- | :--- | :--- |
| **Super Admin** | `tanvir.admin@swapnojatri.com` | `Admin@2026!Swapno` |
| **Finance Manager** | `finance@swapnojatri.com` | `Admin@2026!Swapno` |
| **Verified Investor** | `+8801712345678` | `Investor@2026!` |

---

## 📄 License
Copyright © 2026 Swapnojatri Platform. All rights reserved.
