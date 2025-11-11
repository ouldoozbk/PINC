## 0. Clone Repository

Please clone the repository by running:
```
git clone https://github.com/ouldoozbk/PINC.git
```

## 1.Project Structure
This part of the repository provides the code to pull the model and run inference on it, as well as containerized code to validate the outputs of the model. The structure of the files is as follows:

**1. Juputer Notebook:** 

You can download the notebook via [Colab](https://colab.research.google.com/drive/1sE8-aAZqzfzbg7eIlVfoLVwj4UKfCjVR#scrollTo=MjwUueocevul) or simply by going to the [inference_notebook.ipynb](/inference_notebook.ipynb) file in this repository (Ignore the invalid notebook error, as GitHub doesn't yet support viewing .ipynb files). 


This notebook does the following: 
1. Code to load/unload our fine-tuned model onto your machine/colab from HuggingFace running on vLLM (ModelLoader class)
2. Code to structure the prompt to the model properly (PromptBuilder class)
3. Code to run inference on the model (LLMGenerator class)
4. Code to interact with the server to compute pass@k and compile rate (Evaluator class)
5. Sample inference pipeline that loads the model and its tokenizer, passes a desired prompt format to PromptBuilder (allows you to pass few-shot examples, do dynamic few-shot example selection using our classifier, ...), initializes recommended sampling parameters, samples generations from the fine-tuned model, validates it, and evaluates pass@k and compile rate. 

**2. Server:** Located in [validation_server](https://github.com/ouldoozbk/PINC/tree/main/validation_server) folder, the goal of this server is to validate LLM outputs. This server listens to incoming POST requests that contain the code. It accepts these requests, dispatches it to the first available "warm" docker container to compile and run static validation (p4testgen) on, and then return the details to the user. 

----

## 2. Setting up Validation Server:
To run the server, you will need to have docker installed and have all necessary libraries (more details soon). Once you have all the required libraries and Docker, setting up the server will be comprised of two main stages: 1. setting up the docker container that validates a code sample 2. running the server that launches several persistent instances of these docker containers and handles dispatching incoming requests to these containers as well as the responses to the user.  

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

Once you have Python and pip, to install all necessary Python Libraries to run the server, navigate to the [validation_server](/validation_server) folder containing [requirements.txt](https://github.com/ouldoozbk/PINC/blob/main/validation_server/requirements.txt) and run:
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


When running the server, you can either run the server locally on your machine, and use cloudflared to redirect requests to your local machine, or run the server on a Cloud provider. Both approaches are described below. Both methods simply run a FastAPI server using uvicorn. 

_**IMPORTANT Note:** You can configure number of persistent containers, docker image name, starting port to launch docker containers, in **[main.py](https://github.com/ouldoozbk/PINC/blob/main/validation_server/main.py)**:_
``` python
CONTAINER_IMAGE = "illianasiri/p4_test_suite" # image name used to launch docker containers
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
A successful run will and a sample url example is shown below:

<img width="1916" height="578" alt="image" src="https://github.com/user-attachments/assets/fcb89be9-1fbf-48f3-9b4f-603fd73076ec" />

----

**Option 2: Running the Server on Cloud Provider**

Navigate to validation_module directory and run:
```Bash
uvicorn main:app --host 0.0.0.0 
```

After this, make sure you configure your cloud instance to allow incoming packets by allowing ingree and outgress tcp/udp connections. 

----
**For both Option 1 and Option 2:**

Successful server launch will look like this:

<img width="1028" height="615" alt="image" src="https://github.com/user-attachments/assets/bc4bae29-d33f-4640-b259-44e3bb46c544" />



**Checking if the Server Works:**
You can use ant software or the terminal to make an HTTP request of the following form:

In the terminal: (OS independent)

**Local Host:**
``` bash
curl -X POST http://[CLOUD FLARE URL]/validate \
     -H "Content-Type: application/json" \
     -d '{"code": ""}'
```

For example:

``` bash
curl -X POST http://relief-disable-sterling-scheduling.trycloudflare.com/validate -H "Content-Type: application/json" -d '{"code": "hello"}'
```

would return:

```json
{
  "compiled": false,
  "test_cases": false,
  "stderr": "/work_space/b4a3f65d-72b1-4538-a49b-ea7b3ee0e865.p4(1):syntax error, unexpected END\nhello\n     ^\n[--Werror=overlimit] error: 1 errors encountered, aborting compilation\n",
  "stdout": "Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py\nRunning p4testgen on /work_space/b4a3f65d-72b1-4538-a49b-ea7b3ee0e865.p4 ...\nError: Test generation failed. Directory out- p4testgen not found.\n"
}
```


**Cloud:**
``` bash
curl -X POST http://[SERVER IP HERE / DOMAIN]:8000/validate \
     -H "Content-Type: application/json" \
     -d '{"code": ""}'
```

Output:


## 3. Using the Jupyter Notebook to Run the Model

We use 1xA100 GPU through [Colab Pro](https://colab.research.google.com/) to run inference on the model. The model needs at least 40GB of VRAM to run. You can always upload the .ipynb file provided in this repository onto colab or equivalently duplicate [this notebook](https://colab.research.google.com/drive/1sE8-aAZqzfzbg7eIlVfoLVwj4UKfCjVR?usp=sharing).

**Initializing all necessary classes:**

Before proceeding to do inference, please run all cells under "1 - Define Base Classes and Functions":
<img width="1855" height="798" alt="image" src="https://github.com/user-attachments/assets/c29d6f1d-7ff5-41ed-bfbb-583e76354d6f" />

**Example Setup:**

We have provided an example setup that matches that of used in our experiments so that once you've ran all the necessary cells that define core classes (like ModelLoader, PromptBuilder, ...), you can start repeating the experiments or doing inference on the model.

We of course recommend familiarizing yourself with these classes to be aware of what functionality is supported.

**Example Setup:**
We have provided an example setup that matches that of used in our experiments so that once you've ran all the necessary cells that define core classes (like ModelLoader, PromptBuilder, ...), you can start repeating the experiments or doing inference on the model. The example set up does the following:
1. Loads our test split of the dataset
2. Loads the fine-tuned model and tokenizer using ModelLoader class
3. Sets up a callback function to define structure of the prompt passed to the LLM.
4. Shows how you can load and pass a classifier that allows you to choose few-shot examples dynamically
5. Configures the sampling params (matching the experiments in the paper)
6. Makes the model generate code for test split and save it to the disk
7. Evaluates the code using the server
8. Saves the evaluation results to disk
9. Computes compile rate and pass@k.
----
**1. Loading the dataset** is done via `load_ds()["train"]` call. Note, here 'train' is merely an artifact of how HuggingFace works and is actually **THE FULL** dataset, not only the training portion. This is then
passed to `train_val_test_split(...)` function that makes the train, validation and test split. Since the random seed is fixed to 42, it matches that of our testing set. In Colab Code:

``` python
test_ds = train_val_test_split(load_ds()["train"])["test"]
test_intents = list(test_ds["annotation"])
```

**2. Loading the fine-tuned model:**

This code in the notebook allows you to choose between our fine-tuned model or the base model. Additionally, you can use any other
HuggingFace model by simply passing a corresponding model name into the checkpoint argument of `ModelLoader.get_instance(checkpoint = ..., token = ...)`
``` python
models = {"fine_tuned_model": "SassyTeckel/p4coder", "base_model": "deepseek-ai/DeepSeek-Coder-V2-Lite-Instruct"}

model, tokenizer = ModelLoader.get_instance(models["fine_tuned_model"], token= ... HUGGING FACE TOKEN ...).values()
```

**3. Callback function with Prompt Structure**

You will provide a template to the PromptBuilder class instance on how to form the prompt. The callback MUST support the following arguments:

Arguments the callback accepts:
- **user_intent:** (srting) it's the actual user prompt like "drop all packets coming to port 5"
- **yang_model:** (string) YANG model defines the data structure and constraint
- **yang_data:** (string) current configuration of the network
- **few_shot_examples:** (string array or None): set of few-shot-examples, which could be passed manually, chosen by the classifier, or the default ones could be used. 

Note however that you're free to exclude any of these arguments by simply accepting it as an argument but never using it. This might be helpful for for experimentation purposes. 

```` python
def prompt_format_fn(user_intent, yang_model, yang_data, few_shot_examples):

  example_prompt_format = f"""
You are generating one compilable P4_16 program for BMv2 v1model.

TASK:
Implement the network intent: {user_intent}

```
YANG MODEL SCHEMA:
The following YANG model defines the data structure and constraints:
```yang
{yang_model}
```

CURRENT NETWORK CONFIGURATION:
```json
{yang_data}

{"EXAMPLES:" if few_shot_examples else ""}
{"Here are examples of similar network intents and their P4 implementations:" if few_shot_examples else ""}

{chr(10).join([
    f"Example {i+1}:{chr(10)}Intent: {example.annotation}{chr(10)}Implementation:{chr(10)}```p4{chr(10)}{example.code}{chr(10)}```{chr(10)}"
    for i, example in enumerate(few_shot_examples)
]) if few_shot_examples else ""}

... [REST OF THE PROMPT OMITTED! ] ...
"""
  return example_prompt_format
````
**4. Choice of few-shot examples and using the classifier:**

PromptBuilder constructor accepts the following arguments:
```
class PromptBuilder:
  def __init__(self,
               tokenizer, # tokenizer of the model
               prompt_format: Callable[[str, str, str, List[FewShotExample]], str], # callback described earlier
               few_shot_strategy: Literal["classifier", "default", "passed"], 
               few_shot_examples: list[FewShotExample] | None = None,
               pipeline_model=None
  ):
```
- **prompt_format:** the callback function used to specify prompt format.

- **few_shot_examples:** this argument allows you to pass a set of few-show examples, which are instances of FewShotExample class. Here's an example:
  ```python
  few_shot_examples = [
    FewShotExamples( "intent 1", "code ..." ),
    FewShotExamples("intent 2", "code...")
  ]
  ```

- **few_shot_strategy:** this argument allows you to choose between one of three options:
  - `classifier`: examples are chosen dynamically based on the top-2 classes assigned to the prompt
  - `default`: default few-show examples are chosen
  - `passed`: few shot examples are used that you pass in **few_shot_examples** argument to PromptBuilder class.



Below is an example of how prompt builder class is initialized and configured such that the classifier chooses the few-shot examples. Additionally, we can 
see how 2 intents in `my_intents` variable are passed through the prompt_builder by calling it to give us `llm_ready_prompts` variable, which 
builds the prompt that will be passed to the llm. You can inspect the output prompt (created by PromptBuilder) by printing it. This is really helpful for debugging purposes.

```python
pipeline_model = load_classifier() 
prompt_builder = PromptBuilder(tokenizer, prompt_format_fn, "classifier", few_shot_examples=None, pipeline_model=pipeline_model)

my_intents = ["drop all packets coming to port 5", "redict all traffic to port 3"]
llm_ready_prompts = prompt_builder(my_intents)

print(llm_ready_prompts[0]) # print one of the examples to inspect what the prompt will look like. 

```
**5. Sampling Parameters:**

In the notebook, you can modify sampling parameters. Full list is available in vLLM documention: [Sampling Parameters List](https://docs.vllm.ai/en/v0.6.4/dev/sampling_params.html)

In the code, following sampling parameters were used to report experiments:
```Python
N = 10 # Number of generations

sampling_params = SamplingParams(
    n = N,
    temperature=0.3,
    max_tokens=8192,
    min_tokens=64,
    stop=["</p4>"],
    repetition_penalty=1.1,
    top_p=0.9,
)

```

**6. LLM Generations:**

The following code snippet generates outputs from the model and saves them into results variable.

``` Python
model_generator = LLMGenerator(model, tokenizer, sampling_params)
results = model_generator.generate(llm_ready_prompts)
```

Note that for testing purposes, it might be more convenient to simply prompt the model directly by using:
``` Python
model.generate( ["your prompt 1", "your prompt 2"], sampling_params )
```
and the LLMGenerator is merely a wrapper that sanitizes the output and extracts only p4 code, while the model might
produce some other output like explanations.

**7. Evaluation**:
The `Evaluator` class allows you to communicate with the server you have started earlier by sending it LLM generations and recording the validation errors, stdout, and status. This class accepts the following in its constructor:

- **Server IP:** your server IP (or URL in case of Cloudflared URL)
- **Server PORT:** server PORT (or None in case of Cloudflared URL)
- **Endpoint**: only /validate is supported

Once the Evaluator instance is created, we can `evaluate_generations(...)` by passing the LLM produced generation (`results` variable in the example below), and the intents used (`test_intents` or ["your prompt 1", "your prompt 2"] in example above.)

```python
validation_endpoint = EndPoint("34.61.128.41", 8000, "/validate")
# OR THIS for cloudflared server:
# validation_endpoint = EndPoint("starring-contacts-rest-max.trycloudflare.com", "/validate")

p4_evaluator = Evaluator(validation_endpoint)
prompt_validation_counts, all_results = p4_evaluator.evaluate_generations(results, test_intents)
```

**8. Pass@k and compile rate:**
You can use the `Evaluator` class instance to compute pass@k and compile rate as shown in the code snippet below.

`pass_at_k` function accepts the following arguments:

- **prompt_validation_counts:** first thing returned by `evaluate_generations`
- **ks**: for what values of k do you want to compute pass@k (make sure doesn't exceed N)
- **N**: number of generations per prompt. Make sure to set this argument correctly. It's how many code generations you're generating per prompt,
  which is also chosen in `sampling_params`.

```python
pass_at_k_scores = p4_evaluator.pass_at_k(prompt_validation_counts, ks=[1, 10], n = N)

for k in pass_at_k_scores:
  print(f'pass@{k} is: {pass_at_k_scores[k]}')
```

## 4. TODOs:
1. Remove my personal tokens, make things public once that's possible.
2. Add a part that rells the user to git clone this first
