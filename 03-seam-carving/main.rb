require_relative './utils'
require_relative './energy'
require_relative './seam'

filename = "arch"

pixels = read_image_into_array("#{filename}.jpg")
energies, max_energy = compute_energy(pixels)
energy_colors = energy_to_colors(energies, max_energy)
write_array_into_image(energy_colors, "#{filename}-energy.jpg")

vertical_seam = compute_vertical_seam(energies)
# pixels = remove_seam(pixels, vertical_seam)
pixels = highlight_seam(pixels, vertical_seam)
write_array_into_image(pixels, "#{filename}-stripped.jpg")
