class Flight
    attr_reader :passengers

    def initialize(flight_num, capacity)
        @flight_number = flight_num
        @capacity = capacity
        @passengers = []
    end

    def full?
        return @passengers.length == @capacity
    end

    def board_passenger(passenger)
        if passenger.has_flight?(@flight_num) && !self.full?
            @passengers << passenger
        end
    end

    def list_passengers
        names = @passengers.map { |p| p.name }
    end

    def [](idx)
        @passengers[idx]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end
end