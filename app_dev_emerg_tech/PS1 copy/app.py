from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def hello_world():
    if request.method == "POST":
        name = request.form.get("name")
        return render_template("index.html", title="Hello", name=name)
    return render_template("index.html", title="Hello")

if __name__ == "__main__":
    app.run(debug=True)