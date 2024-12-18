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

[Day07](https://adventofcode.com/2024/day/7)

## Personal

At this point, this is my favorite day. I really enjoyed myself doing this exercise in Crystal, learning the optimization.
<br>
I thought that the best way to make an optimized program for this exercise was to do it recursively
