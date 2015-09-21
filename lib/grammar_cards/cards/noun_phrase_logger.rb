# encoding: utf-8

module GrammarCards
  module Cards
    class NounPhraseLogger

      LOG_PATH = File.expand_path('../log', File.dirname($0))
      FILE = File.join(LOG_PATH,"nouns-used.yml")

      def initialize(ignore_log)
        @ignore_log = ignore_log
      end

      def dump(log_data)
        FileUtils.mkdir LOG_PATH unless File.exist? LOG_PATH
        File.write(FILE, Psych.dump(log_data))
      end

      def logged_nouns
        if @ignore_log || !File.exist?(FILE)
          return []
        end
        Psych.load_file(FILE) || []
      end

      def log(card)
        return if @ignore_log
        nouns_used = logged_nouns
        unless nouns_used.find {|n| n == card.noun_data }
          nouns_used << card.noun_data
          nouns_used.sort! {|a,b| a[:rnk].to_i <=> b[:rnk].to_i }
          dump(nouns_used)
        end
      end

    end
  end
end
