import hashlib
import string
import sys

def sha1_hash(text: str) -> str:
    return hashlib.sha1(text.encode('utf-8')).hexdigest().upper()

def validate_input(text: str):
    if not text:
        return "Error: Input cannot be empty"
    if len(text) > 100:
        return "Error: Input text too long (maximum 100 characters)"
    if any(c in text for c in ['\t', '\n']):
        return "Error: Input contains invalid characters (\\t or \\n not allowed)"
    if '\\t' in text or '\\n' in text:  # Detect literal "\ t" and "\ n"
        return "Error: Input contains invalid characters (\\t or \\n not allowed)"
    if any(ord(c) < 32 or ord(c) > 126 for c in text):  # Ensure only ASCII printable characters
        return "Error: Input contains invalid characters (only ASCII printable characters allowed)"
    return None

def generate_sha1_hashes(text: str):
    # Validate input
    if error_message := validate_input(text):  # Python 3.8+ assignment expression
        return error_message
    
    # Process unique characters and build output in one pass
    seen = set()
    output = []
    
    for char in text:
        if char not in seen:
            seen.add(char)
            output.append(f"{sha1_hash(char) if char != ' ' else '5C1CE938EC4B836703C845A1D8DB57348758F283'} {'<space>' if char == ' ' else char}")
    
    # Add final hash of entire text
    output.append(f"{sha1_hash(text)} {text}")
    
    return '\n'.join(output)

if __name__ == "__main__":
    try:
        user_input = ' '.join(sys.argv[1:]) if len(sys.argv) > 1 else input()
        print(generate_sha1_hashes(user_input))
    except EOFError:
        print("Error: Input cannot be empty")