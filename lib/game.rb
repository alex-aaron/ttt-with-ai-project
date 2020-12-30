require 'pry'
class Game

    attr_accessor :player_1, :player_2, :board

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        current_turn = @board.turn_count
        if current_turn % 2 == 0 
            @player_1
        else
            @player_2
        end
    end

    # def won?
    #     WIN_COMBINATIONS.any? do |win_combo|
    #         if @board.taken?(win_combo[0]) == true && @board.cells[win_combo[0]] == @board.cells[win_combo[1]] && @board.cells[win_combo[1]] == @board.cells[win_combo[2]]
    #             return win_combo
    #         else
    #             false
    #         end
    #     end
    # end

    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            win_combo.all? {|i| @board.cells[i] == @player_1.token} || win_combo.all? {|i| @board.cells[i] == @player_2.token}
        end
    end

    def draw?
        if !won? && @board.full?
            true
        else
            false
        end
    end

    def over?
        won? || draw?
    end

    # def winner
    #     if won?
    #         winning_combo = won?
    #         if @board.cells[winning_combo[0]] == "X"
    #             "X"
    #         else @board.cells[winning_combo[0]] == "O"
    #             "O"
    #         end
    #     end
    # end

    def winner
        @board.cells[won?.first] if won?
    end

    def turn
        player = current_player
        player_move = player.move(@board)
        if @board.valid_move?(player_move) 
            @board.update(player_move, player)
        else
            turn
        end
    end

    def play
        until over? do
            turn
        end
        
        if won? 
            puts "Congratulations #{self.winner}!"
        else
            puts "Cat's Game!"
        end

    end
end
