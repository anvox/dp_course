if ENV['DEBUG'] == '1'
  require 'pry-byebug'
end
require_relative './utils'
require_relative './seam_calculator'
require_relative './seam_cropper'

filename = ARGV[0]
pixels = read_image_into_array("#{filename}.jpg")
direction = (ARGV[1] || 'vertical').to_sym

cropper = SeamCropper.new(pixels)
20.times do |i|
  seam_calculator = SeamCalculator.new(pixels)
  if ENV['DEBUG'] == '1'
    write_array_into_image(seam_calculator.energy_map, "#{filename}-energy-#{i}.jpg")
  end

  seam = seam_calculator.execute(direction)
  if ENV['DEBUG'] == '1'
    write_array_into_image(cropper.highlight(seam, direction), "#{filename}-highlighted-#{i}.jpg")
  end

  pixels = cropper.crop!(seam, direction)
end
write_array_into_image(pixels, "#{filename}-cropped.jpg")
