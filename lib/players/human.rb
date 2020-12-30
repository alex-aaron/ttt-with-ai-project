module Players
    class Human < Player

        def move(board)
            user_move = gets.chomp
            user_move
        end
    end
end