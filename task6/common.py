def square_of_sum(n):
    sum_n = (n * (n+1)) / 2
    return int(sum_n ** 2)

def sum_of_squares(n):
    return sum(map(lambda x: x ** 2, range(1, n+1)))


print(square_of_sum(100) - sum_of_squares(100))  # 25164150
