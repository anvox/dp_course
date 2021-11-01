class SeamCropper
  RED_MASK = Color.new(255, 0, 0)

  def initialize(pixels)
    @pixels = pixels
  end

  def highlight(seam, direction = :vertical)
    result = clone_frame(pixels)

    if direction == :vertical
      seam.each_with_index do |x, y|
        result[y][x] = RED_MASK
      end
    else
      seam.each_with_index do |y, x|
        result[y][x] = RED_MASK
      end
    end

    result
  end

  def crop!(seam, direction = :vertical)
    if direction == :vertical
      pixels.each_with_index.map do |row, y|
        row.delete_at(seam[y])
        row
      end
    else
      height = pixels.size - 1
      seam.each_with_index do |y, x|
        iy = y + 1
        while iy < height
          pixels[iy - 1][x] = pixels[iy][x]
          iy += 1
        end
      end
      pixels.pop
      pixels
    end
  end

  private

  attr_reader :pixels

  def clone_frame(pixels)
    pixels.map do |row|
      row.map do |cell|
        cell.dup
      end
    end
  end
end
