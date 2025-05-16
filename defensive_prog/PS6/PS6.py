class BankAccount:
    """
    A simple bank account class with assertions for safety and debugging.
    
    Exercise: Implement the TODOs with appropriate assertions
    """
    def __init__(self, account_holder: str, initial_balance: float = 0.0):
        # TODO 1: Add assertions to verify:
        # - account_holder is a non-empty string
        # - initial_balance is non-negative
        
        # assert isinstance(account_holder, str), "Account holder name must be  a string"
        assert len (account_holder) > 0, "Account_holder name cannot be empty"
        assert initial_balance >= 0, "Initial balance cannot be negative"
        
        self.account_holder = account_holder
        self.balance = initial_balance
        

    def deposit(self, amount: float) -> float:
        # TODO 2: Add assertions to verify:
        # - amount is positive
        # - amount is a number (int or float)
        
        assert isinstance(amount, (int, float)), "Amount must be a number"
        assert amount > 0, "Deposit amount must be positive"
        
        self.balance += amount
        return self.balance

    def withdraw(self, amount: float) -> float:
        # TODO 3: Add assertions to verify:
        # - amount is positive
        # - amount is a number (int or float)
        # - sufficient balance available
        
        assert amount > 0, "Withdrawal amount must be positive"
        assert isinstance(amount, (int, float)), "Amount must be a number"
        assert self.balance > amount, f"Insufficient funds: {self.balance} < {amount}"
        
        self.balance -= amount
        return self.balance

    def transfer(self, other_account, amount: float) -> None:
        # TODO 4: Add assertions to verify:
        # - other_account is a BankAccount instance
        # - amount is valid
        # - sufficient balance available
        
        assert isinstance (other_account, BankAccount), "Invalid target amount"
        assert amount > 0, "Transfer amount must be positive"
        assert self.balance > amount, f"Insufficient funds: {self.balance} < {amount}"
        
        self.withdraw(amount)
        other_account.deposit(amount)
        
        

# don't edit this part!
# Test the implementation
def test_bank_account():
    # Test account creation
    alice = BankAccount("Alice", 1000)
    bob = BankAccount("Bob", 500)
    
    # Test initial balances
    assert alice.balance == 1000, "Initial balance incorrect"
    assert bob.balance == 500, "Initial balance incorrect"
    assert alice.account_holder == "Alice", "Account holder name incorrect"
    
    # Test invalid account creation
    try:
        invalid_account = BankAccount("", 100)  # Empty name
    except AssertionError as e:
        print(f"Caught expected error: {e}")
        
    try:
        invalid_account = BankAccount("John", -100)  # Negative balance
    except AssertionError as e:
        print(f"Caught expected error: {e}")

    # Test deposits
    alice.deposit(500)
    assert alice.balance == 1500, "Deposit failed"
    
    alice.deposit(0.50)  # Test decimal amounts
    assert alice.balance == 1500.50, "Decimal deposit failed"

    # Test withdrawals
    bob.withdraw(100)
    assert bob.balance == 400, "Withdrawal failed"
    
    bob.withdraw(0.25)  # Test decimal amounts
    assert bob.balance == 399.75, "Decimal withdrawal failed"

    # Test transfers
    alice.transfer(bob, 300)
    assert alice.balance == 1200.50, "Transfer deduction failed"
    assert bob.balance == 699.75, "Transfer addition failed"

    # Test invalid operations (should raise AssertionError)
    try:
        alice.deposit(-100)  # Negative deposit
    except AssertionError as e:
        print(f"Caught expected error: {e}")

    try:
        alice.deposit("100")  # Invalid amount type
    except AssertionError as e:
        print(f"Caught expected error: {e}")

    try:
        bob.withdraw(1000)  # Insufficient funds
    except AssertionError as e:
        print(f"Caught expected error: {e}")
        
    try:
        bob.withdraw(-50)  # Negative withdrawal
    except AssertionError as e:
        print(f"Caught expected error: {e}")
        
    try:
        alice.transfer("not an account", 100)  # Invalid account type
    except AssertionError as e:
        print(f"Caught expected error: {e}")
        
    try:
        alice.transfer(bob, -100)  # Negative transfer
    except AssertionError as e:
        print(f"Caught expected error: {e}")

    print("All tests passed!")

# Run the tests
test_bank_account()