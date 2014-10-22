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
  def initialize( shoes_stack )
    @stack = shoes_stack
    @date = "#{Date.today.to_s}"

    draw
  end

  private

  def draw
    @stack.app do
      para "Data:", :margin => 4

      if @date.nil?
        debug("date is nil")
      end
      debug(@date)

      edit_line @date, :margin => 4 do |line|
        @date = line.text
      end
    end
  end

end