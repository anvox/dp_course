require_relative './energy'
require_relative './color'

class SeamCalculator
  def initialize(pixels)
    @pixels = pixels
    @scores = []
    @height = pixels.size
    @width = pixels[0].size
  end

  def execute(direction)
    if direction == :vertical
      compute_vertical_seam
    elsif direction == :horizontal
      compute_horizontal_seam
    else
      raise "Unsupported direction!"
    end
  end

  def energy_map
    energies.map do |row|
      row.map do |cell|
        color = ((cell.to_f / max_energy)*255).round
        Color.new(color, color, color)
      end
    end
  end

  private

  attr_reader :pixels, :scores, :height, :width

  def energies
    @energies ||= energy_calculator.energies
  end

  def max_energy
    @max_energy ||= energy_calculator.max_energy
  end

  def energy_calculator
    @energy_calculator ||= Energy.new(pixels)
  end

  def compute_vertical_seam
    scores[0] = energies[0].dup
    (1..(energies.size - 1)).each do |y|
      scores[y] = []
      (0..(scores[0].size - 1)).each do |x|
        scores[y][x] = score(x, y, energies[y][x])
      end
    end

    min_score_index = 0
    i = 0
    while i < scores[-1].size
      if scores[-1][i] < scores[-1][min_score_index]
        min_score_index = i
      end
      i += 1
    end

    min_score_path = [min_score_index]
    i = scores.size - 2
    j = min_score_index
    while i >= 0
      pre = j
      if j > 0 && scores[i][j - 1] < scores[i][pre]
        pre = j - 1
      end
      if j < scores[0].size - 1 && scores[i][j + 1] < scores[i][pre]
        pre = j + 1
      end

      j = pre
      min_score_path << pre

      i -= 1
    end

    min_score_path.reverse
  end

  def compute_horizontal_seam
    energies.each_with_index do |row, y|
      scores[y] = [row[0]]
    end
    x = 1
    while x < width
      y = 0
      while y < height
        scores[y][x] = horizontal_score(x, y, energies[y][x])
        y += 1
      end

      x += 1
    end

    min_score_index = 0
    y = 0
    while y < height
      if scores[y][-1] < scores[min_score_index][-1]
        min_score_index = y
      end
      y += 1
    end

    min_score_path = [min_score_index]
    x = width - 2
    y = min_score_index
    while x >= 0
      pre = y
      if y > 0 && scores[y - 1][x] < scores[pre][x]
        pre = y - 1
      end
      if y < scores.size - 1 && scores[y + 1][x] < scores[pre][x]
        pre = y + 1
      end

      y = pre
      min_score_path << pre

      x -= 1
    end

    min_score_path.reverse
  end

  def score(x, y, energy)
    energy + [
      (x - 1 > 0 ? scores[y - 1][x - 1] : nil),
      scores[y - 1][x],
      scores[y - 1][x + 1] # nil if overloaded
    ].compact.min
  end

  def horizontal_score(x, y, energy)
    energy + [
      (y >= 1 ? scores[y - 1][x - 1] : nil),
      scores[y][x - 1],
      scores[y + 1] && scores[y + 1][x - 1]
    ].compact.min
  end
end
