# Stl2gif

Converts STL files to GIF animations

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stl2gif'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stl2gif

## Dependencies

* ImageMagick
* Povray

## Usage

    require 'stl2gif'

    s = Stl2gif.Stl.new('test/fixtures/test.stl')
    s.generate_frames
    # temp_gif is a tempfile
    temp_gif = s.to_gif('test')

## Contributing

1. Fork it ( https://github.com/lainventoria/stl2gif-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
