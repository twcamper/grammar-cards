# encoding: utf-8

module GrammarCards
  module CardLogger

    LOG_PATH = File.expand_path('../log', File.dirname($0))
    LOG_FILE = File.join(LOG_PATH, "nouns-used-per-structure.yml")

    # instance for the deck builder
    class LogFile
      def initialize
        @log_data = GrammarCards::CardLogger.read_log_file
      end

      def nouns_unused_by(structure_record, noun_superset)
        used = []
        if (i = GrammarCards::CardLogger.index_for(@log_data, structure_record))
          used = @log_data[i][2] || []
        end

        diff = noun_superset - used
        if diff.empty?  # all nouns have been used
          @log_data[i][2] = []
          GrammarCards::CardLogger.dump(@log_data)
          noun_superset
        else
          diff
        end
      end
    end

    def index_for(log_data, structure_record)
      log_data.index do |item|
        item[0] == structure_record[0] && item[1] == structure_record[1]
      end
    end

    def dump(log_data)
      File.write(LOG_FILE, Psych.dump(log_data))
    end

    def read_log_file
      return [] unless File.exist? LOG_FILE
      Psych.load_file(LOG_FILE) || []
    end

    def log(card)
      nouns_used_per_structure = read_log_file
      if (i = index_for(nouns_used_per_structure, card.structure_data))
        nouns_used_per_structure[i].last << card.noun_data
      else
        nouns_used_per_structure << card.structure_data
        nouns_used_per_structure.last << [card.noun_data]
      end

      dump(nouns_used_per_structure)
    end

    extend CardLogger
  end
end
