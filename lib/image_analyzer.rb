class ImageAnalyzer

  def initialize file
    @file = file
  end

  def count_pxls_for_color color = nil
    file_path = Rails.root.join("uploads/photo/file/5/224119_2032167770086_6379349_n.jpg")
    image = MiniMagick::Image.open(file_path)
  end
end

# manipulate! do |img|
#   overlay_path = Rails.root.join("app/assets/images/gradient.png")
#   gradient = MiniMagick::Image.open(overlay_path)

#   img = img.composite(gradient) do |c|
#     c.blur 3
#   end

#   img
# end
