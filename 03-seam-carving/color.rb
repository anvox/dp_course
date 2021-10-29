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
