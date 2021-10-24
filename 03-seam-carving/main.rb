require_relative './utils'
require_relative './energy'
require_relative './vertical_seam'

filename = ARGV[0]
direction = ARGV[1] || 'vertical'

pixels = read_image_into_array("#{filename}.jpg")

image_energy = Energy.new(pixels)
vertical_seam = compute_vertical_seam(image_energy.energies)

write_array_into_image(image_energy.to_colors, "#{filename}-energy.jpg")

highlight_pixels = highlight_vertical_seam(pixels, vertical_seam)
write_array_into_image(highlight_pixels, "#{filename}-highlighted.jpg")

stripped_pixels = remove_vertical_seam(pixels, vertical_seam)
write_array_into_image(stripped_pixels, "#{filename}-stripped.jpg")
