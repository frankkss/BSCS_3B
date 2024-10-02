import string

def check_password_strength(password):
    # Initialize a score variable
    score = 0
    
    # Check for length
    if len(password) >= 8:
        score += 1
    
    # Check for digits
    if any(char.isdigit() for char in password):
        score += 1
    
    # Check for uppercase letters
    if any(char.isupper() for char in password):
        score += 1
    
    # Check for lowercase letters
    if any(char.islower() for char in password):
        score += 1
    
    # # Check for special characters
    # special_characters = "!@#$%^&*(),.?"
    # if any(char in special_characters for char in password):
    #     score += 1

    # Check for special characters
    if any(char in string.punctuation for char in password):
        score += 1
    
    # Determine strength based on the score
    if score >= 5:
        return "Strong"
    elif 3 <= score < 5:
        return "Moderate"
    else:
        return "Weak"

# Test the function
password = input()
print(f"Password: {password}, Strength: {check_password_strength(password)}")