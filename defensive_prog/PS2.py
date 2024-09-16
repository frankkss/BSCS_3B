class Product:
    def __init__(self, name, price):
        self.name = name
        self.price = price
        
class ShoppingCart:
    def __init__(self, user_balance, products=[]):
        self.user_balance = user_balance
        self.products = products

    def add_product(self, product):
        self.products.append(product)

    def list_products(self):
        n = 1
        print("Products in cart:")
        for product in self.products:
            print(f"{n}. {product.name} - P{product.price}")
            n += 1

    def purchase_product(self, index):
        print(f"Available balance: P{self.user_balance}")
        if self.user_balance >= self.products[index].price:
            self.user_balance -= self.products[index].price
            print(f"Purchased {self.products[index].name} for P{self.products[index].price}. Remaining balance: P{self.user_balance}")
        else:
            print("Insufficient balance")

def main(): 
     
    # List of products to be added to the shopping cart 
    products = [
        Product("laptop", 89000),
        Product("Phone", 10000),
        Product("Keyboard", 10000),
        Product("Mouse", 50000),
        Product("Laptop Bag", 200000)
    ]

    # Initialize the shopping cart with a user balance
    cart = ShoppingCart(1005352, [])

    # Add products to the shopping cart
    for product in products:
        cart.add_product(product)
        print(f"Added product: {product.name} - P{product.price}")

    # List products in the shopping cart
    cart.list_products()

    # Purchase products in the shopping cart
    for i in range(len(cart.products)):
        cart.purchase_product(i)

if __name__ == "__main__":
    main()