class Game
  
  def initialize
    setup_screen
    setup_event_queue
    setup_clock
    @board          = Board.new(ROWS, COLS)
    @current_brick  = Brick.new()
    #@next_brick     = Brick.new
    @delay          = 1000
    @background.blit(@screen,[0,0])
    @screen.update()
  end
  
  def run
    ticks = 0
    loop do
      update
      draw
      ticks = ticks + @clock.tick.milliseconds
      if ticks > @delay
        @board.brick.move_down if @board.move_possible?(:down)
        ticks = 0
      end
      ticks = 0 if ticks > @delay
    end
  end
  
  def new_brick
    #@current_brick  = @next_brick
    #@next_brick     = Brick.new
  end
  
  def setup_screen
    @screen = Rubygame::Screen.open [ WIDTH, HEIGHT], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @screen.title = "terubyis"
    
    # Hide the mouse cursor
    @screen.show_cursor = true
    
    @background = Surface.new( @screen.size )
    @background.fill( Color::ColorRGB.new([0.3, 0.3, 0.33]) )
  end
  
  def setup_clock
    @clock = Rubygame::Clock.new
    @clock.target_framerate = 50
    
    # Adjust the assumed granularity to match the system.
    # This helps minimize CPU usage on systems with clocks
    # that are more accurate than the default granularity.
    @clock.calibrate
    
    # Make Clock#tick return a ClockTicked event.
    @clock.enable_tick_events
  end
  
  def setup_event_queue
    # Create a queue to receive events+
    #  + events such as "the mouse has moved", "a key has been pressed" and so on
    @event_queue = Rubygame::EventQueue.new
    @event_queue.ignore = [ActiveEvent,MouseMotionEvent,MouseUpEvent,MouseDownEvent]
    
    # Use new style events so that this software will work with Rubygame 3.0
    #@event_queue.enable_new_style_events
  end
  
  def update
    @board.add_brick(@current_brick) unless @current_brick.nil?
    @current_brick = nil
    @event_queue.each do |ev|
      case ev
        when KeyDownEvent
          handle_keys(ev)
        when QuitEvent
          quit
      end
    end
    @screen.update()
  end
  
  def handle_keys(ev)
    case ev.key
    when K_RIGHT
      @board.brick.move_right if @board.move_possible?(:right)
    when K_LEFT
      @board.brick.move_left if @board.move_possible?(:left)
    when K_UP
      @board.brick.rotate
    when K_DOWN
      @board.brick.move_down if @board.move_possible?(:down)
    when K_ESCAPE
      quit
    end
  end
  
  def draw
    @board.draw(@screen)
    @screen.update
  end
  
  def quit
    Rubygame.quit()
    exit
  end
  
end