class Item
    attr_accessor :title, :deadline, :description

    def self.valid_date?(date_string)
        year = date_string[0..3].to_i
        month = date_string[5..6].to_i
        day = date_string[8..9].to_i
        if !(month >= 1 && month <= 12)
            return false
        end
        if !(day >= 1 && day <= 31)
            return false
        end
        return true
    end 

    def initialize(title, deadline, description)
        if !Item.valid_date?(deadline)
            raise "Invalid date."
        end

        @title = title
        @deadline = deadline
        @description = description
    end

    def deadline=(deadline)
        if !Item.valid_date?(deadline)
            raise "Invalid deadline."
        else
            @deadline = deadline
        end
    end
end
