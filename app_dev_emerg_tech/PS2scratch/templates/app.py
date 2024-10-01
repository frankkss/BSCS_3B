from flask import Flask, render_template, request
from flask_bootstrap import Bootstrap
import json
import os

app = Flask(__name__)
Bootstrap(app)

def append_to_json(filepath, data):
    if not os.path.exists(filepath):
        with open(filepath, "w") as file:
            json.dump([], file, indent=4)

    with open(filepath, "r+") as file:
        old_data = json.load(file)
        old_data.append(data)
        file.seek(0)
        json.dump(old_data, file, indent=4)

@app.route("/", methods=["GET", "POST"])
def index():
    dict = {}
    flag = False
    if request.method == "POST":
        data = request.form.to_dict()
        filepath = "data.json"
        append_to_json(filepath, data)
        flag = True
    return render_template("index.html", flag=flag)

if __name__ == "__main__":
    app.run(debug=True)