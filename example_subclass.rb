class BookList < Shoes
  # Url method comes from Shoes
  url '/', :index        # draws page from the index method   (you can organise your methods in different classes)
  url '/twain', :twain   # draws page from the twain method
  url '/kv', :vonnegut   # draws page from the vonnegut method

  def index
    para "Books I've read: ",
         link("by Mark Twain\n", :click => "/twain"),
         link("by Kurt Vonnegut", :click => "/kv")
  end

  def twain
    para "Just Huck Finn.\n",
         link("Go back.", :click => "/")
  end

  def vonnegut
    para "Cat's Cradle. Sirens of Titan.\n ",
         "Breakfast of Champions.\n",
         link("Go back.", :click => "/")
  end

end

# Need this. That's what opens the window
Shoes.app :width => 400, :height => 500