# JUST SUBMIT ONE (2) FILES, vernam_lastname.py test_vernam_lastname.py
import random

def text_to_decimal(text: str) -> str:
    """Convert text to 3-digit decimal ASCII values with leading zeros"""
    ascii_array = []
    for char in text:
        ascii_array.append(str(ord(char)).zfill(3))
    return "".join(ascii_array)

def decimal_to_text(decimal_str: str) -> str:
    """Convert 3-digit decimal string back to text"""
    char_array = []
    for i in range(0, len(decimal_str), 3):
        char_array.append(chr(int(decimal_str[i:i+3])))
    return ''.join(char_array)

def generate_key(length: int) -> str:
    """Generate random numeric key of specified length"""
    return "".join([str(random.randrange(0, 9)) for _ in range(length)])

def vernam_encrypt(plaintext_dec: str, key_dec: str) -> str:
    """Encrypt decimal plaintext using Vernam cipher"""
    if len(plaintext_dec) != len(key_dec):
        raise ValueError("Key length must match the length of the plaintext")
    encrypted_array = []
    for pd, kd in zip(plaintext_dec, key_dec):
        res = int(pd) + int(kd)
        encrypted_array.append(str(res % 10))
    return "".join(encrypted_array)

def vernam_decrypt(ciphertext_dec: str, key_dec: str) -> str:
    """Decrypt decimal ciphertext using Vernam cipher"""
    if len(ciphertext_dec) != len(key_dec):
        raise ValueError("Key length must match the length of the ciphertext")
    decrypted_array = []
    for cd, kd in zip(ciphertext_dec, key_dec):
        res = int(cd) - int(kd)
        decrypted_array.append(str(res % 10))
    return "".join(decrypted_array)

plaintext = "HELLO WORLD"

# Convert text to decimal string
decimal_plain = text_to_decimal(plaintext) 

# Generate matching key
key = generate_key(len(decimal_plain))

# Encrypt
ciphertext = vernam_encrypt(decimal_plain, key)

# Decrypt
decrypted_decimal = vernam_decrypt(ciphertext, key)
decrypted_text = decimal_to_text(decrypted_decimal)

print("plaintext\t",plaintext)
print("plaintext(dec)\t",decimal_plain)
print("Ciphertext\t",ciphertext)
print("Random Key\t",key)
print("Decrypted(dec)\t",decrypted_decimal)
print("Decrypted Text\t",decrypted_text)
