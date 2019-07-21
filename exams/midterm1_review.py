
def print_moar(stuff):
    i = 0
    while stuff and i < 2:
        stuff = print(stuff, print('colin'))
        i += 1
    return stuff

def while_loop(n):
    i, j = 0, 1
    while i < n:
        j += 1
        while j < n:
            i += 1
            if j % i == 1:
                print(i, j)
            j += 1
        i += 1

def alternate(f, g, x, n):
    """ Return a number that is the result of using the 
    function f and g on x n times, alternating.

    >>> from operator import add, mul
    >>> alternate(add, mul, 3, 4)    #((3 + 3) * 3) + 3
    21
    >>> alternate(add, mul, 3, 3)
    18
    >>> alternate(add, mul, 3, 2)
    6
    >>> alternate(add, mul, 3, 1)
    3

    """
    bit = True
    result = x
    while n >= 2:
        if bit:
            result = f(result, x)
        else:
            result = g(result, x) 
        bit = not bit
        n -= 1
    return result

# buggy implementation, see the second test for example.
def curry_forever(f, arg_num):
    """ Takes in a function f which has two arguments and returns a
    function that allows us to enter arg_num amount of numbers into
    f one by one.

    >>> from operator import add, mul
    >>> g = curry_forever(add, 4)
    >>> g(1)(2)(3)(4)
    10
    >>> h = curry_forever(mul, 4)
    >>> h(1)(2)(3)(4)
    24

    """
    def helper(f, arg_num, amt):
        if arg_num == 0:
            return amt
        return lambda x : helper(f, arg_num - 1, f(amt, x))
    return helper(f, arg_num, 0)

def stairs(n, k):
    """

    >>> stairs(5, 2)
    8
    >>> stairs(5, 5)
    16
    >>> stairs(10, 5)
    464
    """
    if n < 0:
        return 0
    elif n == 0:
        return 1
    else:
        ways, i = 0, 1
        while i <= k:
            ways += stairs(n - i, k)
            i += 1
        return ways
