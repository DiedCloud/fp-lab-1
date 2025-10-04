def get_index_of_first_fibonacci_term_length_n(n):
    i = 1
    f_i = 0
    f_i2 = 1
    while len(str(f_i2)) < n:
        f_i, f_i2 = f_i2, f_i + f_i2
        i += 1
    return i


print(get_index_of_first_fibonacci_term_length_n(1000))  # 4782
