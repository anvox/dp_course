require_relative './utils'
require_relative './energy'
require_relative './vertical_seam'

filename = ARGV[0]
direction = ARGV[1] || 'vertical'

pixels = read_image_into_array("#{filename}.jpg")
energies, max_energy = compute_energy(pixels)
vertical_seam = compute_vertical_seam(energies)

energy_colors = energy_to_colors(energies, max_energy)
write_array_into_image(energy_colors, "#{filename}-energy.jpg")

highlight_pixels = highlight_vertical_seam(pixels, vertical_seam)
write_array_into_image(highlight_pixels, "#{filename}-highlighted.jpg")

stripped_pixels = remove_vertical_seam(pixels, vertical_seam)
write_array_into_image(stripped_pixels, "#{filename}-stripped.jpg")
