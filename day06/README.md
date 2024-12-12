<h1 align="center">
  Day06 - Crystal<br>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/>
  <br>
</h1>

## Usage

> [!WARNING]
> Crystal takes a while to compile
> But the binary is super fast !

```bash
# run immediately
crystal run day06.cr

# or compile a binary
bash build.sh
# and execute the binary
./day06
```

## Task

### First

Let the puzzle input:

```
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...

```

The puzzle shows the current position of the guard with `^` (to indicate the guard is currently facing **up**) from the perspective of the map).
Any **obstructions** are shown as `#`.
<br>
The guard follows a strict patrol protocol which involves repeatedly following these steps:

- If there is something directly in front of you, turn right `90` degrees.
- Otherwise, take a step forward.

Following the above protocol, the guard moves up several times until he reaches an `obstacle`.
<br>
By predicting the guard's route, you can determine which specific positions in the lab will be in the patrol path. **Including the guard's starting position**, the positions visited by the guard before leaving the area are marked with an `X`:

```
....#.....
....XXXXX#
....X...X.
..#.X...X.
..XXXXX#X.
..X.X.X.X.
.#XXXXXXX.
.XXXXXXX#.
#XXXXXXX..
......#X..
```

In this example, the guard visit **41** distinct positions on the map.
<br>
Predict the path of the guard. **How many distinct positions will the guard visit before leaving the mapped area?**

### Second

The historians would like to place the new obstruction in such a way that the guard will get **stuck in a loop**, making the rest of the lab safe to search.
<br>
Your goal is to find **all** of the possible positions for such an obstruction.
The new obstruction can't be placed at the guard's starting position - the guard is there right now and would notice.

In the above example, there are only **6** different positions where a new obstruction would cause the guard to get stuck in a loop.
The diagrams of these `six` situations use `0` to mark the new obstruction, `|` to show a position where the guard moves up/down, `-` to show a position where the guard moves left/right, and `+` to show a position where the guard moves both up/down and left/right.
<br>
Option one, put a printing press next to the guard's starting position:

```
....#.....
....+---+#
....|...|.
..#.|...|.
....|..#|.
....|...|.
.#.O^---+.
........#.
#.........
......#...
```

Option two, put a stack of failed suit prototypes in the bottom right quadrant of the mapped area:

```
....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
......O.#.
#.........
......#...
```

Option three, put a crate of chimney-squeeze prototype fabric next to the standing desk in the bottom right quadrant:

```
....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
.+----+O#.
#+----+...
......#...

```

Option four, put an alchemical retroencabulator near the bottom left corner:

```
....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
..|...|.#.
#O+---+...
......#...

```

Option five, put the alchemical retroencabulator a bit to the right instead:

```
....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
....|.|.#.
#..O+-+...
......#...
```

Option six, put a tank of sovereign glue right next to the tank of universal solvent:

```
....#.....
....+---+#
....|...|.
..#.|...|.
..+-+-+#|.
..|.|.|.|.
.#+-^-+-+.
.+----++#.
#+----++..
......#O..

```

In this example, there are **6** different positions you could choose.
<br>
You need to get the guard stuck in a loop by adding a single new obstruction. **How many different positions could you choose for this obstruction?**

## Personal

I tried coding in Crystal again because I love this language and I really wanted to learn it.
My first attempt for this exercise was in Python, but the second part was too slow due to the loops. With Crystal everything was faster.
