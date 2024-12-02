f = open("data.txt", "r")
lines = f.readlines()

left = []
right = []

for line in lines:
    line = line.strip()
    if line:
        n1, n2 = map(int, line.split(";"))
        left.append(n1)
        right.append(n2)

left.sort()
right.sort()

d = 0
for l, r in zip(left, right):
    d += abs(l - r)

print(d)
