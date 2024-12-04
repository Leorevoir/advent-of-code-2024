class FileToMatrix

  attr_reader :matrix

  def initialize(filename)
    @filename = filename
    @matrix = parse_matrix
  end

  def parse_matrix
    # read each line and split text to array of chars
    File.readlines(@filename).map {
      |line| line.chomp.chars
    }
    end

end


class MatrixPatternSearch < FileToMatrix

  # eight possible directions
  DIRECTIONS = [
    [0, 1],
    [1, 0],
    [0, -1],
    [-1, 0],
    [1, 1],
    [-1, -1],
    [1, -1],
    [-1, 1],
  ]

  def initialize(filename, pattern)
    super(filename)
    @pattern = pattern
  end

  def search
    count = 0

    # double "for" loop to get @matrix x and y
    @matrix.each_with_index do |row, x|
      row.each_with_index do |_, y|

        count += search_every_directions(x, y)

      end
    end

    count
  end

  def search_every_directions(x, y)
    count = 0

    # iterate every possible directions
    DIRECTIONS.each do |dx, dy|
      count += 1 if match_pattern?(x, y, dx, dy)
    end

    count
  end

  def match_pattern?(x, y, dx, dy)
    
    # "for" loop to iterate each @pattern char
    @pattern.chars.each_with_index do |char, i|

      # nx, ny = new pos with i
      nx, ny = x + i * dx, y + i * dy
      
      # check if new position is out of bounds
      return false if nx < 0 || 
                     ny < 0 || 
                     nx >= @matrix.length || 
                     ny >= @matrix[0].length
      
      # check if current character matches
      return false unless @matrix[nx][ny] == char
    end

    true
  end

end

result = MatrixPatternSearch.new("data.txt", "XMAS")
count = result.search
puts "first task found: #{count}"
