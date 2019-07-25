def print_number(n, k):
    """Print all numbers that (A) can be formed from the digits of `n`
    in reverse order and (B) are multiples of `k`.

    Args:
        n (int): The number that results must use digits from.
        k (int): The number that results must be multiples of.

    >>> print_number(97531, 5)
    135
    15
    35
    >>> print_number(97531, 7)
    1379
    357
    35
    >>> print_number(97531, 2)
    """
    def inner(n, s):
        if n == 0:
            if s > k and s % k == 0:
                print(s)
        else:
            inner(n // 10, s * 10 + n % 10)
            inner(n // 10, s)
    inner(n, 0)

def sixty_one(n):
    """

    >>> sixty_one(461601)
    1
    >>> sixty_one(161461601)
    2
    """
    if n < 61:
        return 0
    elif n % 100 == 61:
        return 1 + sixty_one(n // 100)
    else:
        return sixty_one(n // 10)

def no_elevens(n):
    """

    >>> no_elevens(2)
    3
    >>> no_elevens(3)
    5
    """
    if n == 0:
        return 1
    elif n == 1:
        return 2
    else:
        return no_elevens(n - 1) + no_elevens(n - 2)
