def memoize(fn):
	cache = {}
	def helper(x):
		if x not in cache:
			cache[x] = fn(x)
		return cache[x]
	return helper

@memoize
def fib(x):
	if x < 2:
		return x
	return fib(x - 1) + fib(x - 2)
