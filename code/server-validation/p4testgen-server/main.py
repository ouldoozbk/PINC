import asyncio
import uuid
import httpx
import subprocess
from fastapi import FastAPI, Request
from pydantic import BaseModel
from fastapi.responses import JSONResponse
from contextlib import asynccontextmanager

CONTAINER_IMAGE = "p4_test_suite"
PORT_START = 8022
NUM_CONTAINERS = 36
PORT_RANGE = range(PORT_START, PORT_START + NUM_CONTAINERS)  # 16 containers on ports 8001 to 8016
VALIDATION_TIMEOUT = 60

container_pool = asyncio.Queue()
active_ports = list(PORT_RANGE)



class CodeReq(BaseModel):
    code: str

@asynccontextmanager
async def lifespan(app: FastAPI):
    print("[INIT] Starting and launching containers...")

    for port in PORT_RANGE:
        container_name = f"p4_container_{port}"
        subprocess.run([
            "docker", "run", "-d",
            "--name", container_name,
            "--rm", "--privileged", "--cap-add=NET_ADMIN",
            "-p", f"{port}:8000",
            CONTAINER_IMAGE
        ])
        await container_pool.put(port)

    print("[READY] Dispatcher pool ready.")
    try:
        yield
    finally:
        print("[SHUTDOWN] Cleaning up containers...")
        for port in PORT_RANGE:
            subprocess.run(["docker", "stop", f"p4_container_{port}"])

app = FastAPI(lifespan=lifespan)

@app.post("/validate")
async def dispatch(req: CodeReq):
    port = await container_pool.get()
    try:
        async with httpx.AsyncClient(timeout=VALIDATION_TIMEOUT) as client:
            url = f"http://localhost:{port}/validate"
            resp = await client.post(url, json=req.dict())
            return JSONResponse(status_code=resp.status_code, content=resp.json())
    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})
    finally:
        await container_pool.put(port)
