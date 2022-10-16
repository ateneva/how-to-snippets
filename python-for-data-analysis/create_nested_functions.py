
def create_math_function(func_name):
    if func_name == 'add':
        def add(a, b):
            return a + b
        return add

    elif func_name == 'subtract':
        def subtract(a, b):
            return a - b
        return subtract

    elif func_name == 'multiply':
        def multiply(a, b):
            return a * b
        return multiply

    elif func_name == 'divide':
        def divide(a, b):
            return a / b
        return divide

    elif func_name == 'power':
        def power(a, b):
            return a ** b
        return power

    else:
        print("I don't know that one")

add = create_math_function('add')
print(f'5 + 2 = {add(5, 2)}')

subtract = create_math_function('subtract')
print(f'5 - 2 = {subtract(5, 2)}')

multiply = create_math_function('multiply')
print(f'5 * 2 = {multiply(5, 2)}')

divide = create_math_function('divide')
print(f'5 / 2 = {divide(5, 2)}')

power = create_math_function('power')
print(f'5 power 2  = {power(5, 2)}')
