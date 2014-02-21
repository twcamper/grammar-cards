# encoding: utf-8
require 'curses'

module GrammarCards
  module TextDisplay

    COLOR_PAIR = 1
    def self.view(deck_size)
      Curses.init_screen
      begin
        Curses.cbreak      # user input is immediately available to the program
        Curses.noecho      # don't echo keyboard input
        Curses.curs_set 0  # invisible cursor; keeps line centering code simple below

        # enables color in curses
        Curses.start_color
        # redefine color enum 4
        Curses.init_color(Curses::COLOR_BLUE, 0, 0, 110)
        # define a FG, BG pair for use by the window later
        Curses.init_pair(COLOR_PAIR, Curses::COLOR_YELLOW, Curses::COLOR_BLUE)

        yield View.new deck_size

      rescue Exception => e
      ensure
        Curses.close_screen # IMPORTANT!!  Without, the terminal will be messed up after termination.
        if e  # curses has it's own stderr, so we have to wait to write anything the user can see
          STDERR.puts e
          STDERR.puts e.backtrace
        end
      end
    end

    module StaticMethods
      def height
        Curses.lines * 0.6
      end

      def width
        Curses.cols * 0.6
      end

      def top
        Curses.lines * 0.2
      end

      def left
        Curses.cols * 0.2
      end
    end

    class View
      include Curses
      extend StaticMethods

      def initialize(total)
        @total = total
        @win = Window.new(self.class.height,
                          self.class.width,
                          self.class.top,
                          self.class.left)
        @win.attrset Curses::A_BOLD
        @win.color_set COLOR_PAIR
        @win.keypad true  # enables Key::UP, Key::PPAGE, etc
      end

      def write_center(s)
        @win.addstr s.center(self.class.width)
      end

      def paint_window
        self.class.height.to_i.times do |i|
          # uses background color arg to Curses.init_pair
          write_center " "
        end
      end

      def new_card(number)
        @win.clear
        paint_window
        @win.setpos(self.class.height - 2,
                    self.class.width  - 10 )
        @win.addstr "#{number} / #{@total}"
      end

      def show_front(s)
        vert = (self.class.height / 2 ) - 2
        @win.setpos(vert, 0)
        write_center(s)
        @win.refresh

        case @win.getch
        when /^[q]$/i
          :quit
        when Key::LEFT, Key::UP, Key::PPAGE, /^[bpu]$/i
          :prev
        when Key::RIGHT, Key::NPAGE, /^[nsf]$/i
          :skip
        end
      end

      def show_back(s)
        rule_line_vert = (self.class.height / 2 )
        @win.setpos(rule_line_vert, 0)
        write_center("-" * s.length)
        @win.setpos(rule_line_vert + 2, 0)
        write_center(s)
        @win.refresh

        case @win.getch
        when /^[q]$/i
          :quit
        when Key::LEFT, Key::UP, Key::PPAGE, /^[bpu]$/i
          :prev
        end
      end

    end
  end
end
