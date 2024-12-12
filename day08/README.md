<h1 align="center">
  Day08 - Bash <br>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/>
  <br>
</h1>

## Usage

```bash
bash day08.sh
```

## Task

### First

### Second

## Personal

Scanning across the city, you find antennas. Each antenna is tuned to a specific **frequency** indicated by a single lowercase letter, uppercase letter, or digit. You create a map (the puzzle input) of these antennas.

```
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
```

The signal only applies its nefarious effect at specific **antinodes** based on the resonant frequencies of the antennas. In particular, antinode occurs at any point that is perfectly in line with two antennas of the same frequency - but only when one of the antennas is twice as far away as the other. This means that for any pair of antennas with the same frequency, there are two antinodes, one on either side of them.
<br>
So, for these two antennas with frequency `a`, they create the two antinodes marks with `#`:

```
..........
...#......
..........
....a.....
..........
.....a....
..........
......#...
..........
..........
```

Adding a third antenna with the same frequency creates several more antinodes. It would ideally add four antinodes, but two are off the right side of the map, so instead it adds only two:

```
..........
...#......
#.........
....a.....
........a.
.....a....
..#.......
......#...
..........
..........

```

Antennas with different frequencies don't create antinodes; `A` and `a` count as different frequencies. However, antinodes \*ùcan\*\* occur at locations that contain antennas. In this diagram, the lone antenna with frequency capital A creates no antinodes but has `a` lowercase-`a`-frequency antinode at its location:

```
..........
...#......
#.........
....a.....
........a.
.....a....
..#.......
......A...
..........
..........
```

The first example has antennas with two different frequencies, so the antinodes they create look like this, plus an antinode overlapping the topmost `A`-frequency antenna:

```
......#....#
...#....0...
....#0....#.
..#....0....
....0....#..
.#....A.....
...#........
#......#....
........A...
.........A..
..........#.
..........#.
```

Because the topmost `A`-frequency antenna overlaps with a `0`-frequency antinode, there are **14** total unique locations that contain an antinode within the bounds of the map.
Calculate the impact of the signal. **How many unique locations within the bounds of the map contain an antinode?**

### Second

After updating your model, it turns out that antinode occurs at **any grid position** exactly in line with at least two antennas of the same frequency, regardless of distance. This means that some of the new antinodes will occur at the position of each antenna (unless that antenna is the only one of its frequency).

So, these three `T`-frequency antennas now create many antinodes:

```
T....#....
...T......
.T....#...
.........#
..#.......
..........
...#......
..........
....#.....
..........
```

In fact, the three `T`-frequency antennas are all exactly in line with two antennas, so they are all also antinodes: This brings the total number of antinodes in the above example to `9`.

The original example now has `34` antinodes, including the antinodes that appear on every antenna:

```
##....#....#
.#.#....0...
..#.#0....#.
..##...0....
....0....#..
.#...#A....#
...#..#.....
#....#.#....
..#.....A...
....#....A..
.#........#.
...#......##
```

Calculate the impact of the signal using this updated model. **How many unique locations within the bounds of the map contain an antinode?**

## Personal

It was rather difficult to succeed in this exercise in Bash.
<br>
As far as I know, Bash has no `Set` and converts everything to `string`, which leads to a lot of formatting.
<br>
I think my final code is very readable and understandable, and taking on this challenge was fun.