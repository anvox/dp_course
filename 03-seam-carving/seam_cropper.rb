class SeamCropper
  RED_MASK = Color.new(255, 0, 0)

  def initialize(pixels)
    @pixels = pixels
  end

  def highlight(seam, direction = :vertical)
    result = clone_frame(pixels)

    seam.each_with_index do |x, y|
      result[y][x] = RED_MASK
    end

    result
  end

  def crop!(seam, direction = :vertical)
    pixels.each_with_index.map do |row, y|
      row.delete_at(seam[y])
      row
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
