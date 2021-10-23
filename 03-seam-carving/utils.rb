require 'mini_magick'

class Color
  def initialize(r, g, b)
    @r, @g, @b = r, g, b
  end

  attr_reader :r, :g, :b

  def to_s
    "Color(#{@r},#{@g},#{@b})"
  end

  def diff(color)
    dr = color.r - r
    dg = color.g - g
    db = color.b - b

    dr*dr + dg*dg + db*db
  end

  def to_a
    [r, g, b]
  end
end

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

def highlight_seam(pixels, seam)
  seam.each_with_index do |x, y|
    pixels[y][x] = Color.new(255, 0, 0)
  end

  pixels
end
