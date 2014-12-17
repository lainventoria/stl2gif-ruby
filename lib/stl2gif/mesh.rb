module Stl2gif
  class Mesh
    attr_accessor :triangles

    def initialize(triangles)
      @triangles = triangles.map do |triangle|
        Triangle.new(triangle)
      end
    end

    def to_pov
      "mesh { #{triangles.map(&:to_pov).join(' ')} }"
    end
  end
end
