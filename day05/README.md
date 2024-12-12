<h1 align="center">
  Day05 - Crystal<br>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/>
  <br>
</h1>

## Usage

> [!WARNING]
> Crystal takes a while to compile
> But the binary is super fast !

```bash
# run immediately
crystal run first.cr
crystal run second.cr

# or compile a binary
bash build.sh
# and execute the binary
./first
./second
```

## Task

### First

Let the puzzle input:

```bash
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
```

The first section specifies the _page ordering rules_, one per line. The first rule, `47|53`, means that if an update includes both page number `47` and page number `53`, then page number `47` **must** be printed at some point before page number `53`.

> [!IMPORTANT] > `47` doesn't necessarily need to be immediately before `53`
> other pages are allowed to be between them.

The second section specifies the page numbers of each **update**.
The first update `75,47,61,53,29`, means that the update consists of page numbers `75,47,61,53` and `29`.
The goal is to identify **which updates are already in the right order**.

In the above example, the first update (`75,47,61,53,29`) is in the right order:

- `75`is correctly first because there are rules that put each other page after it: `75|61`, `75|53`, and `75|29`.
- `47` is correctly second because `75` must be before it (`75|47`) and every other page must be after it according to `47|61`, `47|53`, and `47|29`.
- `61` is correctly in the middle because `75` and `47` are before it (`75|61`) and `47|61` and `53` and `29` are after it (`61|53`) and `61|29`).
- `53` is correctly fourth because it is before page number`29` (`53|29`).
- `29` is the only page left and so is correctly last.

The fourth, fifth and the last update is **not** in the correct order due to breaking several rules.

Find the **middle page number** of each correct update and add theses page numbers.
75,47,**61**,53,29
97,61,**53**,29,13
75,**29**,13

By adding `61`, `53` and `29` together, we obtain the result of **143**.

Determine which updates are already in the correct order. **What do you get if you add up the middle page number from those correctly-ordered updates?**

### Second

For each of the **incorrectly-ordered updates**, use the page ordering rules to put the page numbers in the right order.
For the above example, here are the three incorrectly-ordered updates and their correct orderings:

- `75,97,47,61,53` becomes 97,75,**42**,61,53.
- `61,13,29` becomes 61,**29**,13.
- `97,13,75,29,47`becomes 97,75,**47**,29,13.

After taking **only the incorrectly-ordered updates** and ordering them correctly, their middle page numbers are `47`, `29` and `47`. Adding the together produces **123**.
<br>
Find the updates which are not in the correct order. **What do you get if you add up the middle page numbers after correctly ordering just those updates?**

## Personal

This was the first time I wrote `Crystal` code. I love its _rubysh_ friendly syntax and its performances.
<br>
To succeed in this exercise, I thought of linked-lists.
