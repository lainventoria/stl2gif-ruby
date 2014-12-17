require 'stl'
require 'mustache'
require 'RMagick'
require 'stl2gif/version'
require 'stl2gif/point'
require 'stl2gif/triangle'
require 'stl2gif/mesh'

module Stl2gif
  class Stl
    attr_reader :file, :options, :mesh
    attr_writer :mesh

    # SEC-WARN: no option input can be user provided
    def initialize(file, options = {})
      @file = file
      @mesh = load_mesh

      @options = {}
      @options[:frames_dir] = options[:frames_dir] || '/tmp/stl2gif_images'
      @options[:template] = options[:template] || File.expand_path('../stl2gif/template.pov', __FILE__)
      @options[:width] = options[:width] || '300'
      @options[:height] = options[:height] || '300'
      @options[:pov_path] = options[:pov_path] || '/tmp/scene.pov'
    end

    def to_pov
      mesh.to_pov
    end

    def load_mesh
      Mesh.new(load_stl)
    end

    def load_stl
      # f[0] is the normal and not needed, f[1] is the triangle
      STL.read(file).map {|f| f[1]}
    end

    # rotation: angle in radians (pi radians is half a turn)
    def render_frame(rotation)
      Dir.mkdir(options[:frames_dir]) unless File.directory?(options[:frames_dir])
      pov = Mustache.render(template, :modelData => to_pov, :phi => rotation)
      File.write(options[:pov_path], pov)
      system("povray -i#{options[:pov_path]} +FN +W#{options[:width]} "+
        "+H#{options[:height]} -o#{options[:frames_dir]}/#{frame_number}.png +Q9 +AM1 +A +UA")
    end

    def template
      File.read(options[:template])
    end

    def frames
      Dir["#{options[:frames_dir]}/*.png"]
    end

    def frame_number
      frames.size.to_s.rjust(2, '0')
    end

    def generate_frames
      for i in 0..options[:step]*2
        render_frame Math::PI * i / options[:step]
      end
    end

    def to_gif(gif_file)
      animation = Magick::ImageList.new(frames.sort)
      animation.delay = 16
      animation.write(gif_file)
    end

    def clear_temp_files
      FileUtils.rm_rf Dir.glob("#{options[:frames_dir]}/*")
      FileUtils.rm options[:pov_path]
    end
  end
end
