# encoding: utf-8
require 'curses'

module GrammarCards
  module TextDisplay

    def self.view(deck_size)
      Curses.init_screen
      begin
        Curses.cbreak
        Curses.noecho
        Curses.curs_set 0
        yield View.new deck_size
      rescue Exception => e
      ensure
        Curses.close_screen
        if e
          STDERR.puts e
          STDERR.puts e.backtrace
        end
      end
    end

    module StaticMethods
      def height
        Curses.lines * 0.8
      end

      def width
        Curses.cols * 0.8
      end

      def top
        Curses.lines * 0.1
      end

      def left
        Curses.cols * 0.1
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
      end

      def write_center(s)
        @win.addstr s.center(self.class.width)
      end

      def new_card(number)
        @win.clear
        @win.setpos(self.class.height / 4, self.class.width / 4)
        @win.addstr "#{number}/#{@total}"
      end

      def show_front(s)
        vert = (self.class.height / 2 ) - 2
        @win.setpos(vert, 0)
        write_center(s)
        @win.refresh
      end

      def show_back(s)
        rule_line_vert = (self.class.height / 2 )
        @win.setpos(rule_line_vert, 0)
        write_center("-" * s.length)
        @win.setpos(rule_line_vert + 2, 0)
        write_center(s)
        @win.refresh
      end

      def continue?
        @win.getch !~ /^[qQ]$/
      end

    end
  end
end
