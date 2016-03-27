class ImageAnalyzer

  def initialize file_path
    @file_path = file_path
  end

  def share_for_color color
    # file_path = Rails.root.join("uploads/photo/file/5/224119_2032167770086_6379349_n.jpg")
    # image = MiniMagick::Image.open(@file_path)

    @results ||= get_color_histogram

    share_of_color = 0.0

    @results.each do |row|
      # share_of_color += row[:percent] if compare_color_by_rgb row[:rgb], color
      share_of_color += row[:percent] if compare_color_by_hsla row[:hsla], color
    end

    return share_of_color
  end

  private

    # определяем является ли цвет нужным
    def compare_color_by_rgb palette_row, color
      red   = palette_row[:red]
      green = palette_row[:green]
      blue  = palette_row[:blue]

      small_diff = 10
      big_diff = 100

      case color
      when 'red'
        diff_1 = red - green
        diff_2 = red - blue
      when 'green'
        diff_1 = green - red
        diff_2 = green - blue
      when 'blue'
        diff_1 = blue - red
        diff_2 = blue - green
      else
        raise NotImplementedError
      end

      return  diff_1 > small_diff &&
              diff_2 > small_diff &&
              diff_1 + diff_2 > big_diff
    end

    def compare_color_by_hsla palette_row, color
      hue        = palette_row[0]
      saturation = palette_row[1]
      lightness  = palette_row[2]

      min_s = 127 #50%
      min_l = 63 #25%
      max_l = 178 #70%

      color_range = false

      case color
      when 'red'
        color_range = hue.between?(342, 359) || hue.between?(0, 16)
      when 'green'
        color_range = hue.between?(74, 154)
      when 'blue'
        color_range = hue.between?(188, 260)
      else
        raise NotImplementedError
      end

      # debugger
      # if color_range
      #   p palette_row
      # end

      return  color_range &&
              saturation > min_s &&
              lightness.between?(min_l, max_l)
    end

    def get_color_histogram
      image = Magick::ImageList.new(@file_path)
      q = image.quantize(32, Magick::RGBColorspace)
      # q.write("q-image-#{@file_path[-10..-1]}.jpg")
      palette = q.color_histogram
      total_depth = image.columns * image.rows
      results = []

      palette.each do |palette_color|
        red   = palette_color[0].red / 256
        green = palette_color[0].green / 256
        blue  = palette_color[0].blue / 256

        rgb = {red: red, green: green, blue: blue}
        hsla = palette_color[0].to_hsla
        depth = palette_color[1]

        results << {
          rgb: rgb,
          hsla: hsla,
          percent: ((depth.to_f / total_depth.to_f) * 100).round(2)
        }
      end
      return results
    end
end
