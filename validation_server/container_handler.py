from fastapi import FastAPI
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import subprocess
import os
import uuid


class CodeReq(BaseModel):
    code: str


app = FastAPI()


def is_compilation_successful(out):
    out = out.lower()
    if (("Test generation failed" in out)
            or ("aborting compilation" in out)
            or ("compilation error" in out)
            or ("declaration not found" in out)
            or ("[--Werror=type-error]" in out)):
        return False

    return True


def is_validation_successful(out):
    out = out.lower()
    if "The following tests failed:" in out or "The following tests errored:" in out or "error:" in out:
        return False

    return True


@app.post("/validate")
async def validate(req: CodeReq):

    if req.code == "":
        return JSONResponse(
            status_code=200,
            content={
                "code_Req": req.code == "",
                "compiled": False,
                "test_cases": False,
                "stderr": "",
                "stdout": ""
            }
        )

    name = f"/work_space/{uuid.uuid4()}.p4"

    with open(name, "w") as f:
        f.write(req.code)

    try:
        result = subprocess.run(
            ["/work_space/run_tests.sh", name],
            capture_output=True,
            text=True,
            timeout=120
        )

        compilation_flag = is_compilation_successful(result.stdout + result.stderr)
        test_gen_flag = is_validation_successful(result.stdout + result.stderr)

        return JSONResponse(
            status_code=200,
            content={
                "compiled": compilation_flag,
                "test_cases": test_gen_flag,
                "stderr": result.stderr,
                "stdout": result.stdout,
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

    finally:
        os.remove(name)