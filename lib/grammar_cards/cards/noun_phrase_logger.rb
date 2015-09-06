# encoding: utf-8

module GrammarCards
  module Cards
    module NounPhraseLogger

      LOG_PATH = File.expand_path('../log', File.dirname($0))
      LOG_FILE = File.join(LOG_PATH, "nouns-used.yml")

      def unused_nouns(noun_superset)
        log_data = GrammarCards::Cards::NounPhraseLogger.read_log_file
        diff = noun_superset - log_data
        if diff.empty?  # all nouns have been used
          log_data = []
          GrammarCards::Cards::NounPhraseLogger.dump(log_data)
          noun_superset
        else
          diff
        end
      end

      def dump(log_data)
        FileUtils.mkdir LOG_PATH unless File.exist? LOG_PATH
        File.write(LOG_FILE, Psych.dump(log_data))
      end

      def read_log_file
        return [] unless File.exist? LOG_FILE
        Psych.load_file(LOG_FILE) || []
      end

      def log(card)
        nouns_used = read_log_file
        unless nouns_used.find {|n| n == card.noun_data }
          nouns_used << card.noun_data
        end

        dump(nouns_used)
      end

      extend NounPhraseLogger
    end
  end
end
