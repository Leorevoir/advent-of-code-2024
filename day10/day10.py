from typing import List, Set, Tuple


DIRECTIONS = [(0, 1), (0, -1), (1, 0), (-1, 0)]


def find_hiking_trail(
    matrix: List[List[int]], start_x: int, start_y: int, height: int, width: int
) -> Tuple[Set[Tuple[int, int]], Set[str]]:

    peak_positions: Set[Tuple[int, int]] = set()
    unique_trails: Set[str] = set()

    def trail_to_string(path: List[Tuple[int, int]]) -> str:
        """TypeError: unhashable type: 'list' 😠"""
        return ",".join(f"{x},{y}" for x, y in path)

    def is_valid_move(curr_x: int, curr_y: int, next_x: int, next_y: int) -> bool:
        return (
            0 <= next_x < height
            and 0 <= next_y < width
            and matrix[next_x][next_y] == matrix[curr_x][curr_y] + 1
        )

    def depth_first_search(
        curr_x: int, curr_y: int, current_path: List[Tuple[int, int]]
    ) -> None:
        # add current pos to the path
        current_path = current_path + [(curr_x, curr_y)]

        # track peak positions
        if matrix[curr_x][curr_y] == 9:
            peak_positions.add((curr_x, curr_y))
            unique_trails.add(trail_to_string(current_path))

        for dx, dy in DIRECTIONS:
            next_x, next_y = curr_x + dx, curr_y + dy

            if is_valid_move(curr_x, curr_y, next_x, next_y):
                depth_first_search(next_x, next_y, current_path)

    depth_first_search(start_x, start_y, [])

    return peak_positions, unique_trails


def main(filename: str) -> None:
    with open(filename, "r") as f:
        matrix = [[int(height) for height in line.strip()] for line in f]

    height, width = len(matrix), len(matrix[0])
    trailhead_scores: List[int] = []
    trailhead_ratings: List[int] = []

    for x, y in [
        (x, y) for x in range(height) for y in range(width) if matrix[x][y] == 0
    ]:
        trail_peaks, rating = find_hiking_trail(matrix, x, y, height, width)
        trailhead_scores.append(len(trail_peaks))
        # rating = find_distinct_trails(matrix, x, y, height, width)
        # trailhead_ratings.append(len(rating))
        trailhead_ratings.append(len(rating))

    print("Part 1:", sum(trailhead_scores))
    print("Part 2:", sum(trailhead_ratings))


if __name__ == "__main__":
    main("data.txt")
