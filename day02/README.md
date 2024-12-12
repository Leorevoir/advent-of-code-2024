<h1 align="center">
  Day02 - Lua<br>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/>
  <br>
</h1>

## Usage

```bash
lua first.lua
lua second.lua
```

## Task

This example data contains six reports each containing five levels.

```bash
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
```

### First

- The levels are either **all increasing** or **all decreasing**.
- Any two adjacent levels differ by **at least one** and **at most three**.

In the example above, the reports can be found safe or unsafe by checking those rules:

- `7 6 4 2 1`: **Safe** because the levels are all decreasing by `1` or `2`.
- `1 2 7 8 9`: **Unsafe** because `2 7` is an increase of `5`.
- `9 7 6 2 1`: **Unsafe** because `6 2` is a decrease of `4`.
- `1 3 2 4 5`: **Unsafe** because `1 3` is increasing but `3 2` is decreasing.
- `8 6 4 4 1`: **Unsafe** because `4 4` is neither an increase or a decrease.
- `1 3 6 7 9`: **Safe** because the levels are all increasing by `1`, `2`, or `3`.

In this example, `2` reports are **safe**.

### Second

Now, the same rules apply as before, except if removing a single level from an unsafe report would make it safe, the report instead counts as safe.

More of the above example's reports are now safe:

- `7 6 4 2 1`: **Safe** without removing any level.
- `1 2 7 8 9`: **Unsafe** regardless of which level is removed.
- `9 7 6 2 1`: **Unsafe** regardless of which level is removed.
- `1 `**3**` 2 4 5`: **Safe** by removing the second level, `3`.
- `8 6 `**4**` 4 1`: \*_Unsafe_ by removing the third level, `4`.
- `1 3 6 7 9`: **Safe** without removing any level.

`4` reports are actually **safe**!

## Personal

I haven't code is `Lua` since a long time. I am sure there are better ways to do it but at least it is working.
