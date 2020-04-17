import math
def mutual_primes(int_iterator):
    x = next(int_iterator)
    yield x
    yield from mutual_primes(filter(lambda i: math.gcd(x, i) == 1, int_iterator))

def print_mutual_primes(iterable):
    int_iterator = iter(iterable)
    try:
        for x in mutual_primes(int_iterator):
            print(x)
    except:
        pass

def test1():
    print_mutual_primes(range(2, 10))

def test2():
    print_mutual_primes([3, 7, 10, 11])
