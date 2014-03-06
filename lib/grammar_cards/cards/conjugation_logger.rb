# encoding: utf-8

module GrammarCards
  module Cards
    module ConjugationLogger

      LOG_PATH = File.expand_path('../log', File.dirname($0))

      # instance for the deck builder
      class LogFile

        def initialize(verb_type)
          @file      = GrammarCards::Cards::ConjugationLogger.filename(verb_type)
          @log_data = GrammarCards::Cards::ConjugationLogger.read_log_file(@file)
        end

        def words_unused_by(verb_form, superset)
          used = @log_data[verb_form]

          diff = superset - used
          if diff.empty?  # all words have been used
            @log_data[verb_form] = []
            GrammarCards::Cards::ConjugationLogger.dump(@file, @log_data)
            superset
          else
            diff
          end
        end
      end

      def filename(verb_type)
        File.join(LOG_PATH, "#{verb_type}-used-per-form.yml")
      end

      def dump(lf, log_data)
        FileUtils.mkdir LOG_PATH unless File.exist? LOG_PATH
        File.write(lf, Psych.dump(log_data))
      end

      def read_log_file(lf)
        FileUtils.touch(lf) unless File.exist?(lf)
        Psych.load_file(lf) || {s1: [], s2: [], s3: [], p1: [], p2: [], p3: []}
      end

      def log(card)
        file = filename(card.verb_type)
        verbs_used_per_form = read_log_file(file)
        verbs_used_per_form[card.verb_form] << card.word_data

        dump(file, verbs_used_per_form)
      end

      extend ConjugationLogger
    end
  end
end
