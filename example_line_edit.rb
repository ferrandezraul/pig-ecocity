Shoes.app do
  @e = edit_line :width => 400
  button "O.K." do
    alert @e.text
  end

  stack do
    # Example of a link (It even opens the browser)
    para link("GOOGLE", :click => "http://google.com")
  end

end