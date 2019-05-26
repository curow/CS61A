from functools import wraps
from time import time
def timing(f):
    @wraps(f)
    def wrap(*args, **kw):
        ts = time()
        result = f(*args, **kw)
        te = time()
        print("func %r args:[%r, %r] took: %2.4f sec" % \
                (f.__name__, args, kw, te-ts))
        return result
    return wrap

def memoize(f):
    cache = {}
    def helper(x):
        if x not in cache:
            cache[x] = f(x)
        return cache[x]
    return helper

@timing
def fib(x):
    if x in (0, 1):
        return x
    return fib(x-1) + fib(x-2)

# notice the difference bwtween msfib and mfib:
# they look alike, but msfib is much slower than mfib
# because msfib call fib rather than itself, so it still
# does a lot of repetitive computation(fib doesn't use memoize)
msfib = memoize(fib)

@timing
@memoize
def mfib(x):
    if x in (0, 1):
        return x
    return mfib(x-1) + mfib(x-2)
