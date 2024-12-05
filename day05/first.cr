require "./utils"


class LinkedList < LinkedListMixin

end


rules, updates = FileToData.new("data.txt").get_data

# select method filters 'updates' array
# and only keep those element that satisfy condition
valid_updates = updates.select do |update|

  ll = LinkedList.new
  update.each { |page| ll.append(page) }
  # and here is our condition
  ll.is_valid_order(rules)

end


# only get middle pages of valid updates
middle_pages = valid_updates.map { |update| update[update.size // 2] }

result = middle_pages.sum
puts "first task found: #{result}"
