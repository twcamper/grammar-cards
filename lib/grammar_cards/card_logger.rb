# encoding: utf-8

module GrammarCards
  module CardLogger

    LOG_PATH = File.expand_path('../data', File.dirname($0))
    LOG_FILE = File.join(LOG_PATH, "nouns-used-per-structure.yml")

    class LogFile
      def initialize
        @log_data = GrammarCards::CardLogger.read_log_file
      end

      def index_for(structure_record)
        @log_data.index do |item|
          item[0] == card.structure_record[0] && item[1] == card.structure_record[1]
        end
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
      i = nouns_used_per_structure.index do |item|
        item[0] == card.structure_data[0] && item[1] == card.structure_data[1]
      end
      if i
        nouns_used_per_structure[i].last << card.noun_data
      else
        nouns_used_per_structure << card.structure_data
        nouns_used_per_structure.last << [card.noun_data]
      end

      File.write(LOG_FILE, Psych.dump(nouns_used_per_structure))
    end

    extend CardLogger
  end
end
