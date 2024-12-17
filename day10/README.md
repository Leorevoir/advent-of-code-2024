<h1 align="center">
  Day10 - Python <br>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/>
  <br>
</h1>

---

## Usage

```bash
python3 day10.py
```

---

## Task

### First

The `topographic` map indicates the **height** at each position using a scale from `0` (lowest) to `9` (highest). For example:

```plaintext
0123
1234
8765
9876
```

A **hiking trail** is any path that starts at height `0`, ends at height `9`, and always increases by a height of exactly `1` at each step. Hiking trails never include diagonal steps - only up, down, left, or right (from the perspective of the map).
<br>
A **trailhead** is any position that starts one or more hiking trails - here, these positions will always have height `0`. Assembling more fragments of pages, you establish that a trailhead's **score** is the number of `9`-height positions reachable from that trailhead via a hiking trail. In the above example, the single trailhead in the top left corner has a score of `1` because it can reach a single `9` (the one in the bottom left).
<br>
This trailhead has a score of `2`:

```plaintext
...0...
...1...
...2...
6543456
7.....7
8.....8
9.....9
```

> [!NOTE]
> positions `.` are impassable tiles to simplify the example

This trailhead has a score of `4` because every `9` is reachable via a hiking trail except the one immediately to the left of the trailhead:

```plaintext
..90..9
...1.98
...2..7
6543456
765.987
876....
987....
```

This topographic map contains **two** trailheads; the trailhead at the top has a score of `1`, while the trailhead at the bottom has a score of `2`:

```plaintext
10..9..
2...8..
3...7..
4567654
...8..3
...9..2
.....01
```

Here's a larger example:

```plaintext
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
```

This larger example has `9` trailheads. Considering the trailheads in reading order, they have score of `5`, `6`, `5`, `3`, `1`, `3`, `5`, `3` and `5`. Adding these scores together, the sum of the scores of all trailheads is **36**.
<br>
What is the sum of the scores of all trailheads on your topographic map?

### Second

A trailhead's **rating** is the **number of distinct hiking trails** which begin at that trailhead. For example:

```plaintext
.....0.
..4321.
..5..2.
..6543.
..7..4.
..8765.
..9....
```

The above map has a single trailhead; its rating is `3` because there are exactly three distinct hiking trails which begin at that position:

```plaintext
.....0.   .....0.   .....0.
..4321.   .....1.   .....1.
..5....   .....2.   .....2.
..6....   ..6543.   .....3.
..7....   ..7....   .....4.
..8....   ..8....   ..8765.
..9....   ..9....   ..9....
```

Here is a map containing a single trailhead with rating `13`:

```plaintext
..90..9
...1.98
...2..7
6543456
765.987
876....
987....
```

This map contains a single trailhead with rating `227` (because there are `121` distinct hiking trails that lead to the `9` on the right edge and `106` that lead to the `9` on the bottom edge):

```plaintext
012345
123456
234567
345678
4.6789
56789.
```

Here's the larger example from before:

```plaintext
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
```

Considering its trailheads in reading order, they have ratings of `20`, `24`, `10`, `4`, `1`, `4`, `5`, `8`, and `5`. The sum of all trailhead ratings in this larger example topographic map is **81**.
<br>
What is the sum of the ratings of all trailheads?

---
