from fastapi import FastAPI
from transformers import pipeline


# Creating a new FAst api instance

app=FastAPI()

# Initialize the text generation pipeline
pipe = pipeline("text2text-generation", model="google/flan-t5-small")

@app.get('/')
def home():
    return {"message": "Hello!!!1"}

# Function to difine to handle the get request at '/generate'

@app.get("/generate")
def generate(text):
    # Use the pipeline to generate text
    result = pipe(text)

    # return the generate text in JSON response
    return {"generated_text": result[0]["generated_text"]}