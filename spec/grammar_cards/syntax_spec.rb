# encoding: utf-8
require 'spec_helper'

module GrammarCards
  module Syntax

    describe PossessiveNounPhrase do
      it "should return Spanish for feminine plural noun, 3rd masculine plural owner" do
        noun = GrammarCards::Words::Noun.new("pluma f pen", :p)
        phrase = PossessiveNounPhrase.spanish(noun, :person => 3, :gender => :m, :number => :p)
        expect(phrase).to eq 'las plumas de ellos'
      end

      it "should return Spanish for  masculine singular noun, 2nd singular owner" do
        noun = GrammarCards::Words::Noun.new("libro m book", :s)
        phrase = PossessiveNounPhrase.spanish(noun, :person => 2, :number => :s)
        expect(phrase).to eq 'el libro de Ud.'
      end
    end

    describe PossessiveAdjectivalNounPhrase do

    end

  end
end

