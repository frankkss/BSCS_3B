import re

def check_password_strength():
        
    password_scores = {0:'Weak', 1:'Weak', 2:'Weak', 3:'Moderate', 4:'Moderate', 5: 'Strong' }
    password_strength = dict.fromkeys(['length','has_upper', 'has_lower', 'has_num'], False)
    if 6 <= len(password) < 12:
        password_strength['length'] = True
    if re.search(r'[A-Z]', password):
        password_strength['has_upper'] = True
    if re.search(r'[a-z]', password):
        password_strength['has_lower'] = True
    if re.search(r'[0-9]', password):
        password_strength['has_num'] = True
    if re.search(r'[!@#$%^&*(),.?":{}|<>]', password):
        password_strength['has_special_char'] = True

    score = len([b for b in password_strength.values() if b])

    print (password_scores[score])
    
def main():
    password = input('Password: ')
    print(f"Password: {password}, Strength: {check_password_strength()}")
    
if __name__ == "__main__":
    main()

import re


def check_password_strength(password):
    password_scores = {0:'Weak', 1:'Weak', 2:'Weak', 3:'Moderate', 4:'Moderate', 5: 'Strong' }
    password_strength = dict.fromkeys(['length','has_upper', 'has_lower', 'has_num'], False)

    if re.search(r'[A-Z]', password):
        password_strength['has_upper'] = True
    if re.search(r'[a-z]', password):
        password_strength['has_lower'] = True
    if re.search(r'[0-9]', password):
        password_strength['has_num'] = True
    if re.search(r'[!@#$%^&*(),.?":{}|<>]', password):
        password_strength['has_special_char'] = True

    score = len([b for b in password_strength.values() if b])

    return password_scores[score]

def main():
    password = input()
    strength = check_password_strength(password)
    print(f"Password: {password}, Strength: {strength}")
    
if __name__ == "__main__":
    main()