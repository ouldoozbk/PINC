from fastapi import FastAPI
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import subprocess
import os
import uuid


class CodeReq(BaseModel):
    code: str


app = FastAPI()


@app.post("/validate")
async def validate(req: CodeReq):
    name = f"/work_space/{uuid.uuid4()}.p4"

    with open(name, "w") as f:
        f.write(req.code)

    try:
        result = subprocess.run(
            ["/work_space/run_tests.sh", name],
            capture_output=True,
            text=True,
            timeout=60
        )

        # Check if the script ran successfully
        if result.returncode == 0:
            return JSONResponse(
                status_code=200,
                content={
                    "success": True,
                    "stdout": result.stdout,
                    "stderr": result.stderr,
                    "returncode": result.returncode
                }
            )
        else:
            return JSONResponse(
                status_code=400,
                content={
                    "success": False,
                    "stdout": result.stdout,
                    "stderr": result.stderr,
                    "returncode": result.returncode
                }
            )

    except subprocess.TimeoutExpired as e:
        return JSONResponse(
            status_code=500,
            content={
                "success": False,
                "error": "Validation timed out",
                "stdout": e.stdout,
                "stderr": e.stderr
            }
        )

    except Exception as e:
        return JSONResponse(
            status_code=500,
            content={
                "success": False,
                "error": str(e)
            }
        )

    # Uncomment if cleanup is required
    finally:
        os.remove(name)
