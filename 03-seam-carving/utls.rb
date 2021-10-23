class Color
  def initialize(r, g, b)
    @r, @g, @b = r, g, b
  end

  def to_s
    "Color(#{@r},#{@g},#{@b})"
  end
end

def read_image_into_array(filename)
end

def write_array_into_image(pixels, filename)
end
