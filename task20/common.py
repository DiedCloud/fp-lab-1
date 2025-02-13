import math

def sum_of_digits_in_factorial(n):
    factorial = math.factorial(n)
    return sum(int(digit) for digit in str(factorial))

# Пример использования
result = sum_of_digits_in_factorial(100)
print(result)  # Ожидается: 648
