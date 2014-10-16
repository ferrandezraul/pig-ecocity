
Shoes.app :margin => 5 do
  border yellow
  flow :width => 1000, :margin => 5 do
    border blue
    stack :width => 230 do
      button "Eliminar", :margin => 10 do
      end
      edit_line "hola", :margin => 10 do
      end
    end
    stack :width => -230 do
      para "Hola", :margin => 14, :width => -230
    end
  end
end
