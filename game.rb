class Game
  
  def initialize
    setup_screen
    setup_event_queue
    setup_clock
    @board          = Board.new(ROWS, COLS)
    @current_brick  = Brick.new()
    #@next_brick     = Brick.new
    
    @background.blit(@screen,[0,0])
    @screen.update()
  end
  
  def run
    loop do
      update
      draw      
      @clock.tick
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
        when Rubygame::QuitEvent
          Rubygame.quit
          exit
      end
    end
    @screen.update()
  end
  
  def draw
    #@screen.fill([40,40,150],rect1)
    
    #@board.screen.blit(background,[50,50],[0,0,90,80])
    @board.draw(@screen)
    @screen.update
  end
  
  def quit
    Rubygame.quit()
  end
  
end