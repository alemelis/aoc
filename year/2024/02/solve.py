with open("input.txt", 'r') as f:
    lines = f.readlines()

levels = []
for line in lines: # O(n)
    levels.append([*map(int, line.strip().split())])

def check(line):
    if sorted(line) != line and sorted(line, reverse=True) != line: # O(len(line) log(len(line)))
        return False
    for i in range(len(line)-1):
        if not 0<abs(line[i]-line[i+1])<4:
            return False
    return True

# *
count = 0
for line in levels: # O(n * m log m); n = num lines, m = len(line)
    count += check(line)
print(count)

# **
def check2(line):
    if check(line):
        return True

    for i in range(len(line)): # O(len(line)^2 log(len(line)))
        new_line = [e for j, e in enumerate(line) if j!=i]
        if check(new_line):
            return True
    return False

count = 0
for line in levels: # O(n * m^2 log m)
    count += check2(line)
print(count)