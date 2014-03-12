# encoding: utf-8

module GrammarCards
  module Cards

    class Ending < CardBase
      attr_reader :front, :back
      def initialize(eng, inf)
        @front = inf.sub(/[aei]r$/, '-')
        @back = "#{inf}\n\n#{eng}"
        @done = false
      end

    end
  end
end

