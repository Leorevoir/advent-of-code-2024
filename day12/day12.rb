class GardenGroups

    DIRECTIONS = [[0,1], [0,-1], [1,0], [-1,0]]
    CORNERS_DIRS = [
        [[-1, 0], [0, 1]],
        [[-1, 0], [0, -1]],
        [[1, 0], [0, 1]],
        [[1, 0], [0, -1]]
    ]


    def initialize(filename)
        @garden = File.readlines(filename, chomp:true).map { |line| line.chars }
        @labels = @garden.flatten.uniq.select { |label| label.match?(/[a-zA-Z0-9]/)}
        @cols = @garden.length
        @rows = @garden[0].length
    end

    def is_invalid?(x, y, label)
        x < 0 || y < 0 || y >= @cols || x >= @rows || @garden[y][x] != label
    end

    def find_regions(label)
        visited = Array.new(@cols) { Array.new(@rows, false) }
        regions = []

        @garden.each_with_index do |row, y|
            row.each_with_index do |cell, x|
                # if cell is valid
                if cell == label && !visited[y][x]
                    # find a new region
                    region = []
                    depth_first_search(y, x, label, visited, region)
                    regions << region
                end
            end
        end

        regions
    end

    def depth_first_search(y, x, label, visited, region)
        return if is_invalid?(x, y, label) || visited[y][x]

        # mark region as visited and append to region
        visited[y][x] = true
        region << [y, x]

        # explore adjacents cells
        DIRECTIONS.each do |dy, dx|
            depth_first_search(y + dy, x + dx, label, visited, region)
        end
    end

    def get_perimeter(x, y, label)
        perimeter = 0

        DIRECTIONS.each do |dy, dx|
            new_y, new_x = y + dy, x + dx
            perimeter += 1 if is_invalid?(new_x, new_y, label)
        end
        perimeter
    end

    def get_corners(x, y, label)
        corners = 0

        CORNERS_DIRS.each do |(dx, dy)|

            # get corner/diag xy pos
            y1, x1 = y + dx[0], x + dx[1]
            y2, x2 = y + dy[0], x + dy[1]
            y3, x3 = y + dx[0] + dy[0], x + dx[1] + dy[1]

            # get corner/diag in the garden if valid else nothing
            c1 = is_invalid?(x1, y1, label) ? ' ' : @garden[y1][x1]
            c2 = is_invalid?(x2, y2, label) ? ' ' : @garden[y2][x2]
            c3 = is_invalid?(x3, y3 , label) ? ' ' : @garden[y3][x3]

            if (label != c1 && label != c2) || (label == c1 && label == c2 && c3 != label)
              corners += 1
            end
        end
        corners
    end

    def get_garden_metrics(region, label)
        perimeter = 0
        corners = 0

        region.each do |y, x|
            perimeter += get_perimeter(x, y, label)
            corners += get_corners(x, y, label)
        end

        [perimeter, corners]
    end

    def get_inflation(label)
        regions = find_regions(label)
        part1 = 0
        part2 = 0

        # total price for all regions of this label
        regions.each do |region|
            area = region.size
            perimeter, corners = get_garden_metrics(region, label)
            part1 += area * perimeter
            part2 += area * corners
        end

        [part1, part2]
    end

    def real_estate
        part1 = 0
        part2 = 0

        # parse each uniq label if valid
        @labels.each do |label|
            p1, p2 = get_inflation(label)
            part1 += p1
            part2 += p2
        end

        [part1, part2]
    end
end


agent = GardenGroups.new("data.txt")
puts agent.real_estate

