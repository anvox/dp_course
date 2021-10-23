def score(x, y, energy, scores)
  energy + [
    (x - 1 > 0 ? scores[y - 1][x - 1] : nil),
    scores[y - 1][x],
    scores[y - 1][x + 1] # nil if overloaded
  ].compact.min
end

def compute_vertical_seam(energies)
  scores = []
  scores[0] = energies[0].dup
  (1..(energies.size - 1)).each do |y|
    scores[y] = []
    (0..(scores[0].size - 1)).each do |x|
      scores[y][x] = score(x, y, energies[y][x], scores)
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
