def best_meeting_point(grid):
    house_coordinates = [
        (i, j)
        for i, row in enumerate(grid)
        for j, cell in enumerate(row)
        if cell == 1
    ]

    house_x = [coord[0] for coord in house_coordinates]
    house_y = [coord[1] for coord in house_coordinates]

    sorted_x = bucket_sort(house_x, len(grid))
    sorted_y = bucket_sort(house_y, len(grid[0]))

    median_x = find_median(sorted_x)
    median_y = find_median(sorted_y)

    return sum(
        abs(coord[0] - median_x) + abs(coord[1] - median_y)
        for coord in house_coordinates
    )

def bucket_sort(coordinates, grid_size):
    buckets = [[] for _ in range(grid_size)]
    for coord in coordinates:
        buckets[coord].append(coord)
    return [
        index
        for index, count in enumerate(buckets)
        for _ in range(len(count))
    ]

def find_median(sorted_coordinates):
    length = len(sorted_coordinates)
    if length % 2 == 0:
        return (sorted_coordinates[length // 2] + sorted_coordinates[length // 2 - 1]) // 2
    return sorted_coordinates[length // 2]

import unittest

class BestMeetingPointTests(unittest.TestCase):
    def test(self):
        grid = [[1, 0, 0, 0, 1], [0, 0, 0, 0, 0], [0, 0, 1, 0, 0]]
        self.assertEqual(best_meeting_point(grid), 6)

if __name__ == "__main__":
    unittest.main()