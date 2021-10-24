require_relative './utils'
require_relative './energy'
require_relative './vertical_seam'

filename = ARGV[0]
direction = ARGV[1] || 'vertical'

pixels = read_image_into_array("#{filename}.jpg")

image_energy = Energy.new(pixels)
seam_calculator = VerticalSeam.new(image_energy.energies)

write_array_into_image(image_energy.to_colors, "#{filename}-energy.jpg")
write_array_into_image(seam_calculator.highlight(pixels), "#{filename}-highlighted.jpg")

200.times do
  pixels = seam_calculator.remove!(pixels)
end

write_array_into_image(pixels, "#{filename}-stripped.jpg")
