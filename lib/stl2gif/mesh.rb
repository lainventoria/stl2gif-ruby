module Stl2gif
  class Mesh
    attr_accessor :triangles

    def initialize(faces)
      faces = faces.faces if faces.is_a? STL
      @triangles = faces.map do |triangle|
        Triangle.new(triangle)
      end
    end

    def to_pov
      "mesh { #{triangles.map(&:to_pov).join(' ')} }"
    end
  end
end
