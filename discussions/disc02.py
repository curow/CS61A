def keep_ints(cond, n):
    for i in range(n):
        if cond(i + 1):
            print(i + 1)

def keep_ints_fn(n):
    def fn(cond):
        for i in range(n):
            if cond(i + 1):
                print(i + 1)
    return fn

def sum_every_other_digit(n):
    if n < 10:
        return n
    all_but_last_two, last = n // 100, n % 10
    return last + sum_every_other_digit(all_but_last_two)
