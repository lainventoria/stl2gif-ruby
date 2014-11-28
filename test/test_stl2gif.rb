require 'minitest_helper'

class TestStl2gif < MiniTest::Spec
  def test_that_it_has_a_version_number
    refute_nil ::Stl2gif::VERSION
  end

  def test_point_returns_pov
    Stl2gif::Point.new([0,1,2]).to_pov.must_equal '<0,1,2>'
  end

  def test_triagle_returns_pov
    Stl2gif::Triangle.new([[1,0,0],[0,1,0],[0,0,1]]).to_pov.must_equal 'triangle { <1,0,0>, <0,1,0>, <0,0,1> }'
  end

  def test_mesh
    Stl2gif::Mesh.new([[[1,0,0],[0,1,0],[0,0,1]],[[-1,0,0],[0,-1,0],[0,0,-1]]])
  end

  def pov_test_mesh
    'mesh { triangle { <1,0,0>, <0,1,0>, <0,0,1> }, triangle { <-1,0,0>, <0,-1,0>, <0,0,-1> } }'
  end

  def test_triangles_becomes_pov
    test_mesh.to_pov.must_equal pov_test_mesh
  end

  def test_stl
    Stl2gif::Stl.new(File.expand_path('../fixtures/test.stl',__FILE__))
  end

  def test_frame_generation
    s = test_stl 
    s.render_frame 0
    s.render_frame 0.35 * Math::PI
    s.frames.size.must_equal 2
    s.clear_temp_files
    s.frames.size.must_equal 0
  end

  def test_frames_become_gif
    s = test_stl
    s.render_frame 0
    s.render_frame 0.25 * Math::PI
    s.render_frame 0.5 * Math::PI
    s.to_gif('test.gif')
    s.clear_temp_files
    File.exists?('test.gif').must_be true
  end
end
