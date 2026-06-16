"""
p4testgen dispatcher — DEPRECATED.

This standalone dispatcher has been merged into the unified PINC API server
at  backend/api_server.py  which now exposes:

  POST /validate              (dispatcher-compatible, accepts {"code": "..."})
  POST /api/vrf-b/validate    (PINC API style, accepts {"p4_code": "..."})
  POST /api/vrf-b/start-pool  (start container pool on demand)
  POST /api/vrf-b/stop-pool   (stop container pool)
  GET  /api/vrf-b/status      (pool health)

To run the unified server:
    cd backend && python api_server.py
"""
