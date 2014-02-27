# encoding: utf-8

module GrammarCards
  module Cards
    module RegularVerbLogger

      LOG_PATH = File.expand_path('../log', File.dirname($0))

      # instance for the deck builder
      class LogFile

        def initialize(verb_type)
          @file      = GrammarCards::Cards::RegularVerbLogger.filename(verb_type)
          @log_data = GrammarCards::Cards::RegularVerbLogger.read_log_file(@file)
        end

        def words_unused_by(verb_form, superset)
          used = @log_data[verb_form]

          diff = superset - used
          if diff.empty?  # all words have been used
            @log_data[verb_form] = []
            GrammarCards::Cards::RegularVerbLogger.dump(@file, @log_data)
            superset
          else
            diff
          end
        end
      end

      def filename(verb_type)
        File.join(LOG_PATH, "#{verb_type}-verbs-used-per-form.yml")
      end

      def dump(lf, log_data)
        FileUtils.mkdir LOG_PATH unless File.exist? LOG_PATH
        File.write(lf, Psych.dump(log_data))
      end

      def read_log_file(lf)
        FileUtils.touch(lf) unless File.exist?(lf)
        Psych.load_file(lf) || [[], [], [], [], [], []]
      end

      def log(card)
        verb_type = card.word_data[:esp].slice(-2,2)
        file = filename(verb_type)
        verbs_used_per_form = read_log_file(file)
        verbs_used_per_form[card.verb_form] << card.word_data

        dump(file, verbs_used_per_form)
      end

      extend RegularVerbLogger
    end
  end
end
