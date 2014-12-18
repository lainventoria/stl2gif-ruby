require 'minitest_helper'

describe Stl2gif do
  it 'has a version number' do
    Stl2gif::VERSION.wont_be_nil
  end

  describe Stl2gif::Stl do
    subject { Stl2gif::Stl.new(File.expand_path('../fixtures/test.stl',__FILE__)) }

    before do
      subject.render_frame 0
      subject.render_frame 0.35 * Math::PI
      subject.render_frame 0.5 * Math::PI
    end

    after do
      subject.clear_temp_files
    end

    it 'generates frames' do
      subject.frames.size.must_equal 3
    end

    it 'clears frames' do
      subject.clear_temp_files

      subject.frames.size.must_equal 0
    end

    it 'converts to gif' do
      subject.to_gif 'test.gif'

      File.exists?('test.gif').must_equal true
    end
  end
end
