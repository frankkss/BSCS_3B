def print_fibonacci_box():
    fibonacci_sequence = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597]
    nth_position =    [" 1", 2, 3, 4, 5, 6, "7 ", "8 " , "9 " , 10, 11, "12 " ,  "13 ", "14 " , "15 " , "16 " , 17  ]
    
    print("+", "-"*86,  "+")
    print(f"| Fibonacci numbers: {', '.join(map(str, fibonacci_sequence))} |")
    print(f"| The nth position: {', '.join(map(str, nth_position))}\t |")
    print("+", "-"*86, "+")
    
def fibonacci_iterative(n):
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    a, b = 0, 1
    for _ in range (2, n + 1):
        a, b = b, a + b
    return b
 
def fibonacci_recursive(n):
    if n <= 0:
        return 0
    elif n ==1:
        return 1
    else:
        return fibonacci_recursive(n-1) + fibonacci_recursive(n-2)

def fibonacci_dynamic(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    memo[n] = fibonacci_dynamic(n - 1, memo) + fibonacci_dynamic(n - 2, memo)
    return memo[n]


def main(): 
    print_fibonacci_box()
    
    try:
        n = int(input("Enter the value of N (positive integer): "))
        if n < 1:
            print("Error: Nth position must be a positive integer.")
            return
   
        #Approaches to calculate the Nth fibonacci number
        fib_iterative = fibonacci_iterative(n)
        fib_recursive = fibonacci_recursive(n)
        fib_dynamic = fibonacci_dynamic(n)
        
        print(f"Using 1st Approach: {fib_iterative}")
        print(f"Using 2nd Approach: {fib_recursive}")
        print(f"Using 3rd Approach: {fib_dynamic}")
        
        # Save Fibonacci sequence to a file
        with open('out.out','w') as file:
            for i in range (1, n + 1):
                file.write(f"{fibonacci_recursive(i)}\n")()
    
    except ValueError:
        print("Error: Please enter a valid integer.")

if __name__ == "__main__":
    main()