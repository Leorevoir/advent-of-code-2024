# class FileToData
#
#     property lines : Array(String)
#     property rows : Int32
#     property cols : Int32
#     property count : Int32
#
#     DIRECTIONS = [
#         {-1, 0},  # up
#         {0, 1},   # right
#         {1, 0},   # down
#         {0, -1}   # left
#     ]
#
#     def initialize(filename : String)
#         @lines = File.read(filename)
#             .split('\n')
#             .select { |line| !line.strip.empty? }
#         @rows = @lines.size
#         @cols = @lines[0].size
#         @count = 0
#     end
#
#     private def get_guard_position : {Int32, Int32}?
#
#         @rows.times do |x|
#             @cols.times do |y|
#                 return {x, y} if @lines[x][y] == '^'
#             end
#         end
#
#         nil
#     end
#
#
#     private def ensure_distinct_position(x : Int32, y : Int32)
#         visited_states = Set(Tuple(Int32, Int32, Int32)).new
#         visited_positions = Set(Tuple(Int32, Int32)).new
#         direction = 0
#
#         tmp = get_guard_position
#         if tmp.nil?
#             exit 84
#         end
#         cx, cy = tmp
#
#         loop do
#
#             if visited_states.includes?({cx, cy, direction})
#                 @count += 1
#                 break
#             end
#
#             visited_states.add({cx, cy, direction})
#             visited_positions.add({cx, cy})
#
#             dx, dy = DIRECTIONS[direction]
#
#             print(dx, ' ', dy, '\n')
#
#             nx = cx + dx
#             ny = cy + dy
#
#             if !(0 <= nx && nx < @rows && 0 <= ny && ny < @cols)
#                 if @lines[x][y] == '#' || (nx == x && ny == y)
#                     direction = (direction + 1) % 4
#                 else
#                     cx, cy = nx, ny
#                 end
#             end
#             
#
#         end
#
#     end
#
#     def map_journey_loop
#         @rows.times { |x| @cols.times { |y| ensure_distinct_position(x, y) } }
#     end
#
# end
#
#
# file = FileToData.new("data.txt")
# file.map_journey_loop

class FileToData
    property lines : Array(String)
    property rows : Int32
    property cols : Int32
    property unique_positions_count : Int32 = 0
    property loop_count : Int32 = 0

    DIRECTIONS = [
        {-1, 0},  # up
        {0, 1},   # right
        {1, 0},   # down
        {0, -1}   # left
    ]

    def initialize(filename : String)
        @lines = File.read(filename)
            .split('\n')
            .select { |line| !line.strip.empty? }
        @rows = @lines.size
        @cols = @lines[0].size
    end

    private def get_guard_position : {Int32, Int32}?
        @rows.times do |x|
            @cols.times do |y|
                return {x, y} if @lines[x][y] == '^'
            end
        end
        nil
    end

    private def check_visited_positions(x : Int32, y : Int32)
        visited_states = Set(Tuple(Int32, Int32, Int32)).new
        visited_positions = Set(Tuple(Int32, Int32)).new
        direction = 0

        # error handling bc crystal wont compile if type is not secure
        tmp = get_guard_position
        raise "No guard position found" if tmp.nil?
        cx, cy = tmp

        loop do
            # check if we've been in this state before
            if visited_states.includes?({cx, cy, direction})
                @loop_count += 1
                break
            end

            visited_states.add({cx, cy, direction})
            visited_positions.add({cx, cy})

            # compute next positions based on the direction
            dx, dy = DIRECTIONS[direction]
            nx = cx + dx
            ny = cy + dy

            # check map boundaries
            if !(0 <= nx < @rows && 0 <= ny < @cols)
                if @lines[x][y] == '#'
                    @unique_positions_count = visited_positions.size
                end
                break
            end

            # compute direction for rotation (90° rotate -> right)
            if @lines[nx][ny] == '#' || (nx == x && ny == y)
                direction = (direction + 1) % 4

            # else move forward
            else
                cx = nx
                cy = ny
            end

        end
    end

    def map_journey_loop
        @rows.times { |x| @cols.times { |y| check_visited_positions(x, y) } }
    end
end


file = FileToData.new("data.txt")
file.map_journey_loop
puts "task 01", file.unique_positions_count
puts "task 02", file.loop_count
