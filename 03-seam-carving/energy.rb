class Energy
  def initialize(pixels)
    @pixels = pixels
  end

  def to_colors
    energies.map do |row|
      row.map do |cell|
        color = ((cell.to_f / max_energy)*255).round
        Color.new(color, color, color)
      end
    end
  end

  def max_energy
    @max_energy ||= compute_max_energy
  end

  def energies
    @energies ||= compute_energy
  end

  private

  attr_reader :pixels

  def compute_energy
    pixels.size.times.map do |x|
      pixels[0].size.times.map do |y|
        energy_at(x, y)
      end
    end
  end

  def compute_max_energy
    current_max_energy = 0
    energies.each do |row|
      row.each do |cell|
        current_max_energy = cell if cell > current_max_energy
      end
    end
    current_max_energy
  end

  def energy_at(x, y)
    left = x >= 0 ? pixels[x-1][y] : pixels[x][y]
    right = x < pixels.size - 1 ? pixels[x+1][y] : pixels[x][y]
    top = y >= 0 ? pixels[x][y-1] : pixels[x][y]
    bottom = y < pixels[0].size - 1 ? pixels[x][y+1] : pixels[x][y]

    left.diff(right) + top.diff(bottom)
  end
end
