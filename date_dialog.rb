$:.unshift File.join( File.dirname( __FILE__ ), "lib" )

class DateDialog
  attr_reader :date

  # Dialog for user to enter a date as a string
  # Returns a string with given date:
  # == Example
  #
  # dialog = DateDialog.new( Shoes.app )
  # ...
  # date_string = dialog.date
  #
  def initialize( app )
    @app = app
    @date = "#{Date.today.to_s}"

    draw
  end

  private

  def draw
    @app.border @app.black

    @app.para "Data:", :margin => 4

    @app.edit_line @date, :margin => 4 do |line|
      @date = line.text
    end
  end

end