# encoding: utf-8
require 'date'

module GrammarCards
  module Deck
    module Builders
      module Conjugations
        extend DeckHelper

        DATA_PATH = File.join(File.expand_path('../data', File.dirname($0)), "lexis", "verbs")
        class Builder

          VERB_FORMS = [:s1, :s2, :s3, :p1, :p2, :p3]

          def initialize(tense, mood, file_name, db)
            @tense, @mood, @file_name, @db = tense, mood, file_name, db
            @infinitives = File.read(File.join(DATA_PATH, file_name)).split
            @log_file = GrammarCards::Cards::ConjugationLogger::LogFile.new file_name
          end

          def unused_verbs(form)
            @log_file.words_unused_by(form, @infinitives)
          end

          def candidate_list(verb_form)
            unused = unused_verbs(verb_form)
            if (diff = unused - used_in_this_deck).empty?
              unused
            else
              diff
            end
          end

          def used_in_this_deck
            @used_in_this_deck ||= []
          end

          def random_verb(verb_form)
            list = candidate_list(verb_form)

            # some columns are empty for certain forms of certain verbs
            # e.g. 'you snow' isn't populated
            verb_data = {esp: ''}
            while verb_data[:esp].empty? do
              candidate = list.delete_at(rand(list.size))
              verb_data = @db.form_data(@tense, @mood, candidate, verb_form)
            end
            used_in_this_deck << candidate
            verb_data
          end

          def build
            cards = []
            VERB_FORMS.each do |form|
              cards << GrammarCards::Cards::Conjugation.new(@file_name, form, random_verb(form))
            end
            cards
          end
        end

        def build(tense, mood)
          deck = []
          db = GrammarCards::Verbs.new
          verb_files = Dir["#{DATA_PATH}/*"].map {|path| File.basename path }
          verb_files.each do |verb_file|
            deck += Builder.new(tense, mood, verb_file, db).build
          end

          db.disconnect
          shuffle deck
        end

        extend Conjugations
      end
    end
  end
end
