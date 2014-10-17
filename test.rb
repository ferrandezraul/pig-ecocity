
Shoes.app do
  @list = ['Frances Johnson', 'Ignatius J. Reilly',
           'Winston Niles Rumfoord']
  stack do
    @list.map! do |name|
      flow { @c = check; para name }
      [@c, name]
    end

    debug( "the gui_selected ...")
    debug(@list)

    button "What's been checked?" do
      selected = @list.map { |c, name| name if c.checked? }.compact
      alert("You selected: " + selected.join(', '))
    end
  end
end
