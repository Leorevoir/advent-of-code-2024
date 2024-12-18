A_TOKEN_PRICE = 3
B_TOKEN_PRICE = 1
MAX_PRESS = 100


def parse_positions(line):
    parts = line.split(",")
    x = parts[0].split("=" if "=" in parts[0] else "+")[1]
    y = parts[1].split("=" if "=" in parts[1] else "+")[1]
    return (int(x), int(y))


def get_fewest_tokens(a, b, prize):
    best_a, best_b = -1, -1

    for button_a in range(0, prize[0] // a[0] + 1):
        remaining = prize[0] - a[0] * button_a

        if remaining % b[0] == 0:
            button_b = remaining // b[0]

            if a[1] * button_a + b[1] * button_b == prize[1]:
                best_a, best_b = button_a, button_b

    if best_a != -1 and best_b != -1 and best_a < MAX_PRESS and best_b < MAX_PRESS:
        return best_a * A_TOKEN_PRICE + best_b * B_TOKEN_PRICE

    return 0


def main():
    with open("data.txt") as f:
        _prize = lambda p: (p[0] + 10000000000000, p[1] + 10000000000000)
        content = [c.strip() for c in f.readlines() if c.strip()]
        a, b, prize = None, None, None
        resultp1, resultp2 = 0, 0

        for i, line in enumerate(content):
            line = line.strip()

            match i % 3:
                case 0:
                    a = parse_positions(line)
                case 1:
                    b = parse_positions(line)
                case 2:
                    prize = parse_positions(line)
                    resultp1 += get_fewest_tokens(a, b, prize)
                    print(_prize(prize))
                    # resultp2 += get_fewest_tokens(a, b, _prize(prize))

        print("part1:", resultp1)
        # print("part2:", resultp2)


if __name__ == "__main__":
    main()
