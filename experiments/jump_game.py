class Solution:
    def maxjumps(self, arr: list[int], d: int) -> int:
        length = len(arr)
        max_jumps = {}
        def start_from_index(i):
            if i in max_jumps:
                return max_jumps[i]
            max_jumps[i] = 1
            for di in [-1, 1]:
                for j in range(i + di, i + (d + 1) * di, di):
                    if not (0 <= j < length and arr[i] > arr[j]):
                        break
                    else:
                        max_jumps[i] = max(max_jumps[i], 1 + start_from_index(j))
        return max(map(start_from_index, range(0, length)))
