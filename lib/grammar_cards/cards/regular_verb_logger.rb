# encoding: utf-8

module GrammarCards
  module Cards
    module RegularVerbLogger

      LOG_PATH = File.expand_path('../log', File.dirname($0))
      LOG_FILE = File.join(LOG_PATH, "verbs-used-per-subject.yml")

      # instance for the deck builder
      class LogFile
        WORD_LIST_INDEX = 1
        def initialize
          @log_data = GrammarCards::Cards::RegularVerbLogger.read_log_file
        end

        def words_unused_by(structure_record, superset)
          used = []
          if (i = GrammarCards::Cards::RegularVerbLogger.index_for(@log_data, structure_record))
            used = @log_data[i][WORD_LIST_INDEX] || []
          end

          diff = superset - used
          if diff.empty?  # all words have been used
            @log_data[i][WORD_LIST_INDEX] = []
            GrammarCards::Cards::RegularVerbLogger.dump(@log_data)
            superset
          else
            diff
          end
        end
      end

      def index_for(log_data, structure_record)
        log_data.index do |item|
          item[0] == structure_record[0]
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
        words_used_per_structure = read_log_file
        if (i = index_for(words_used_per_structure, card.structure_data))
          words_used_per_structure[i].last << card.word_data
        else
          words_used_per_structure << card.structure_data
          words_used_per_structure.last << [card.word_data]
        end

        dump(words_used_per_structure)
      end

      extend RegularVerbLogger
    end
  end
end
