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

    module WindowSize
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

      def initialize(total)
        @total = total
      end

      def new_card(card)
        @card_view = CardView.new(card, @total)
      end

      def show_front
        @card_view.show_front
      end

      def show_back
        @card_view.show_back
      end

    end

    class CardView
      include Curses
      extend WindowSize

      def initialize(card, deck_total)
        @card = card
        @deck_total = deck_total
        new_window
        write_stats_line
      end

      def new_window
        @win = Window.new(CardView.height,
                          CardView.width,
                          CardView.top,
                          CardView.left)
        @win.attrset Curses::A_BOLD
        @win.color_set COLOR_PAIR
        @win.keypad true  # enables Key::UP, Key::PPAGE, etc
        paint_window
      end

      def write_line(y, x, s)
        @win.setpos(y, x)
        write_center(s)
      end

      def write_lines(y, x, a)
        @win.setpos(y, x)
        a.each {|line| write_center line }
      end

      def write_center(s)
        @win.addstr s.center(CardView.width)
      end

      def paint_window
        CardView.height.to_i.times do |i|
          # uses background color arg to Curses.init_pair
          write_center " "
        end
      end

      def write_stats_line
        @win.setpos(CardView.height - 2,
                    CardView.width  - 10 )
        @win.addstr "#{@card.sequence_number} / #{@deck_total}"
      end

      def redraw
        @win.clear
        @win.close
        clear
        refresh
        new_window
        write_stats_line
        write_front
        write_back if @back_shown
      end

      def write_front
        lines = @card.front.split "\n"
        offset = 1 + lines.size
        y = (CardView.height / 2 ) - offset
        write_lines(y, 0, lines)
      end

      def write_horizontal_rule
        hr_length = [@card.front.length, @card.back.length].max
        if hr_length > CardView.width
          hr_length = CardView.width - 2
        end
        rule_line_y = (CardView.height / 2 )
        write_line(rule_line_y, 0, "-" * hr_length)
        rule_line_y
      end

      def write_back
        hr_y = write_horizontal_rule
        write_lines(hr_y + 2, 0, @card.back.split("\n"))
        @back_shown = true
      end

      def show_front
        write_front
        while (ch = @win.getch) == Key::RESIZE do
          redraw
        end

        case ch
        when /^[q]$/i
          :quit
        when Key::LEFT, Key::UP, Key::PPAGE, /^[bpu]$/i
          :prev
        when Key::RIGHT, Key::NPAGE, /^[nsf]$/i
          :skip
        end
      end

      def show_back
        write_back
        while (ch = @win.getch) == Key::RESIZE do
          redraw
        end

        case ch
        when /^[q]$/i
          :quit
        when Key::LEFT, Key::PPAGE, /^[bpu]$/i
          :prev
        when Key::UP
          :review
        end
      end

    end
  end
end
