A_TOKEN_PRICE = 3
B_TOKEN_PRICE = 1
MAX_PRESS = 100


def parse_positions(line):
    parts = line.split(",")
    x = parts[0].split("=" if "=" in parts[0] else "+")[1]
    y = parts[1].split("=" if "=" in parts[1] else "+")[1]
    return (int(x), int(y))


def get_fewest_tokens(a, b, prize, max=True):

    def is_valid(a_press, b_press) -> bool:
        valid: bool = a_press == int(a_press) and b_press == int(b_press)

        # part1 has a max press count defined in MAX_PRESS
        if max is True:
            return 0 <= a_press < MAX_PRESS and 0 <= b_press < MAX_PRESS and valid
        return valid

    # determinant of the coefficient matrix
    determinant = a[0] * b[1] - a[1] * b[0]
    # base total formula
    total = lambda x, y: int(x * A_TOKEN_PRICE + y * B_TOKEN_PRICE)

    # cannot divide by 0
    if determinant == 0:
        return 0

    # i used cramer's rule to solve this linear equation
    # replace the first column of the coefficient matrix with the prize value
    # then divide the result by the determinant
    best_a = (prize[0] * b[1] - prize[1] * b[0]) / determinant
    # same but replace the second column of the coefficient matrix with the prize value
    # then divide the result by the determinant
    best_b = (a[0] * prize[1] - a[1] * prize[0]) / determinant

    return total(best_a, best_b) if is_valid(best_a, best_b) else 0


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
                    resultp2 += get_fewest_tokens(a, b, _prize(prize), False)

        print("part1:", resultp1)
        print("part2:", resultp2)


if __name__ == "__main__":
    main()
