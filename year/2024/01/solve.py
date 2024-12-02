with open("input.txt", 'r') as f:
    lines = f.readlines()

lx, rx = [], []
for line in lines: # O(n)
    l, r = map(int, line.strip().split())
    lx.append(l)
    rx.append(r)

# O(n log n)
lx = sorted(lx)
rx = sorted(rx)

# *
dist = 0
for i, l in enumerate(lx): # O(n)
    dist += abs(l - rx[i])
print(dist)

# **
from collections import Counter
counter = Counter(rx)

dist = 0
for l in lx: # O(n)
    if l in counter:
        dist += l*counter[l]
print(dist)