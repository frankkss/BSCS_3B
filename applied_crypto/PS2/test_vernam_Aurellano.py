# NOTE: DON'T CHANGE OR MODIFY THIS CODE, THIS IS USED FOR TESTING
# RENAME THIS FILE to test_vernam_lastname.py
import pytest
from vernam_Aurellano import *

def test_text_to_decimal():
    assert text_to_decimal("A") == "065"
    assert text_to_decimal("HELLO") == "072069076076079"
    assert text_to_decimal("Hi! 123") == "072105033032049050051"
    assert text_to_decimal(" ") == "032"

def test_decimal_to_text():
    assert decimal_to_text("072069076076079") == "HELLO"
    assert decimal_to_text("072105033032049050051") == "Hi! 123"
    assert decimal_to_text("032") == " "

def test_generate_key():
    plaintext = "HELLO"
    decimal = text_to_decimal(plaintext)
    key = generate_key(len(decimal))
    assert len(key) == len(decimal)
    assert all(c in "0123456789" for c in key)

def test_encrypt_decrypt_roundtrip():
    test_cases = [
        "SECRET",
        "Hello World!",
        "123@#",
        "7274hsifh9iy294yADhjkhjKJKJSjkjasj43298980-=-211"
    ]
    
    for plaintext in test_cases:
        decimal = text_to_decimal(plaintext)
        key = generate_key(len(decimal))
        ciphertext = vernam_encrypt(decimal, key)
        decrypted = vernam_decrypt(ciphertext, key)
        assert decimal_to_text(decrypted) == plaintext

def test_known_encryption():
    # Test case from original example
    decimal_plain = "072069076076079"  # HELLO
    key = "057651312488028"  # 15 digits matching plaintext length
    
    ciphertext = vernam_encrypt(decimal_plain, key)
    assert ciphertext == "025418764698051"
    
    decrypted = vernam_decrypt(ciphertext, key)
    assert decrypted == decimal_plain

def test_key_length_mismatch():
    decimal_plain = text_to_decimal("HELLO")
    key = generate_key(len(decimal_plain) - 1)
    
    with pytest.raises(ValueError) as e:
        vernam_encrypt(decimal_plain, key)
    
    assert "Key length must match" in str(e.value) 