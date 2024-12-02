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
rc = {}
for num in right:
    rc[num] = rc.get(num, 0) + 1

s = 0
for num in left:
    s += num * rc.get(num, 0)

print(s)
