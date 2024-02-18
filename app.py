import os
from flask import Flask, render_template, request, jsonify
import nltk
import main  # Assuming your chatbot code is in a file named chatbot.py

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')  # You can create an HTML template for the chat interface

@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.get_json()
        user_message = data.get('user_message')
        print("message: " + user_message)

        # Extract location, property type, and property size
        location, property_type, property_size = extract_details(user_message)

        # Pass user message to your chatbot to get a response
        reply = main.get_response(user_message)

        return jsonify({'response': reply, 'selectedCity': location, 'propType': property_type, 'selectedArea': property_size})
    except Exception as e:
        print("Error:", e)
        return jsonify({'error': str(e)})

def extract_details(user_message):
    # Implement your logic to extract the details from the user's message
    # This is a simple example; you may need more sophisticated methods based on your requirements
    tokens = nltk.word_tokenize(user_message)
    try:
        # Find the index of "in" in the tokens
        in_index = tokens.index("in")
        # Extract the location (considering the word after "in")
        location = tokens[in_index + 1]

        # Check if there is a property type token before "in"
        

        # Check if "with" is present in the tokens
        if "with" in tokens:
            with_index = tokens.index("with")
            # Extract the property size (considering the word after "with")
            property_size = tokens[with_index + 1]
            property_type = tokens[in_index - 3]
        else:
            if in_index >= 1:
                property_type = tokens[in_index - 1]
                property_size = None
            else:
                property_type = None
                property_size = None

        return location, property_type, property_size
    except ValueError:
        # "in" not found or no word after "in"
        return None, None, None

if __name__ == '__main__':
    app.run(debug=True, port=int(os.environ.get('PORT', 5000)))
