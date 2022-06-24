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
        puts "-" * 53
        puts @label.upcase
        puts "-" * 53
        puts "#{"Index".ljust(7)} | #{"Item".ljust(21)} | #{"Deadline".ljust(11)} | Done".ljust(10) 
        puts "-" * 53
        @items.each_with_index do |item, i|
            puts "#{i.to_s.ljust(7)} | #{item.title.ljust(21)} | #{item.deadline.ljust(11)} | #{item.done}".ljust(10)
        end
        puts "-" * 53
    end

    def print_full_item(index)
        if self.valid_index?(index)
            puts "-" * 53
            puts "#{@items[index].title.ljust(34)}#{@items[index].deadline.ljust(11)} | #{@items[index].done}".ljust(10)
            puts "#{@items[index].description.ljust(53)}"
            puts "-" * 53
        end
    end

    def print_priority
        self.print_full_item(0)
    end

    def up(index, amount = 1)
        if !self.valid_index?(index)
            return false
        else
            copy = @items[index]
            @items.delete_at(index)
            if index - amount <= 0
                    @items.insert(0, copy)
            else
                    @items.insert(index - amount, copy)
            end
            return true
        end
    end

    def down(index, amount = 1)
        if !self.valid_index?(index)
            return false
        else
            copy = @items[index]
            @items.delete_at(index)
            if index + amount >= @items.length
                    @items.insert(-1, copy)
            else
                    @items.insert(index + amount, copy)
            end
            return true
        end
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline }
    end

    def toggle_item(index)
        if !self.valid_index?(index)
            return false
        else
            @items[index].toggle
        end
    end

    def remove_item(index)
        if !self.valid_index?(index)
            return false
        else
            @items.delete_at(index)
            return true
        end
    end

    def purge
        while !@items.all? { |it| !it.done }
            @items.each_with_index do |item, i|
                if item.done
                    @items.delete_at(i)
                end
            end
        end
    end
end
