class Board

    attr_accessor :cells

    def initialize
        @cells = Array.new(9, " ")
    end

    def display
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    def position(position_choice)
        board_cell = position_choice.to_i - 1
        @cells[board_cell]
    end

    def full?
        @cells.none?(" ")
    end

    def turn_count
        @cells.count do |cell|
            cell != " "
        end
    end

    def valid_move?(position_choice)
        if position_choice.to_i.between?(1, 9) && taken?(position_choice) == false
            true
        end

    end

    def taken?(position_choice)
        if position(position_choice) != " "
            true
        else
            false
        end
    end

    def update(position_choice, player)
        if valid_move?(position_choice)
            cell_move = position_choice.to_i - 1
            @cells[cell_move] = player.token
        end
    end

    def reset!
        @cells = Array.new(9, " ")
    end
end