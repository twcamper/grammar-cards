# encoding: utf-8
require 'pg'  # postgresql

module GrammarCards
  module Verbs

    def db
      @@db ||= PG.connect( dbname: 'verbos' )
    end

    def english(i)
      result = db.query("SELECT english FROM infinitive WHERE infinitive = '#{i}'")
      # raise "No data for '#{i}'" if result.values.empty?
      return "No data for '#{i}'" if result.values.empty?
      result.first["english"]
    end

    def disconnect_db
      @@db.close if @@db
    end

    extend Verbs
  end
end
