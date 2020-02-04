def bigs(t):
    def f(a, x):
        if a < x.label:
            return 1 + sum(map(lambda b: f(x.label, b), x.branches))
        else:
            return sum(map(lambda b: f(a, b), x.branches))
    return f(-float('inf'), t)

def smalls(t):
    results = []
    def process(t):
        if t.is_leaf():
            return t.label
        else:
            smallest = min([smalls(b) for b in t.branches])
            if t.label < smallest:
                results.append(t.label)
            return min(t.label, smallest)
