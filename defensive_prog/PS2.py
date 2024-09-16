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
     
    product1 = Product("laptop", 89000)
    product2 = Product("Phone", 10000)
    product3 = Product("Keyboard", 10000)
    product4 = Product("Mouse", 50000)
    product5 = Product("Laptop Bag", 200000)

    cart = ShoppingCart(1005352, [])

    cart.add_product(product2)
    cart.add_product(product1)
    cart.add_product(product3)
    cart.add_product(product4)
    cart.add_product(product5)

    for product in cart.products:
        print(f"Added product: {product.name} - P{product.price}")
    
    cart.list_products()


    cart.purchase_product(0)
    cart.purchase_product(1)
    cart.purchase_product(2)
    cart.purchase_product(3)
    cart.purchase_product(4)

if __name__ == "__main__":
    main()