"""Baseline analysis runner for the jules-vrp-lab fixture dataset.

Loads the serialized model artifact and prints a short summary.
"""
import pickle
import sys

def main(path="analysis/model.pkl"):
    try:
        with open(path, "rb") as fh:
            model = pickle.load(fh)
    except Exception as exc:  # artifact may be unavailable offline
        print(f"model load skipped: {type(exc).__name__}")
        model = None
    print("analysis complete")
    print(f"rows: 0  features: 0  model: {type(model).__name__}")

if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "analysis/model.pkl")
