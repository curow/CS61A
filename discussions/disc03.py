def is_prime(n):
    """

    >>> is_prime(7)
    True
    >>> is_prime(10)
    False
    >>> is_prime(1)
    False
    """
    def prime_helper(i):
        if i > n / 2:
            return True
        elif n % i == 0:
            return False
        else:
            return prime_helper(i + 1)
    return n != 1 and prime_helper(2)

def count_k(n, k):
    """

    >>> count_k(3, 3)
    4
    >>> count_k(4, 4)
    8
    >>> count_k(10, 3)
    274
    >>> count_k(300, 1)
    1
    """
    if n == 0:
        return 1
    elif n < 0:
        return 0
    else:
        t, i = 0, 1
        while i <= k:
            t += count_k(n - i, k)
            i += 1
        return t

def pascal(row, column):
    """

    >>> pascal(0, 0)
    1
    >>> pascal(1, 0)
    1
    >>> pascal(5, 0)
    1

    >>> pascal(2, 3)
    0
    >>> pascal(4, 7)
    0

    >>> pascal(4, 3)
    4
    >>> pascal(4, 2)
    6
    """
    if row < 0 or column < 0 or row < column:
        return 0
    elif column == 0:
        return 1
    else:
        return pascal(row - 1, column) + pascal(row - 1, column - 1)


