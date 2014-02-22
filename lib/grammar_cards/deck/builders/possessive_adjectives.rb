# encoding: utf-8

module GrammarCards
  module Deck
    module Builders
      module PossessiveAdjectives

        DATA_PATH = File.expand_path('../data', File.dirname($0))
        NOUN_FILE = File.join(DATA_PATH, "nombres-sostantivos.yml")
        POSSESSIVE_ADJECTIVE_STRUCTURE_FILE = File.join(DATA_PATH, "adjetivos-posesivos.yml")

        def shuffle_structures
          ordered_structures = Psych.load_file(POSSESSIVE_ADJECTIVE_STRUCTURE_FILE)

          shuffled = []
          until ordered_structures.empty?
            shuffled << ordered_structures.delete_at(rand(ordered_structures.size))
          end
          shuffled
        end

        # m, f, or both
        def nouns_by_gender(gender)
          @@noun_data ||= Psych.load_file(NOUN_FILE)
          case gender
          when :m
            @@masculine ||= @@noun_data.select {|n| n[:gen] == :m}
          when :f
            @@feminine  ||= @@noun_data.select {|n| n[:gen] == :f}
          else
            @@noun_data
          end

        end

        # nouns unused in past runs by the current structure
        def unused_nouns(structure_record, noun_superset)
          (@@log_file ||= GrammarCards::Cards::PossessiveAdjectiveLogger::LogFile.new).
            nouns_unused_by(structure_record, noun_superset)
        end

        def candidate_list(structure_record)
          unused = unused_nouns(structure_record, nouns_by_gender(structure_record[0][:gen]))
          if (diff = unused - used_in_this_deck).empty?
            unused
          else
            diff
          end
        end

        def used_in_this_deck
          @@used_in_this_deck ||= []
        end

        def random_noun(structure_record)
          list = candidate_list(structure_record)
          used_in_this_deck << list[rand(list.size)]
          used_in_this_deck.last
        end

        def build
          deck = []
          shuffle_structures.each_with_index do |structure_record, i|
            deck << Cards::PossessiveAdjective.new(random_noun(structure_record),
                             structure_record,
                             i + 1)
          end
          deck
        end

        extend PossessiveAdjectives
      end
    end
  end
end
