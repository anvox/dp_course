require_relative './utils'
require_relative './energy'

pixels = read_image_into_array("surfer.jpg")
energy_colors = energy_to_colors(pixels)
write_array_into_image(energy_colors, "surfer-energy.jpg")
