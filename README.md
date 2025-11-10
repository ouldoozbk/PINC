## 1.Project Structure
This part of the repository provides the code to pull the model and run inference on it, as well as containerized code to validate the outputs of the model. The structure of the files is as follows:

**1. Juputer Notebook (pass@k .ipynb):** This notebook provides you with 
1. Code to load/unload our fine-tuned model onto your machine/colab from HuggingFace running on vLLM (ModelLoader class)
2. Code to structure the prompt to the model properly (PromptBuilder class)
3. Code to run inference on the model (LLMGenerator class)
4. Code to interact with the server to compute pass@k and compile rate (Evaluator class)
5. Sample inference pipeline that loads the model and its tokenizer, passes a desired prompt format to PromptBuilder (allows you to pass few-shot examples, do dynamic few-shot example selection using our classifier, ...), initializes recommended sampling parameters, samples generations from the fine-tuned model, validates it, and evaluates pass@k and compile rate. 

**1. Server (validation_module folder):** The goal of this server is to validate LLM outputs. This server listens to incoming POST requests that contain the code. It accepts these requests, dispatches it to the first available "warm" docker container to compile and run static validation (p4testgen) on, and then return the details to the user. 

## 2. Setting up Validation Server:
Setting up the server 

### 2.1 Using Docker Container
To run the server, you will need to have docker installed and have all necessary libraries (more details in 2.1.0). Once you have all the required libraries and Docker, setting up the server will be comprised of two main stages: 1. setting up the docker container that validates a code sample 2. running the server that launches several persistent instances of these docker containers and handles dispatching incoming requests to these containers as well as the responses to the user.  

#### (requirments) 2.1.0 Requirements to Run the Server
**Installing Docker:** To run the server, you'll need to install [Docker Engine (Linux)](https://docs.docker.com/engine/install/) or [Docker Desktop (Mac, Windows)](https://docs.docker.com/desktop/). 

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

**Installing Python Libraries:**
You must have Python and pip installed. Refer to [documentation to install Python and pip](https://www.python.org/downloads/).

Specifically for **Ubuntu**, to install Python run:
``` bash
sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install -y python3 python3-pip python3-venv
```

Once you have Python and pip, to install all necessary Python Libraries to run the server, navigate to the folder containing requirements.txt and run:
```
pip install -r requirements.txt 
```

#### Stage 1:  Setting up Docker Container:
You have two options to run the docker instance, either by pulling our pre-built instance from Docker Hub or by building it on your machine.

#### (Stage 1) 2.1.1 (Option 1, easiest) Pull Docker Container:
To pull the container, run the following command:
```bash
docker pull illianasiri/p4_test_suite
```
#### (Stage 1) 2.1.1 (Option 2): Build Docker Container
You can build the same exact docker image by running:
```
docker buildx build --tag p4_test_suite . --load
```

#### State 2: Running the Server:
When running the server, you can either run the server locally on your machine, and use cloudflared to redirect requests to your local machine, or run the server on a Cloud provider. Both approaches are described below. Both methods simply run a FastAPI server using uvicorn. You can configure number of persistent containers, docker image name, starting port to launch docker containers, in **main.py**:
``` python
CONTAINER_IMAGE = "p4_test_suite" # image name used to launch docker containers
PORT_START = 8022 # start port from which docker containers are launched
NUM_CONTAINERS = 24 # how many persistent containers are launched
PORT_RANGE = range(PORT_START, PORT_START + NUM_CONTAINERS)  # 24 docker containers launched on ports 8022 to 8045
VALIDATION_TIMEOUT = 180 # How long to wait before timing out a connection

# ... REST OF THE CODE ...
```

#### (Stage 2) 2.1.3 (Option 1) Running the Server Locally
Navigate to validation_module directory and run:
```Bash
uvicorn main:app --host 0.0.0.0 
```

**Redirecting connections via cloudflared:**

#### (Stage 2) 2.1.3 (Option 2) Running the Server on Cloud Provider
Navigate to validation_module directory and run:
```Bash
uvicorn main:app --host 0.0.0.0 
```

## 3. Using the Jupyter Notebook to Run the Model

## 4. TODOs:
1. Remove my personal tokens, make things public once that's possible.
2. Add a part that rells the user to git clone this first
3. Add a recommendation to use Linux or WSL
4. Mkae container publicly available once we are allowed (see what the procedure is)
