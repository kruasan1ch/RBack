class PiPos
    def initialize(have_pi, pos)
        @have_pi = have_pi
        @pos = pos
    end

    def have_pi
        @have_pi
    end

    def pos
        @pos
    end
end

module Pos
    NONE = 0
    LEFT = 1
    RIGHT = 2
end