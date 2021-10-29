require 'mini_magick'
require_relative './color'

def read_image_into_array(filename)
  image = MiniMagick::Image.open(filename)
  pixels = image.get_pixels
  pixels.map do |row|
    row.map do |cell|
      Color.new(*cell)
    end
  end
end

def write_array_into_image(pixels, filename)
  colors = []
  pixels.each do |row|
    row.each do |cell|
      colors.concat(cell.to_a)
    end
  end
  image = MiniMagick::Image.import_pixels(colors.pack('C*'),
                                          pixels[0].size,
                                          pixels.size,
                                          8, "rgb", "jpg")
  image.write(filename)
end

def clone_frame(pixels)
  pixels.map do |row|
    row.map do |cell|
      cell.dup
    end
  end
end
