module Stl2gif
  class Triangle
    attr_accessor :point_1, :point_2, :point_3

    def initialize(points)
      points = points.points if points.is_a? Geometry::ScaleneTriangle
      points = points.points if points.is_a? STL::Face
      @point_1 = Point.new(points[0])
      @point_2 = Point.new(points[1])
      @point_3 = Point.new(points[2])
    end

    def to_pov
      "triangle { #{point_1.to_pov}, #{point_2.to_pov}, #{point_3.to_pov} }"
    end
  end
end
