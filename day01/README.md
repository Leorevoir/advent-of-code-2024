<h1 align="center">
  Day01 - Python3<br>
  <img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/>
  <br>
</h1>

## Usage

```bash
python3 first.py
python3 second.py
```

## Task

| right | left |
| ----- | ---- |
| 3     | 4    |
| 4     | 3    |
| 2     | 5    |
| 1     | 3    |
| 3     | 9    |
| 3     | 3    |

### First

Within each pair, figure out **how far apart** the two numbers are; you'll need to **add up all of those distances**. I you pair up a `3` from the left list with a `7` from the right list, the distance apart is `4`; if you pair up a `9` with a `3`, the distance apart is `6`.

In the example above:

- The smallest number in the left list is `1`, and the smallest number in the right list is `3`. The distance between them is **2**.
- The second-smallest number in the left list is `2`, and the second-smallest number in the right list is another `3`. The distance between them is **1**.
- The third-smallest number in both lists is `3`, so the distance between them is **0**.
- The next numbers to pair up are `3` and `4`, a distance of **1**.
- The fifth-smallest numbers in each list are `3` and `5`, a distance of **2**.
- Finally, the largest number in the left list is `4`, while the largest number in the right list is `9`; these are a distance **5** apart.

This is `2 + 1 + 0 + 1 + 2 + 5`, a total distance of **11**!

### Second

This time, you'll need to figure out exactly how often each number from the left list appears in the right list. Calculate a total **similarity score** by adding up each number in the left list after multiplying it by the number of times that number appears in the right list.

In the example above:

- The first number in the left list is `3`. It appears in the right list three times, so the similarity score increases by `3 * 3 = `**9**.
- The second number in the left list is `4`. It appears in the right list once, so the similarity score increases by `4 * 1 = `**4**.
- The third number in the left list is `2`. It does not appear in the right list, so the similarity score does not increase `(2 * 0 = 0)`.
- The fourth number, `1`, also does not appear in the right list.
- The fifth number, `3`, appears in the right list three times; the similarity score increases by **9**.
- The last number, `3`, appears in the right list three times; the similarity score again increases by **9**.

The similarity score at the end of this process is **31** `(9 + 4 + 0 + 0 + 9 + 9)`.

## Personal

I took the liberty to format `data.txt` with `semi-colons` to make it look like a `CSV` document because I found it easier to parse in Python.
