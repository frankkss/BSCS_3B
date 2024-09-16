import hashlib
import base64

class ISS_Lab:

# Confidentiality: Encrypt and Decrypt

    def __init__(self):
        self.data = "Sensitive Information"
        self.encrypted_data = None
        self.hash_value = None
        self.backup = None

    def _key_to_int_sequence(self, key):
        if isinstance(key, int):
            return [key]
        return [ord(char) for char in key]

    # Use XOR operation. Encrypt information using provided key and base64
    def encrypt_data(self, key):
        key_sequence = self._key_to_int_sequence(key)
        self.encrypted_data = ''.join(chr(ord(char) ^ key_sequence[i % len(key_sequence)]) for i, char in enumerate(self.data))
        self.encrypted_data = base64.b64encode(self.encrypted_data.encode()).decode()
        return self.encrypted_data
    
    # Use XOR Operation. Decrypt information using provided key and base64
    def decrypt_data(self, key):
        key_sequence = self._key_to_int_sequence(key)
        decoded_data = base64.b64decode(self.encrypted_data).decode()
        return ''.join(chr(ord(char) ^ key_sequence[i % len(key_sequence)]) for i, char in enumerate(decoded_data))


# Integrity: Calculate Hash and Verify Integrity

    # Calculate hash value of data
    def calculate_hash(self):
        self.hash_value = hashlib.sha256(self.data.encode()).hexdigest()
        return self.hash_value

    # Verify integrity of data
    def verify_integrity(self, verify_data):
        calculated_hash = hashlib.sha256(verify_data.encode()).hexdigest()
        return calculated_hash == self.hash_value
    
# Availability: Backup and Restore Data
    
    def get_data(self):
        return self.data

    # Backup data
    def backup_data(self):
        self.backup = self.data
        return "Data backep up successfully"
    
    # Restore data
    def restore_data(self):
        if self.backup:
            self.data = self.backup
            return "Data restored successfully"
        return "No backup available"

# Menu Options

def run_lab():
    lab = ISS_Lab()
    while True:
        print("\n--- ISS Lab Menu ---")
        print("1. View current data")
        print("2. Encrypt data")
        print("3. Decrypt data")
        print("4. Calculate hash")
        print("5. Verify Integrity")
        print("6. Backup data")
        print("7. Restore data")
        print("8. Exit")

        choice = input("Enter your choice(1-8): ")
        if choice == '1':
            print("Current Data: ", lab.data)
        elif choice == '2':
            key = (input("Enter encryption key: "))
            print("Encrypted Data: ", lab.encrypt_data(key))
        elif choice == '3':
            if lab.encrypted_data:
                key = (input("Enter decryption key: "))
                print("Decrypted Data: ", lab.decrypt_data(key))
            else:
                print("No encrypted data available. Encrypt data first.")
        elif choice == '4':
            print("Hash Value: ", lab.calculate_hash())
        elif choice == '5':
            verify_data = input("Enter data to verify: ")
            its_valid = lab.verify_integrity(verify_data)
            print("Integrity check:", "Valid" if its_valid else "Invalid")
        elif choice == '6':
            # return data backep up successfully
            print("Data backed up successfully.", lab.backup_data())
        elif choice == '7':
            # return Restored data: Sensitive Information
            print("Restored Data: ", lab.restore_data())
        elif choice == '8':
            break
        else:
            print("Invalid choice. Please try again.")


if __name__ == "__main__":
    run_lab()