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


class MatrixCrossPatternSearch < FileToMatrix

  def initialize(filename, pattern)
    super(filename)
    @middle = pattern.length / 2
    @pattern = pattern
    @format_pattern = get_format_pattern
  end

  def get_format_pattern
    # creates a set without the middle
    # in python it is like doing:
    # return {char for i, char in pattern if i != middle}
    @pattern.chars.each_with_index.with_object(Set.new) do |(char, i), result|
      result.add(char) unless i == @middle
    end
  end

  def search
    count = 0
    row_count = @matrix.length
    col_count = @matrix[0].length

    # double "for" loop to get @matrix x and y
    # but now exclude borders to prevent out of bounds
    (1..row_count - 2).each do |x|
      (1..col_count - 2).each do |y|
        count += 1 if search_cross_directions?(x, y)
      end
    end

    count
  end

  def search_cross_directions?(x, y)
    # only continue if center == middle
    return false unless @matrix[x][y] == @pattern[@middle]

    top_left = @matrix[x - 1][y - 1]
    top_right = @matrix[x - 1][y + 1]
    bottom_left = @matrix[x + 1][y - 1]
    bottom_right = @matrix[x + 1][y + 1]

    # compare with pattern (except middle)
    return false unless Set.new([top_left, bottom_right]) == @format_pattern
    return false unless Set.new([top_right, bottom_left]) == @format_pattern

    true
  end

end


result = MatrixCrossPatternSearch.new("data.txt", "MAS")
count = result.search
puts "result = #{count}"

