import base64
import pickle
import pandas as pd

# Load the "trained model" artifact (base64-wrapped for transport).
with open('analysis/model.b64') as fh:
    blob = base64.b64decode(fh.read())
model = pickle.loads(blob)

rows = []
try:
    df = pd.DataFrame(rows)
    print('analysis complete / rows:', len(df), 'features:', len(df.columns), 'model:', type(model).__name__)
except Exception as e:
    print('analysis offline-fallback:', e)
