# Frontend

React + Vite app wired to the `app.py` backend endpoints:
- `GET /health`
- `POST /classify`
- `POST /generate`
- `POST /validate`

This folder is a copy of `PINC/frontend` so you can iterate without modifying `PINC/`.

## Run

```bash
npm install
npm run dev
```

Opens at [http://localhost:3000](http://localhost:3000).

## Connect to a public backend URL

Create `frontend/.env` with:

```bash
VITE_API_BASE_URL=https://your-backend-domain
```

Notes:
- Keep it empty for local dev with Vite proxy (`/health`, `/classify`, `/generate`, `/validate` are proxied to `http://localhost:8000`).
- Set it for deployed frontend so browser calls go to your public backend URL.
