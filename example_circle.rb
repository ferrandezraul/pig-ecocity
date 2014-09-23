Shoes.app do
  # oval is part of shoes API ?
  @o = oval :top => 0, :left => 0, :radius => 40

  stack :margin => 40 do
    title "Dancing With a Circle"
    subtitle "How graceful and round."
  end

  motion do |x, y|
    # width returns the width of your window
    # height returns the height of your window
    @o.move width - x, height - y
  end

end