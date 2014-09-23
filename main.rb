#Shoes.app {
#  button("Push me") {
#    alert("My buttom pushed")
#  }
#}




Shoes.app( :width => 280, :height => 350 ) do
  flow( :width => 280, :margin => 10 ) do

    stack :width => "100%" do
      banner "A POEM"
    end

    stack :width => "80px" do
      # para stands for paragraph
      para "Goes like:"
    end

    stack :width => "-90px" do
      # para stands for paragraph, and it concatenates strings
      para "the sun.\n",
           "the goalie.\n"
           "a fireplace.\n\n"
      para strong("This is a strong text\n"),
           em("This is a em text\n")
           title("This is a title text\n")
           subtitle("This is a title text\n")
           tagline("This is a title text\n")
           caption("This is a title text\n")
           inscription("This is a inscription text\n")
    end

  end
end