import math
def mutual_primes(int_iterator):
    x = next(int_iterator)
    yield x
    yield from mutual_primes(filter(lambda i: math.gcd(x, i) == 1, int_iterator))

def print_mutual_primes(lo, hi):
    int_iterator = iter(range(lo, hi))
    try:
        for x in mutual_primes(int_iterator):
            print(x)
    except:
        pass
