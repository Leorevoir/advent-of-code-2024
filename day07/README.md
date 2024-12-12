<h1 align="center">
  Day07 - Crystal (again)<br>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/>
  <br>
</h1>
 
## Usage

> [!WARNING]
> Crystal takes a while to compile
> But the binary is super fast !

The program requires the crystal "**big**" library to work with `big integers`.
Ensure you have all dependencies...

```bash
nix develop # on the repo root
```

...or manually install **libgmpris**, **gmp**.

```bash
# run immediately
crystal run day07.cr

# or compile a binary
bash build.sh
# and execute the binary
./day07
```

## Task

### First

Let the puzzle input:

```bash
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
```

Each line represents a single equation. The test value appears before the colon on each line; it is your job to determine whether the remaining numbers can be combined with operators to produce the test value.
<br>
Operators are **always evaluated left-to-right**, **not** according to precedence rules.
Furthermore, numbers in the equations cannot be rearranged.
There are `two` different types of operators:

- **add** (`+`)
- **multiply** (`*`)

Only three of the above equation can be made true by inserting operators:

- `190: 10 19` has only one position that accepts an operator: between `10` and `19`. Choosing `+` would give `29`, but choosing `*` would give the test value (`10 * 19 = `**190**).
- `3267: 81 40 27` has two positions for operators. Of the four possible configurations of the operators, **two** cause the right side to match the test value: `81 + 40 * 27` and `81 * 40 + 27` both equal **3267** (when evaluated left-to-right)!
- `292: 11 6 16 20` can be solved in exactly one way: `11 + 6 * 16 + 20`.

Your goal is to get the **total calibration result**, which is the sum of the test values from just the equations that could possibly be true.
Int the above example the sum of the test values for the three equations listed above is **3749**.

### Second

Let's add a third operator.
<br>
The **concatenation** operator (`||`) combines the digits from its left and right inputs into a single number.
For example, `12 || 345` would become `12345`.
All operators are still evaluated `left-to-right`.

Now, apart from the three equations that could be made true using only addition and multiplication, the above example has three more equations that can be made true by inserting operators:

- `156: 15 6` can be made true through a single concatenation:
- `15 || 6 = 156`.
- `7290: 6 8 6 15` can be made true using `6 * 8 || 6 * 15`.
- `192: 17 8 14` can be made true using `17 || 8 + 14`.

Adding up all six test values (the three that could be made before using only `+` and `*` plus the new three that can now be made by also using `||`) produces the new **total calibration result** of **11387**.

## Personal

At this point, this is my favorite day. I really enjoyed myself doing this exercise in Crystal, learning the optimization.
<br>
I thought that the best way to make an optimized program for this exercise was to do it recursively
