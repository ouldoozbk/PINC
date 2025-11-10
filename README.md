## 1.Project Structure
This part of the repository provides the code to pull the model and run inference on it, as well as containerized code to validate the outputs of the model. The structure of the files is as follows:

**1. Juputer Notebook (pass@k .ipynb):** This notebook provides you with 
1. Code to load/unload our fine-tuned model onto your machine/colab from HuggingFace running on vLLM (ModelLoader class)
2. Code to structure the prompt to the model properly (PromptBuilder class)
3. Code to run inference on the model (LLMGenerator class)
4. Code to interact with the server to compute pass@k and compile rate (Evaluator class)
5. Sample inference pipeline that loads the model and its tokenizer, passes a desired prompt format to PromptBuilder (allows you to pass few-shot examples, do dynamic few-shot example selection using our classifier, ...), initializes recommended sampling parameters, samples generations from the fine-tuned model, validates it, and evaluates pass@k and compile rate. 

**2. Server (validation_module folder):** The goal of this server is to validate LLM outputs. This server listens to incoming POST requests that contain the code. It accepts these requests, dispatches it to the first available "warm" docker container to compile and run static validation (p4testgen) on, and then return the details to the user. 

----

## 2. Setting up Validation Server:
To run the server, you will need to have docker installed and have all necessary libraries (more details in 2.1.0). Once you have all the required libraries and Docker, setting up the server will be comprised of two main stages: 1. setting up the docker container that validates a code sample 2. running the server that launches several persistent instances of these docker containers and handles dispatching incoming requests to these containers as well as the responses to the user.  

### Required Dependencies and Libraries for the Server:
- Docker
- Python and pip
- FastAPI, Uvicorn, Pydantic, httpx, cloudfrared (only for local machine set up)

**Installing Docker:** 

To run the server, you'll need to install [Docker Engine (Linux)](https://docs.docker.com/engine/install/) or [Docker Desktop (Mac, Windows)](https://docs.docker.com/desktop/). 

If you're using **Ubuntu**, the following commands could be ran to install Docker (should work for any Ubuntu version):
``` bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world
```

**Installing Python:**

You must have Python and pip installed. Refer to [documentation to install Python and pip](https://www.python.org/downloads/).

Specifically for **Ubuntu**, to install Python run:
``` bash
sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install -y python3 python3-pip python3-venv
```

**Installing Python libraries:**

Once you have Python and pip, to install all necessary Python Libraries to run the server, navigate to the folder containing requirements.txt and run:
```
pip install -r requirements.txt 
```
----
### Running the Server:

**Setting up Docker Container:**

There's two options to run the docker instance, either by pulling our pre-built instance from Docker Hub or by building it on your machine.

**Option 1 (recommended) Pull Docker Container:**

To pull the container, run the following command:
```bash
docker pull illianasiri/p4_test_suite
```
**Option 2: Build Docker Container**

You can build the same exact docker image by running:
```
docker buildx build --tag p4_test_suite . --load
```
Building the docker image is expected to take several minutes.

**Running the Server:**


When running the server, you can either run the server locally on your machine, and use cloudflared to redirect requests to your local machine, or run the server on a Cloud provider. Both approaches are described below. Both methods simply run a FastAPI server using uvicorn. You can configure number of persistent containers, docker image name, starting port to launch docker containers, in **main.py**:
``` python
CONTAINER_IMAGE = "p4_test_suite" # image name used to launch docker containers
PORT_START = 8022 # start port from which docker containers are launched
NUM_CONTAINERS = 24 # how many persistent containers are launched
PORT_RANGE = range(PORT_START, PORT_START + NUM_CONTAINERS)  # 24 docker containers launched on ports 8022 to 8045
VALIDATION_TIMEOUT = 180 # How long to wait before timing out a connection

# ... REST OF THE CODE ...
```

**Option 1: Running the Server Locally:**

Navigate to validation_module directory and run:
```Bash
uvicorn main:app --host 0.0.0.0 --port 8000
```

For your own convenience, we recommend to make sure the terminal with the server is running as a standalone process via a utility like tmux, which would allow you
to close the terminal running the server but it would still keep it running in the background.

**Redirecting connections via cloudflared:**

To allow your machine to accept requests and redirect the to the correct port, in additional terminal, run:
``` bash
cloudflared tunnel --url http://localhost:8000
```

Running cloudflared will give you a link that will allow you to access the server.

**Option 2: Running the Server on Cloud Provider**

Navigate to validation_module directory and run:
```Bash
uvicorn main:app --host 0.0.0.0 
```

After this, make sure you configure your cloud instance to allow incoming packets by allowing ingree and outgress tcp/udp connections. 

**Checking if the Server Works:**:
You can use ant software or the terminal to make an HTTP request of the following form:

In the terminal: (OS independent)

Local Host:
``` bash
curl -X POST http://[CLOUD FLARE URL]/validate \
     -H "Content-Type: application/json" \
     -d '{"code": ""}'
```

Cloud:
``` bash
curl -X POST http://[SERVER IP]:8000/validate \
     -H "Content-Type: application/json" \
     -d '{"code": ""}'
```


## 3. Using the Jupyter Notebook to Run the Model

We use 1xA100 GPU through [Colab Pro](https://colab.research.google.com/) to run inference on the model. The model needs at least 40GB of VRAM to run. You can always upload the .ipynb file provided in this repository onto colab or equivalently duplicate [this notebook](https://colab.research.google.com/drive/1sE8-aAZqzfzbg7eIlVfoLVwj4UKfCjVR?usp=sharing).

Before proceeding to do inference, please run all cells under "1 - Define Base Classes and Functions":
<img width="1855" height="798" alt="image" src="https://github.com/user-attachments/assets/c29d6f1d-7ff5-41ed-bfbb-583e76354d6f" />



## 4. TODOs:
1. Remove my personal tokens, make things public once that's possible.
2. Add a part that rells the user to git clone this first
3. Add a recommendation to use Linux or WSL
