import pickle

def load_model(local_path):
    with open(local_path, 'rb') as f:
        pipeline = pickle.load(f)
    return pipeline

