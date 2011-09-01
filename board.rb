class Board
  attr_accessor :screen, :brick
  
  EMPTY = 0
  
  def initialize(rows, cols)
    @rows               = rows
    @cols               = cols
    @block_width        = 32
    @block_height       = 32
    @border             = 2
    @empty_block        = [50,50,50]
    @empty_block_border = [100,100,100]
    @full_block         = [200,200,200]
    @full_block_border  = [255,255,255]
    @brick_start_pos    = 4
    @brick              = nil
    setup_board
  end
  
  def setup_board
    @board  = Array.new(@rows) { Array.new(@cols) {0} }
    @screen = Surface.new([@rows*@block_width,@cols*@block_height])
  end
  
  def draw(background)
    r = 0
    @board.each do |row|
      c = 0
      row.each do |col|
        x = c * @block_width
        y = r * @block_height
        #color = @board[x][y] == EMPTY ? @empty_block : @full_block
        color = @empty_block
        background.draw_box( [x,y], [x+@block_width,y+@block_height], @empty_block_border )
        background.draw_box_s( [x+@border,y+@border], [x+@block_width-@border,y+@block_height-@border], @empty_block )
        c = c + 1
      end
      r = r + 1
    end
    draw_brick(background)
  end
  
  def draw_brick(background)
    c = @brick_start_pos
    c,r = @brick.pos
    for i in 0 .. @brick.size-1
      for j in 0 .. @brick.size-1
        if r+i < @rows  and r+i >= 0 and c+j < @cols and c+j >= 0
          y = (r+i)*@block_width
          x = (c+j)*@block_height
          if @brick.shape[@brick.rotation][i][j] != EMPTY            
            background.draw_box( [x,y], [x+@block_width,y+@block_height], @full_block_border )
            background.draw_box_s( [x+@border,y+@border], [x+@block_width-@border,y+@block_height-@border], @full_block )
          end
        end
      end
    end
  end
  
  # :left, :right, :down
  def move_possible?(direction)
    possible = false
    case direction
    when :left
      possible = true if @brick.pos[0]-1 >= 0
    when :right
      possible = true if @brick.pos[0]+5+1 <= @cols
    when :down
      possible = true if @brick.pos[1]+5+1 <= @rows
    end
    possible
  end
  
  def add_brick(brick)
    @brick = brick 
    @brick.pos = [@brick.start_pos_x + @brick_start_pos, @brick.start_pos_y]
  end
end