class Node

  # assuming this node only works for int32 
  property value : Int32
  # Node? because it can be None
  property next : Node?

  def initialize(@value)
    @next = nil
  end

end


class FileToData

  @lines : Array(String)

  def initialize(filename : String)
    # read only valid lines
    @lines = File.read(filename)
      .split("\n")
      .select { |line| !line.strip.empty? }
  end

  def get_data : Tuple(Array(Tuple(Int32, Int32)), Array(Array(Int32)))
    # initialize both array
    rules = [] of Tuple(Int32, Int32)
    updates = [] of Array(Int32)

    # for line in lines
    @lines.each do |line|

      # append number|number lines to rules
      if line.includes?('|')
        x, y = line.split('|').map(&.to_i)
        rules << {x, y}
      # append number,number lines to updates
      else
        update = line.split(',').map(&.to_i)
        updates << update
      end

    end

    {rules, updates}
  end

end


class LinkedListMixin

  # head can be None so type : Node?
  @head : Node?

  def initialize
    @head = nil
  end

  def append(value : Int32)
    # creates if None
    if @head.nil?
      @head = Node.new(value)

    # else point current to @head
    else
      current = @head
      # while current is not None go to next
      while !current.nil? && !current.not_nil!.next.nil?
        current = current.not_nil!.next
      end

      # append the new node to the end
      current.not_nil!.next = Node.new(value)
    end
  end

  def find_index(value : Int32) : Int32
    # start research to the @head
    index = 0
    current = @head

    # while loop on the list
    while !current.nil?

      # return index if the value is the one we are looking for
      if current.not_nil!.value == value
        return index
      end

      # current = current next
      current = current.not_nil!.next
      index += 1
    end

    # if no index was found :/
    -1
  end

  def is_valid_order(rules : Array(Tuple(Int32, Int32))) : Bool
    # if rule is correctly format
    # get {x, y}
    rules.all? do |x, y|

      # get their index
      index_x = find_index(x)
      index_y = find_index(y)

      # return true if i_x <= i_y
      if index_x != -1 && index_y != -1
        index_x <= index_y
      else
        true
      end

    end
  end

end

