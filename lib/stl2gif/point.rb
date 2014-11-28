module Stl2gif
  class Point
    def initialize(coordinates)
      @coordinates = coordinates
    end

    def to_pov
      "<#{x},#{y},#{z}>"
    end

    def x
      @coordinates[0]
    end

    def y
      @coordinates[1]
    end

    def z
      @coordinates[2]
    end
  end
end
