require 'stl'
require 'pry'
require 'mustache'
require 'fileutils'
require 'RMagick'
include Magick

@dir_path = '/tmp/stl2gif_images'
@pov_path = '/tmp/scene.pov'
@step = 8

class Geometry::Point
  def to_s
    self[0].to_s + ',' + self[1].to_s + ',' + self[2].to_s
  end
end

class Geometry::ScaleneTriangle
  def to_s
    "  triangle {\n    <#{points[0].to_s}>,\n    <#{points[1].to_s}>,\n    <#{points[2].to_s}>}\n"
  end
end

def stl2pov(faces)
  pov = "mesh {\n"
  faces.each do |poly|
    pov = pov + poly[1].to_s
  end
  pov = pov + "}"
end

def render(template, name, data, i)
  width = 300
  height = 300

  s=i
  s = '0'+i.to_s if (i<10)
  phi = Math::PI * i / @step

  pov = Mustache.render(template, :modelName => name, :modelData => data, :phi => phi)
  File.write(@pov_path,pov)
  system("povray -i#{@pov_path} +FN +W#{width} +H#{height} -o#{@dir_path}/#{s}.png +Q9 +AM1 +A +UA")
end

def stl2gif(stl_file, gif_file)
  faces = STL.read(stl_file)
  pov = stl2pov(faces)

  template = File.read('template.pov')

  Dir.mkdir(@dir_path) unless File.directory?(@dir_path)

  # para cada posicion rendereo la imagen
  for i in 0..@step*2
    render template, '__Default__', "#declare __Default__ = #{pov}", i
  end

  animation = ImageList.new(*Dir[@dir_path + "/*.png"].sort)

  animation.delay = 16
  animation.write(gif_file)

  FileUtils.rm_rf Dir.glob("#{@dir_path}/*")
  FileUtils.rm @pov_path
end


stl2gif('test.stl','anim.gif')
