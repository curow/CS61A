def combine_skipper(f, lst):
    """

    >>> lst = [4, 7, 3, 2, 1, 8, 5, 6]
    >>> f = lambda l: sum(l)
    >>> lst = combine_skipper(f, lst)
    >>> lst
    [11, 1, 3, 2, 9, 5, 5, 6]
    >>> lst2 = [4, 3, 2, 1]
    >>> lst2 = combine_skipper(f, lst2)
    >>> lst2
    [7, 1, 2, 1]
    """
    n = 0
    while n < len(lst) // 4:
        lst[n*4], lst[n*4+1] = f(lst[n*4 : n*4+2]), n*4+1
        n += 1
    return lst

# Tree ADT
def tree(label, branches=[]):
    """Construct a tree with the given label value and a list of branches."""
    for branch in branches:
        assert is_tree(branch), 'branches must be trees'
    return [label] + list(branches)

def label(tree):
    """Return the label value of a tree."""
    return tree[0]

def branches(tree):
    """Return the list of branches of the given tree."""
    return tree[1:]

def is_tree(tree):
    """Returns True if the given tree is a tree, and False otherwise."""
    if type(tree) != list or len(tree) < 1:
        return False
    for branch in branches(tree):
        if not is_tree(branch):
            return False
    return True

def is_leaf(tree):
    """Returns True if the given tree's list of branches is empty, and False
    otherwise.
    """
    return not branches(tree)

def print_tree(t, indent=0):
    """Print a representation of this tree in which each node is
    indented by two spaces times its depth from the root.

    >>> print_tree(tree(1))
    1
    >>> print_tree(tree(1, [tree(2)]))
    1
      2
    >>> numbers = tree(1, [tree(2), tree(3, [tree(4), tree(5)]), tree(6, [tree(7)])])
    >>> print_tree(numbers)
    1
      2
      3
        4
        5
      6
        7
    """
    print('  ' * indent + str(label(t)))
    for b in branches(t):
        print_tree(b, indent + 1)

def copy_tree(t):
    """Returns a copy of t. Only for testing purposes.

    >>> t = tree(5)
    >>> copy = copy_tree(t)
    >>> t = tree(6)
    >>> print_tree(copy)
    5
    """
    return tree(label(t), [copy_tree(b) for b in branches(t)])

def largest_product_path(tree):
    """
    >>> largest_product_path(None)
    0
    >>> largest_product_path(tree(3))
    3
    >>> t = tree(3, [tree(7, [tree(2)]), tree(8, [tree(1)]), tree(4)])
    >>> largest_product_path(t)
    42
    """
    if not is_tree(tree):
        return 0
    elif is_leaf(tree):
        return label(tree)
    else:
        paths = [largest_product_path(b) for b in branches(tree)]
        return label(tree) * max(paths)

def level_order(tree):
    """
    >>> level_order(tree(3))
    [3]
    >>> level_order(None)
    []
    >>> t = tree(3, [tree(7), tree(8), tree(4)])
    >>> level_order(t)
    [3, 7, 8, 4]
    >>> t = tree(3, [tree(7, [tree(2, [tree(8), tree(1)]), tree(5)])])
    >>> level_order(t)
    [3, 7, 2, 5, 8, 1]
    >>> t = tree(5, [tree(8, [tree(7, [tree(6)])])])
    >>> level_order(t)
    [5, 8, 7, 6]
    """
    if not is_tree(tree):
        return []
    current_level, next_level = [label(tree)], [tree]
    while next_level:
        find_next = []
        for t in next_level:
            find_next.extend([b for b in branches(t)])
        next_level = find_next
        current_level.extend([label(t) for t in next_level])
    return current_level

