require 'minitest_helper'

describe Stl2gif do
  describe Stl2gif::Point do
    subject { Stl2gif::Point.new([0,1,2]) }

    it 'returns pov' do
      subject.to_pov.must_equal '<0,1,2>'
    end
  end

  describe Stl2gif::Triangle do
    subject { Stl2gif::Triangle.new([[1,0,0], [0,1,0], [0,0,1]]) }

    it 'returns pov' do
      subject.to_pov.must_equal 'triangle { <1,0,0>, <0,1,0>, <0,0,1> }'
    end
  end

  describe Stl2gif::Mesh do
    subject do
      Stl2gif::Mesh.new([
        [[1,0,0], [0,1,0], [0,0,1]],
        [[-1,0,0], [0,-1,0], [0,0,-1]]
      ])
    end

    it 'returns pov' do
      subject.to_pov.must_equal 'mesh { ' +
        'triangle { <1,0,0>, <0,1,0>, <0,0,1> }, ' +
        'triangle { <-1,0,0>, <0,-1,0>, <0,0,-1> } }'
    end
  end
end
