class Brick
  attr_accessor :shape, :start_pos, :pos, :size
  
  def initialize
    shapes        = [square, line, l, inverted_l, n, inverted_n, t]
    start_pos     = [square_start, line_start, l_start, inverted_l_start, n_start, inverted_n_start, t_start]
    shape_to_use  = rand(shapes.size)
    
    @shape        = shapes[shape_to_use]
    @start_pos    = start_pos[shape_to_use]
    @pos          = @start_pos
    @direction    = 0
    @size         = 5 # width and height of brick
    @instructions = {
      :left   => -1,
      :right  => 1
      }
  end
  
  def draw(background)
    #background.draw_box( [c,r], [c+@block_width,r+@block_height], @empty_block )
  end
    
  def start_pos_x
    start_pos[0]
  end
  
  def start_pos_y
    start_pos[1]
  end
  
  def rotate(instruction)
    @direction = @direction + @instuctions[instruction].to_i
  end
  
  def get_shape
    @shape
  end
  
  def square
    [
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,2,1,0],
        [0,0,1,1,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,1,2,0,0],
        [0,1,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,1,1,0,0],
        [0,1,2,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,1,1,0],
        [0,0,2,1,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
    ]
  end
  
  def line
    [
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,1,2,1,1],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,2,0,0],
        [0,0,1,0,0],
        [0,0,1,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [1,1,2,1,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,1,0,0],
        [0,0,1,0,0],
        [0,0,2,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
    ]
  end
  
  def l
    [
      [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,2,0,0],
        [0,0,1,1,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,1,2,1,0],
        [0,1,0,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,1,1,0,0],
        [0,0,2,0,0],
        [0,0,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,0,1,0],
        [0,1,2,1,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
    ]
  end
  
  def inverted_l
    [
      [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,2,0,0],
        [0,1,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,1,0,0,0],
        [0,1,2,1,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,1,1,0],
        [0,0,2,0,0],
        [0,0,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,1,2,1,0],
        [0,0,0,1,0],
        [0,0,0,0,0],
      ],
    ]
  end

  def n
    [
      [
        [0,0,0,0,0],
        [0,0,0,1,0],
        [0,0,2,1,0],
        [0,0,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,1,2,0,0],
        [0,0,1,1,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,1,2,0,0],
        [0,1,0,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,1,1,0,0],
        [0,0,2,1,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
    ]
  end
  
  def inverted_n
    [
      [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,2,1,0],
        [0,0,0,1,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,0,2,1,0],
        [0,1,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,1,0,0,0],
        [0,1,2,0,0],
        [0,0,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,1,1,0],
        [0,1,2,0,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
    ]
  end
  
  def t
    [
      [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,0,2,1,0],
        [0,0,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [0,1,2,1,0],
        [0,0,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,1,2,0,0],
        [0,0,1,0,0],
        [0,0,0,0,0],
      ],
      [
        [0,0,0,0,0],
        [0,0,1,0,0],
        [0,1,2,1,0],
        [0,0,0,0,0],
        [0,0,0,0,0],
      ],
    ]
  end
  
  def square_start
    [-2,-2]
  end
  
  def line_start
    [-1,-2]
  end
  
  def l_start
    [-2,-1]
  end
  
  def inverted_l_start
    [-1,-1]
  end
  
  def n_start
    [-2,-1]
  end
  
  def inverted_n_start
    [-2,-1]
  end
  
  def t_start
    [-2,-1]
  end
  
end