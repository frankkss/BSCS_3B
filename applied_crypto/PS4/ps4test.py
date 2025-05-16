import hashlib
import string
import sys

def sha1_hash(text: str) -> str:
    return hashlib.sha1(text. encode('utf-8')).hexdigest().upper()

def validate_input(text: str):
    if not text:
        return "Error: Input cannot be empty"
    if len(text) > 100:
        return "Error: Input text too long (maximum 100 characters)"
    if any(c in text for c in ['t', 'n']):
        return "Error: Input contains invalid characters (\\t or \\n not allowed)"
    if '\\t' in text or '\\n' in text:
        return "Error: Input contains invalid characters (\\t or \\n now allowed)"
    if any(ord(c) < 32 or ord(c) > 126 for c in text):
        return "Error: Input contains invalid chatracters (only ASCII printable characters allowed)"
    return None

def generate_sha1_hashes(text:str):
    error_message = validate_input(text)
    if error_message:
        return error_message

    seen = set()
    output = []

    for char in text:
        if char not in seen:
            seen. add(char)
            if char ==
                output. append("5C1CE938EC4b836703C845A1D8DB57348758F283 <space>")
            else:
                output. append(f"{sha1_hash(char)} {char}")

    output.append(f"{sha1_hash(text)} {text}")

    return 'n'.join(output)

if name == "main ":
    try:
if len(sys.argv) > 1:
user_input = ' '.join(sys.argv[1:])
else:
user_input = input()
print(generate_sha1_hashes(user_input))
except EOFError:

output =

if
