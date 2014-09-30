Shoes.app :width => 200, :height => 140 do
  @times = 0

  stack do
    para "Hola qye tal \n"
    button "Press me" do
      @times += 1
      @p.clear { para "You pressed me #{@times} ti mes" }
    end

    @p = flow
  end
end