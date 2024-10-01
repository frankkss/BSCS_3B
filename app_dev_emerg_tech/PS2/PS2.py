from flask import Flask, render_template, jsonify, request
import json
import os
from collections import OrderedDict

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('PS2.html')

@app.route('/submit', methods=['POST'])
def submit():
    try:
        user_input = request.form.to_dict()
        
        # Ensure the path to data.json is correct
        file_path = os.path.join(os.path.dirname(__file__), 'data.json')
        
        with open(file_path, 'w') as json_file:
            json.dump(user_input, json_file)
        
        # Create an OrderedDict to maintain the desired order
        ordered_data = OrderedDict([
            ("fname", user_input.get("fname")),
            ("mname", user_input.get("mname")),
            ("lname", user_input.get("lname")),
            ("birth_date", user_input.get("birth_date")),
            ("email", user_input.get("email")),
            ("address", user_input.get("address"))
        ])
        
        # Return the ordered data along with the success message
        return jsonify({"message": "Data saved successfully!", "data": ordered_data})
    except Exception as e:
        return jsonify({"message": "An error occurred while saving data.", "error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)