class ImageAnalyzer

  def initialize file_path
    @file_path = file_path
  end

  def share_for_color color
    # file_path = Rails.root.join("uploads/photo/file/5/224119_2032167770086_6379349_n.jpg")
    # image = MiniMagick::Image.open(@file_path)

    image = Magick::ImageList.new(@file_path)
    q = image.quantize(16, Magick::RGBColorspace)
    palette = q.color_histogram.sort {|a, b| b[1] <=> a[1]}
    total_depth = image.columns * image.rows
    results = []

    palette.count.times do |i|
      p = palette[i]

      # debugger

      r1 = p[0].red / 256
      g1 = p[0].green / 256
      b1 = p[0].blue / 256

      # rgb = "#{r1},#{g1},#{b1}"
      rgb = {red: r1, green: g1, blue: b1}
      depth = p[1]

      results << {
        rgb: rgb,
        percent: ((depth.to_f / total_depth.to_f) * 100).round(2)
      }
    end

    share_of_color = 0.0

    results.each do |row|
      # debugger
      share_of_color += row[:percent] if compare_color row[:rgb], color
    end

    return share_of_color
  end

  private

    def compare_color palette_row, color
      case color
      when 'red'
        return  palette_row[:red]   > 150 &&
                palette_row[:green] < 100 &&
                palette_row[:blue]  < 100
      when 'green'
        return  palette_row[:red]   < 100 &&
                palette_row[:green] > 150 &&
                palette_row[:blue]  < 100
      when 'blue'
        return  palette_row[:red]   < 100 &&
                palette_row[:green] < 100 &&
                palette_row[:blue]  > 150
      else
        raise NotImplementedError
      end
    end
end
