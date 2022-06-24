require_relative "item"

class List
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description = "")
        if !Item.valid_date?(deadline)
            raise "Invalid deadline."
            return false
        else
            @items << Item.new(title, deadline, description)
            return true
        end
    end

    def size
        return @items.length
    end

    def valid_index?(index)
        return @items[index] != nil
    end

    def swap(index_1, index_2)
        if self.valid_index?(index_1) && self.valid_index?(index_2)
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        else
            return false
        end
    end

    def [](index)
        if !self.valid_index?(index)
            return nil
        else
            return @items[index]
        end
    end

    # assumes the top of the list is the first item
    def priority
        return @items[0]
    end

    def print
        puts "-" * 45
        puts @label
        puts "-" * 45
        puts "#{"Index".ljust(7)} | #{"Item".ljust(21)} | Deadline".ljust(45)
        @items.each_with_index do |item, i|
            puts "#{i.to_s.ljust(7)} | #{item.title.ljust(21)} | #{item.deadline.ljust(45)}"
        end
        puts "-" * 45
    end
end
