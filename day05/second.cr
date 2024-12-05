require "./utils.cr"


class LinkedList < LinkedListMixin

  def page_rules_reorder(rules : Array(Tuple(Int32, Int32))) : Array(Int32)
    nodes = to_array
    reorder_by_rules(nodes, rules)
  end

  private def to_array : Array(Int32)
    # extract node values to an array
    nodes = [] of Int32
    current = @head

    # while current not null
    while !current.nil?
      # append
      nodes << current.not_nil!.value
      # current = current next
      current = current.not_nil!.next
    end
    nodes
  end


  private def reorder_by_rules(nodes : Array(Int32), rules : Array(Tuple(Int32, Int32))) : Array(Int32)
    sorted = nodes.dup
    
    while !rules.all? { |x, y| 
      x_index = sorted.index(x)
      y_index = sorted.index(y)
      x_index && y_index && x_index <= y_index 
    }
      rules.each do |x, y|
        x_index = sorted.index(x)
        y_index = sorted.index(y)
        
        if x_index && y_index && x_index > y_index
          sorted[x_index], sorted[y_index] = sorted[y_index], sorted[x_index]
        end
      end
    end
    
    sorted
  end
  private def reorder_by_rules(nodes : Array(Int32), rules : Array(Tuple(Int32, Int32))) : Array(Int32)
    # creates a copy to avoid modifying original
    sorted = nodes.dup

    # loop on rule
    loop do
      swapped = apply_single_pass_rules(sorted, rules)
      # until no more swaps are needed
      break unless swapped
    end

    sorted
  end

  private def apply_single_pass_rules(nodes : Array(Int32), rules : Array(Tuple(Int32, Int32))) : Bool
    swapped = false

    rules.each do |x, y|
      x_index = nodes.index(x)
      y_index = nodes.index(y)
      
      # swap if rule is violated
      if x_index && y_index && x_index > y_index
        nodes[x_index], nodes[y_index] = nodes[y_index], nodes[x_index]
        swapped = true
      end
    end

    swapped
  end
end


rules, updates = FileToData.new("data.txt").get_data

# select method filters 'updates' array
# and only keeps those element that satisfy condition
incorrect_updates = updates.select do |update|

  ll = LinkedList.new
  update.each { |page| ll.append(page) }
  # and here is our condition
  !ll.is_valid_order(rules)

end

middle_pages = incorrect_updates.map do |update|
  ll = LinkedList.new
  update.each { |page| ll.append(page) }
  reordered = ll.page_rules_reorder(rules)
  reordered[reordered.size // 2]
end

result = middle_pages.sum
puts "second task found: #{result}"
