# encoding: utf-8
require 'pg'  # postgresql

module GrammarCards
  class Verbs

    def initialize
      @db = PG.connect( dbname: 'verbos' )
    end

    def english(i)
      result = @db.query("SELECT english FROM infinitive WHERE infinitive = '#{i}'")
      # raise "No data for '#{i}'" if result.values.empty?
      return "No data for '#{i}'" if result.values.empty?
      result.first["english"]
    end

    def form_data(tense, mood, inf, form)
      result = @db.query("SELECT i.english, v.#{form} AS conjugation
                        FROM infinitive i, verbs v
                        WHERE i.infinitive = v.infinitive
                        AND   v.tense      = '#{tense}'
                        AND   v.mood       = '#{mood}'
                        AND   i.infinitive = '#{inf}';")
      raise "No data for '#{tense}','#{mood}', '#{inf}', '#{form}'" if result.values.empty?
      {eng: result.first["english"], esp: result.first["conjugation"], inf: inf}
    end

    def disconnect
      @db.close
    end

  end
end
