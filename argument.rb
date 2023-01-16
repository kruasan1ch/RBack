require_relative 'pi_pos'

include Pos

class Argument
    def initialize(left, right, discrete, value, name)
        @left = left
        @right = right
        @discrete = discrete
        @value = value
        @name = name
        @pi_pos = PiPos.new(false, Pos::NONE)
    end

    def pi_pos
        @pi_pos
    end

    def pi_pos=(pi_pos)
        @pi_pos=pi_pos
    end

    def name
        @name
    end

    def value
        @value
    end

    def value=(value)
        @value=value
    end

    def left
        @left
    end

    def right
        @right
    end

    def left=(left)
        @left=left
    end

    def right=(right)
        @right=right
    end

    def discrete
        @discrete
    end

    def validate
        vals = (@left...@right).step(discrete).to_a
        for value in vals do
            if @value.eql?(value)
                return true
            end
        end
        return false
        # return (@left...@right).include?(@value)
    end
end

module Arguements
    A = 0
    B = 1
    C = 2
    D = 3
    X = 4
end