# Extracted from here http://hackety.com/users/kwicher/programs/table
# Removed logic to be editable/selectable/hide/show

class Table < Shoes::Widget

  #Sets up the table
  #top, left - position of the top and left corner of the table
  #height - number of rows to show without the vertical scrolling bar
  #headers - array of arrays containing headers and widths of the collumns)
  #          in the form of ["title", width]
  #items - array of arrays containing data to be displayed
  #blk - optional Proc object with a block to be called when the row is clicked
  def initialize opts = {}

    @height=opts[:rows]
    @items=opts[:items]
    @headers=opts[:headers]
    @columns=@headers.size
    mult = @items.size > @height ? 1:0
    nostroke
    @width=2
    @item=[]
    @headers.each { |x| @width+=(x[1]+1)  }
    nostroke
    fill green
    @top=opts[:top]
    @left=opts[:left]
    @rec=rect :top => 0, :left => 0, :width=>@width+mult*12+2, :height=>31*(@height+1)+4
    @lefty=0

    @header=flow do
      @headers.each_with_index do |h,l|
        temp=(l==@headers.size-1 ? h[1]+12*mult : h[1])
        flow :top=>2,:left=>@lefty+2,:width=>temp,:height=>29 do
          rect(:top=>0,:left=>1,:width=>temp,:height=>29, :fill=>lightgrey)
          p=para strong(h[0]), :top=>2,  :align=>'center'
          @lefty+=h[1]+1
        end
      end
    end
    @flot1=stack :width=>@width+mult*12+2, :height=>31*(@height), :scroll=>true, :top=>33, :left=>1 do
      @items.each_with_index do |it, i|
        inscription " "
        @item[i]=stack :width=>@width-1, :top=>31*i, :left=>1 do
          @lefty=0
          rr=[]
          @columns.times do |ei|
            rr[ei]=rect(:top=>1, :left=>@lefty+1, :width=>@headers[ei][1]-1,:height=>29, :fill=>white)
            it[ei]=" " if not it[ei] or it[ei]==""
            inscription strong(it[ei]), :top=>31*i+3, :left=>@lefty+2, :width=>@headers[ei][1]-1, :align=>'center'
            @lefty+=@headers[ei][1]+1

          end
        end
      end
    end
  end

end