<h1 align="center">
  Day03 - Julia
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/>
  <br>
</h1>

## Usage

```bash
julia first.jl
julia second.jl
```

## Task

### First

The input is a **corrupted** program trying to **multiply** some numbers with the instruction `mul(X, Y)`, where `X` and `Y` are each 1-3 digit numbers. For instance, `mul(44,46)` multiplies `44` by `46` to get a result of `2024`. Similarly, `mul(123,4)` would multiply `123` by `4`.

However, invalid characters should be **ignored**. Sequences like `mul(32,64]` do **nothing**.
For example, consider the following selection of corrupted memory:
`x`**mul(2,4)**`%&mul[3,7]!@^do_not_`**mul(5,5)**`+mul(32,64]then(`**mul(11,8)**`mul(8,5))`
Only the four highlighted sections are real `mul` instructions. Adding up the result of each instructions produces

```julia
(2*4 + 5*5 + 11*8 + 8*5) = 161
```

### Second

The are two new instructions you'll need to handle:

- The `do()` instruction **enables** future `mul` instructions.
- The `don't()` instruction **disables** future `mul` instructions.

Only the **most recent** `do()` or `don't()` instruction applies. At the beginning of the program, `mul` instructions are **enabled**.

For example:
`x`**mul(2,4)**`&mul[3,7]!^`**don't()**`_mul(5,5)+mul(32,64](mul(11,8)un`**do()**`?`**mul(8,5)**`)`.

This time, the sum of the results is:

```julia
(2*4 + 8*5) = 48
```

## Personal

`Julia` is one of my favorite programming language, I love its Lua-like syntax.
For this day, I wanted to use `regex` pattern matching.

## Task
