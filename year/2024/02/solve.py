with open("input.txt", 'r') as f:
    levels = [[*map(int, line.strip().split())] for line in f.readlines()] # O(n)

def check(line):
    if sorted(line) != line and sorted(line, reverse=True) != line: # O(len(line) log(len(line))) = const
        return False
    for i in range(len(line)-1):
        if not 0<abs(line[i]-line[i+1])<4:
            return False
    return True

# *
count = sum(check(line) for line in levels) # O(n)
print(count)

# **
def check2(line):
    if check(line):
        return True

    for i in range(len(line)): # O(len(line)^2 log(len(line))) = const
        new_line = [e for j, e in enumerate(line) if j!=i]
        if check(new_line):
            return True
    return False

count = sum(check2(line) for line in levels) # O(n)
print(count)