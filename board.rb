class Board
  attr_accessor :screen, :brick
  
  EMPTY = 0
  
  def initialize(rows, cols)
    @rows               = rows
    @cols               = cols
    @block_width        = 32
    @block_height       = 32
    @border             = 2
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
        background.draw_box( [x,y], [x+@block_width,y+@block_height], COLOR[@board[r][c]][:fill] )
        background.draw_box_s( [x+@border,y+@border], [x+@block_width-@border,y+@block_height-@border], COLOR[@board[r][c]][:border] )
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
            background.draw_box( [x,y], [x+@block_width,y+@block_height], @brick.color[:border] )
            background.draw_box_s( [x+@border,y+@border], [x+@block_width-@border,y+@block_height-@border], @brick.color[:fill] )
          end
        end
      end
    end
  end
  
  # :left, :right, :down
  def move_possible?(direction)
    # check against borders
    possible      = false
    left_offset   = @brick.size-1
    right_offset  = 0
    down_offset   = 0    
    
    for i in 0 .. @brick.size-1
      for j in 0 .. @brick.size-1
        left_offset   = j if @brick.shape[@brick.rotation][i][j] != EMPTY and j < left_offset
        right_offset  = j if @brick.shape[@brick.rotation][i][j] != EMPTY and j > right_offset
        down_offset   = i if @brick.shape[@brick.rotation][i][j] != EMPTY and i > down_offset
      end
    end
    
    possible = case direction
    when :left 
      true if @brick.pos[0]+left_offset > 0
    when :right 
      true if @brick.pos[0]+right_offset < @cols-1
    when :down 
      true if @brick.pos[1]+down_offset < @rows-1
    end
    
    # check against board if boards were ok
    if possible 
      c,r = @brick.pos
      c = c-1 if direction == :left
      c = c+1 if direction == :right
      r = r+1 if direction == :down
      
      for i in 0 .. @brick.size-1
        for j in 0 .. @brick.size-1
          if @brick.shape[@brick.rotation][i][j] != EMPTY
            possible = false if @board[r+i][c+j] != EMPTY
          end
        end
      end
    end
    
    possible
  end
  
  def rotate_possible?
    # check against borders
    possible      = false
    left_offset   = @brick.size-1
    right_offset  = 0
    down_offset   = 0
    for i in 0 .. @brick.size-1
      for j in 0 .. @brick.size-1
        left_offset   = j if @brick.shape[@brick.next_rotation][i][j] != EMPTY and j < left_offset
        right_offset  = j if @brick.shape[@brick.next_rotation][i][j] != EMPTY and j > right_offset
        down_offset   = i if @brick.shape[@brick.next_rotation][i][j] != EMPTY and i > down_offset
      end
    end
    possible = true if @brick.pos[0]+left_offset >= 0 and @brick.pos[0]+right_offset <= @cols-1 && @brick.pos[1]+down_offset <= @rows-1
    
    # check against board
    c,r = @brick.pos
    for i in 0 .. @brick.size-1
      for j in 0 .. @brick.size-1
        if r+i < @rows and r+i >= 0 and c+j < @cols and c+j >= 0
          possible = false if @board[r+i][c+j] != EMPTY
        end
      end
    end
    possible
  end
  
  def add_brick(brick)
    @brick = brick 
    @brick.pos = [@brick.start_pos_x + @brick_start_pos, @brick.start_pos_y]
  end
  
  def attach_brick
    c,r = @brick.pos
    for i in 0 .. @brick.size-1
      for j in 0 .. @brick.size-1
        if r+i < @rows and r+i >= 0 and c+j < @cols and c+j >= 0
          if @brick.shape[@brick.rotation][i][j] != EMPTY
            @board[r+i][c+j] = @brick.shape[@brick.rotation][i][j]
          end
        end
      end
    end
  end
  
  def remove_full_rows
    for i in 0 .. @board.size-1
      full_row = true
      for j in 0 .. @board[i].size-1
        full_row = false if @board[i][j] == EMPTY
      end
      
      # If a row was full, delete it and insert a new at the top
      if full_row
        @board.delete_at(i)
        @board.insert(0,Array.new(@cols) {0})
      end
    end
  end

end