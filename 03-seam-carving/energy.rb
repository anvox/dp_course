def energy_at(pixels, x, y)
  left = x >= 0 ? pixels[x-1][y] : pixels[x][y]
  right = x < pixels.size - 1 ? pixels[x+1][y] : pixels[x][y]
  top = y >= 0 ? pixels[x][y-1] : pixels[x][y]
  bottom = y < pixels[0].size - 1 ? pixels[x][y+1] : pixels[x][y]

  left.diff(right) + top.diff(bottom)
end

def compute_energy(pixels)
  max_energy = 0
  energies = pixels.size.times.map do |x|
    pixels[0].size.times.map do |y|
      energy_at(pixels, x, y).tap do |energy|
        max_energy = energy if energy > max_energy
      end
    end
  end
  [energies, max_energy]
end

def energy_to_colors(energies, max_energy)
  energies.map do |row|
    row.map do |cell|
      color = ((cell.to_f / max_energy)*255).round
      Color.new(color, color, color)
    end
  end
end
